const std = @import("std");
const zigwin32 = @import("zigwin32");
const win32 = @import("win32_defs.zig");
const common = @import("common");
const utils = @import("utils.zig");
const icon = @import("icon.zig");
const monitor_impl = @import("monitor_impl.zig");
const WindowError = @import("errors.zig").WindowError;
const win32_window_messaging = zigwin32.ui.windows_and_messaging;
const win32_foundation = zigwin32.foundation;
const win32_gdi = zigwin32.graphics.gdi;
const win32_dwm = zigwin32.graphics.dwm;
const Win32Context = @import("global.zig").Win32Context;
const MonitorStore = @import("internals.zig").MonitorStore;
const Cursor = icon.Cursor;
const Icon = icon.Icon;
const WindowData = common.window_data.WindowData;
const WindowFlags = common.window_data.WindowFlags;
const FullScreenMode = common.window_data.FullScreenMode;
const DragAcceptFiles = zigwin32.ui.shell.DragAcceptFiles;
const SetFocus = zigwin32.ui.input.keyboard_and_mouse.SetFocus;

// Window Styles as defined by the SDL library.
// Basic : clip child and siblings windows when drawing to content.
const STYLE_BASIC: u32 = @enumToInt(win32_window_messaging.WS_CLIPCHILDREN) |
    @enumToInt(win32_window_messaging.WS_CLIPSIBLINGS);
// Fullscreen : just a popup window with monitor width and height.
const STYLE_FULLSCREEN: u32 = @enumToInt(win32_window_messaging.WS_POPUP) |
    @enumToInt(win32_window_messaging.WS_MINIMIZEBOX);
// Captionless: without a caption(title bar)
const STYLE_BORDERLESS: u32 = @enumToInt(win32_window_messaging.WS_POPUP) |
    @enumToInt(win32_window_messaging.WS_MINIMIZEBOX);
// Resizable : can be resized using the widow border can also be maximazed.
const STYLE_RESIZABLE: u32 = @enumToInt(win32_window_messaging.WS_THICKFRAME) |
    @enumToInt(win32_window_messaging.WS_MAXIMIZEBOX);
// Normal: both a title bar and minimize button.
const STYLE_NORMAL: u32 = @enumToInt(win32_window_messaging.WS_OVERLAPPED) |
    @enumToInt(win32_window_messaging.WS_MINIMIZEBOX) |
    @enumToInt(win32_window_messaging.WS_SYSMENU) |
    @enumToInt(win32_window_messaging.WS_CAPTION);

const STYLES_MASK: u32 = @enumToInt(win32_window_messaging.WS_OVERLAPPEDWINDOW) |
    @enumToInt(win32_window_messaging.WS_POPUP) |
    @enumToInt(win32_window_messaging.WS_MAXIMIZE) |
    @enumToInt(win32_window_messaging.WS_CLIPCHILDREN) |
    @enumToInt(win32_window_messaging.WS_CLIPSIBLINGS);

pub fn windowStyles(flags: *const WindowFlags) u32 {
    var styles: u32 = STYLE_BASIC;

    if (flags.is_fullscreen) {
        styles |= STYLE_FULLSCREEN;
    } else {
        if (!flags.is_decorated) {
            styles |= STYLE_BORDERLESS;
        } else {
            styles |= STYLE_NORMAL;
        }

        if (flags.is_resizable) {
            styles |= STYLE_RESIZABLE;
        }

        if (flags.is_maximized) {
            styles |= @enumToInt(win32_window_messaging.WS_MAXIMIZE);
        }

        if (flags.is_minimized) {
            styles |= @enumToInt(win32_window_messaging.WS_MINIMIZE);
        }
    }

    return styles;
}

pub fn windowExStyles(flags: *const WindowFlags) u32 {
    var ex_styles: u32 = 0;
    if (flags.is_fullscreen or flags.is_topmost) {
        // Should be placed above all non topmost windows.
        ex_styles |= @enumToInt(win32_window_messaging.WS_EX_TOPMOST);
    }
    return ex_styles;
}

/// Performs necessary adjustement for the rect structure.
/// this function modifies the rect so that it
/// describes a window rectangle which is the smallest rectangle
/// that encloses completely both client and non client(titlebar...)
/// areas.
pub fn adjustWindowRect(
    rect: *win32.RECT,
    styles: u32,
    ex_styles: u32,
    dpi: ?u32,
) void {
    const win32_globl = Win32Context.singleton().?;
    if (dpi != null and win32_globl.functions.AdjustWindowRectExForDpi != null) {
        _ = win32_globl.functions.AdjustWindowRectExForDpi.?(
            rect,
            styles,
            0,
            ex_styles,
            dpi.?,
        );
    } else {
        _ = win32_window_messaging.AdjustWindowRectEx(
            rect,
            @intToEnum(win32_window_messaging.WINDOW_STYLE, styles),
            0,
            @intToEnum(win32_window_messaging.WINDOW_EX_STYLE, ex_styles),
        );
    }
}

/// Returns the client area's rectangle that specify it's coordinates.
/// # Note
/// the coordinate for the upperleft corner returned by this function
/// are always (0,0), and do not reflect it's actual position on the screen
/// pass the returned rect to clientToScreen function to get the true upperleft
/// screen coordinates.
/// TODO: Get rid of this.
inline fn clientRect(window_handle: win32.HWND, rect: *win32.RECT) void {
    _ = win32_window_messaging.GetClientRect(window_handle, rect);
}

/// Converts client coordinate of a RECT structure to screen coordinate.
fn clientToScreen(window_handle: win32.HWND, rect: *win32.RECT) void {
    var upper_left = win32_foundation.POINT{
        .x = rect.left,
        .y = rect.top,
    };
    var lower_right = win32_foundation.POINT{
        .x = rect.right,
        .y = rect.bottom,
    };

    _ = win32_gdi.ClientToScreen(window_handle, &upper_left);
    _ = win32_gdi.ClientToScreen(window_handle, &lower_right);

    rect.* = win32.RECT{
        .left = upper_left.x,
        .top = upper_left.y,
        .right = lower_right.x,
        .bottom = lower_right.y,
    };
}

/// Returns the (width,height) of the entire window frame.
pub fn windowSize(window_handle: win32.HWND) common.geometry.WidowSize {
    var rect: win32.RECT = undefined;
    // TODO: Fix we want to report the true size but not cause any shrinking bug.
    // GetWindowRect populate the RECT with the window's size(drop shadow included).
    // var comp_enabled: win32.BOOL = win32.FALSE;
    //
    // if ((win32_dwm.DwmIsCompositionEnabled(&comp_enabled) == win32.S_OK) and comp_enabled == win32.TRUE) {
    //     // If Dwm Composition is enabled we can get the true window rect(no drop shadow)
    //     // by calling DwmGetWindowAttributes.
    //     if (win32_dwm.DwmGetWindowAttribute(
    //         window_handle,
    //         win32_dwm.DWMWA_EXTENDED_FRAME_BOUNDS,
    //         @ptrCast(*anyopaque, &rect),
    //         @sizeOf(win32.RECT),
    //     ) != win32.S_OK) {
    //         _ = win32_window_messaging.GetWindowRect(window_handle, &rect);
    //     }
    // } else {
    //     _ = win32_window_messaging.GetWindowRect(window_handle, &rect);
    // }
    _ = win32_window_messaging.GetWindowRect(window_handle, &rect);
    const size = common.geometry.WidowSize{
        .width = rect.right - rect.left,
        .height = rect.bottom - rect.top,
    };
    return size;
}

/// Updates the cursor image.
pub fn updateCursorImage(cursor: *const icon.Cursor) void {
    if (cursor.mode.is_disabled()) {
        return;
    }

    if (cursor.handle) |value| {
        _ = win32_window_messaging.SetCursor(value);
    } else {
        _ = win32_window_messaging.SetCursor(
            win32_window_messaging.LoadCursorW(null, win32_window_messaging.IDC_ARROW),
        );
    }
}

/// Limit the cursor motion to the client rectangle.
pub inline fn captureCursor(window_handle: win32.HWND) void {
    var clip_rect: win32.RECT = undefined;
    clientRect(window_handle, &clip_rect);
    // ClipCursor expects screen coordinates.
    clientToScreen(window_handle, &clip_rect);
    _ = win32_window_messaging.ClipCursor(&clip_rect);
}

/// Remove cursor motion limitation.
pub inline fn releaseCursor() void {
    _ = win32_window_messaging.ClipCursor(null);
}

/// Capture and hide the cursor from the user.
pub fn disableCursor(window_handle: win32.HWND) void {
    captureCursor(window_handle);
    _ = win32_window_messaging.SetCursor(null);
}

/// Show and release the cursor.
pub fn enableCursor(cursor: *const icon.Cursor) void {
    updateCursorImage(cursor);
    releaseCursor();
}

/// helper function for changing the window position,size and styles.
fn setWindowPositionIntern(
    window_handle: win32.HWND,
    top: ?win32.HWND,
    flags: u32,
    x: i32,
    y: i32,
    width: i32,
    height: i32,
) void {
    _ = win32_window_messaging.SetWindowPos(
        window_handle,
        top,
        x,
        y,
        width,
        height,
        @intToEnum(win32_window_messaging.SET_WINDOW_POS_FLAGS, flags),
    );
}

fn createPlatformWindow(
    allocator: std.mem.Allocator,
    title: []const u8,
    data: *const WindowData,
    styles: struct { u32, u32 },
) !win32.HWND {
    var window_rect = win32.RECT{
        .left = 0,
        .top = 0,
        .right = data.client_area.size.width,
        .bottom = data.client_area.size.height,
    };

    // Calculates the required size of the window rectangle,
    // based on the desired client-rectangle size.
    // Note: for the dpi adjustements we can either
    // query the system for the targted monitor(the one that intersect
    // the window frame rectangle)'s dpi value and adjust for it now
    // or do it after window creation, we will leave it for after creation.
    adjustWindowRect(&window_rect, styles[0], styles[1], null);

    // Decide the position(top left) of the client area
    var frame_x: i32 = undefined;
    var frame_y: i32 = undefined;
    if (data.client_area.top_left.x != win32_window_messaging.CW_USEDEFAULT and
        data.client_area.top_left.y != win32_window_messaging.CW_USEDEFAULT)
    {
        frame_x = data.client_area.top_left.x + window_rect.left;
        frame_y = data.client_area.top_left.y + window_rect.top;
    } else {
        frame_x = win32_window_messaging.CW_USEDEFAULT;
        frame_y = win32_window_messaging.CW_USEDEFAULT;
    }

    // Final window frame.
    const frame = .{
        frame_x,
        frame_y,
        window_rect.right - window_rect.left,
        window_rect.bottom - window_rect.top,
    };

    var buffer: [Win32Context.WINDOW_CLASS_NAME.len * 4]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const wide_class_name = utils.utf8ToWideZ(fba.allocator(), Win32Context.WINDOW_CLASS_NAME) catch unreachable;

    // Encode the title string in utf-16.
    const window_title = try utils.utf8ToWideZ(allocator, title);
    defer allocator.free(window_title);

    const creation_lparm = data;
    const win32_globl = Win32Context.singleton().?;

    // Create the window.
    const window_handle = win32_window_messaging.CreateWindowExW(
        @intToEnum(win32_window_messaging.WINDOW_EX_STYLE, styles[1]), // dwExStyles
        wide_class_name, // Window Class Name
        window_title, // Window Name
        @intToEnum(win32_window_messaging.WINDOW_STYLE, styles[0]), // dwStyles
        frame[0], // X
        frame[1], // Y
        frame[2], // width
        frame[3], // height
        null, // Parent Hwnd
        null, // hMenu
        win32_globl.handles.hinstance, // hInstance
        @ptrCast(?*anyopaque, @constCast(creation_lparm)), // CREATESTRUCT lparam
    ) orelse {
        return WindowError.FailedToCreate;
    };

    return window_handle;
}

/// Holds all the refrences we use to communitcate with the WidowContext.
pub const WidowProps = struct {
    monitors: *MonitorStore,
    events_queue: *common.event.EventQueue,
};

/// Win32 specific data.
pub const WindowWin32Data = struct {
    icon: Icon,
    cursor: icon.Cursor,
    restore_frame: ?common.geometry.WidowArea, // Used when going fullscreen to save restore coords.
    dropped_files: std.ArrayList([]const u8),
    high_surrogate: u16,
    frame_action: bool,
    size_pos_update: u8, // we will use this to filter repeating size and postion events.
    pub const NO_SIZE_POSITION_UPDATE = @as(u8, 0x00);
    pub const SIZE_UPDATE = @as(u8, 0x01);
    pub const POSITON_UPDATE = @as(u8, 0x02);
    pub const SIZE_POSITION_UPDATE = @as(u8, 0x03);
};

pub const WindowImpl = struct {
    data: WindowData,
    widow: WidowProps,
    win32: WindowWin32Data,
    handle: win32_foundation.HWND,
    pub const WINDOW_DEFAULT_POSITION = common.geometry.WidowPoint2D{
        .x = win32_window_messaging.CW_USEDEFAULT,
        .y = win32_window_messaging.CW_USEDEFAULT,
    };
    const Self = @This();

    pub fn setup(
        instance: *Self,
        allocator: std.mem.Allocator,
        window_title: []const u8,
    ) !void {
        const styles = .{ windowStyles(&instance.data.flags), windowExStyles(&instance.data.flags) };
        instance.handle = try createPlatformWindow(allocator, window_title, &instance.data, styles);

        // Process inital events.
        // these events aren't reported.
        instance.processEvents();

        // Finish setting up the window.
        instance.win32 = WindowWin32Data{
            .cursor = icon.Cursor{
                .handle = null,
                .mode = common.cursor.CursorMode.Normal,
                .shared = false,
            },
            .icon = Icon{
                .sm_handle = null,
                .bg_handle = null,
            },
            .high_surrogate = 0,
            .frame_action = false,
            .dropped_files = std.ArrayList([]const u8).init(allocator),
            .restore_frame = null,
            .size_pos_update = WindowWin32Data.NO_SIZE_POSITION_UPDATE,
        };

        _ = win32_window_messaging.SetWindowLongPtrW(
            instance.handle,
            win32_window_messaging.GWLP_USERDATA,
            @intCast(isize, @ptrToInt(instance)),
        );

        // Now we can handle DPI adjustments.
        if (instance.data.flags.allow_dpi_scaling) {
            var client_rect: win32.RECT = undefined;
            clientRect(instance.handle, &client_rect);
            var dpi_scale: f64 = undefined;
            const dpi = instance.scalingDPI(&dpi_scale);
            // the requested client width and height are scaled by the display scale factor.
            client_rect.right = @floatToInt(i32, @intToFloat(f64, client_rect.right) * dpi_scale);
            client_rect.bottom = @floatToInt(i32, @intToFloat(f64, client_rect.bottom) * dpi_scale);

            adjustWindowRect(
                &client_rect,
                styles[0],
                styles[1],
                dpi,
            );

            var window_rect: win32.RECT = undefined;
            // [MSDN]:If the window has not been shown before,
            // GetWindowRect will not include the area of the drop shadow.
            _ = win32_window_messaging.GetWindowRect(instance.handle, &window_rect);
            // Offset and readjust the created window's frame.
            _ = win32_gdi.OffsetRect(
                &client_rect,
                window_rect.left - client_rect.left,
                window_rect.top - client_rect.top,
            );

            const top = if (instance.data.flags.is_topmost)
                win32_window_messaging.HWND_TOPMOST
            else
                win32_window_messaging.HWND_NOTOPMOST;
            const POSITION_FLAGS: u32 = comptime @enumToInt(win32_window_messaging.SWP_NOZORDER) |
                @enumToInt(win32_window_messaging.SWP_NOACTIVATE) |
                @enumToInt(win32_window_messaging.SWP_NOOWNERZORDER);
            setWindowPositionIntern(
                instance.handle,
                top,
                POSITION_FLAGS,
                client_rect.left,
                client_rect.top,
                client_rect.right - client_rect.left,
                client_rect.bottom - client_rect.top,
            );
        }

        // Allow Drag & Drop messages.
        if (Win32Context.singleton().?.flags.is_win7_or_above) {
            // Sent when the user drops a file on the window [Windows XP minimum]
            _ = win32_window_messaging.ChangeWindowMessageFilterEx(
                instance.handle,
                win32_window_messaging.WM_DROPFILES,
                win32_window_messaging.MSGFLT_ALLOW,
                null,
            );
            _ = win32_window_messaging.ChangeWindowMessageFilterEx(
                instance.handle,
                win32_window_messaging.WM_COPYDATA,
                win32_window_messaging.MSGFLT_ALLOW,
                null,
            );
            _ = win32_window_messaging.ChangeWindowMessageFilterEx(
                instance.handle,
                win32.WM_COPYGLOBALDATA,
                win32_window_messaging.MSGFLT_ALLOW,
                null,
            );
        }

        if (instance.data.flags.is_visible) {
            instance.show();
            if (instance.data.flags.is_focused) {
                instance.focus();
            }
        }

        // Fullscreen
        if (instance.data.flags.is_fullscreen) {
            instance.data.flags.is_fullscreen = false;
            try instance.setFullscreen(true, null);
        }
    }

    pub fn close(self: *Self) void {
        // Clean up code
        if (self.data.flags.is_fullscreen) {
            // release the currently occupied monitor
            self.setFullscreen(false, null) catch unreachable;
        }
        if (self.win32.cursor.mode.is_captured()) {
            releaseCursor();
        }
        if (self.win32.cursor.mode.is_disabled()) {
            enableCursor(&self.win32.cursor);
        }
        _ = win32_window_messaging.SetWindowLongPtrW(self.handle, win32_window_messaging.GWLP_USERDATA, 0);
        _ = win32_window_messaging.DestroyWindow(self.handle);
        self.freeDroppedFiles();
    }

    pub fn deinit(self: *Self) void {
        self.close();
    }

    /// Shows the hidden window.
    pub fn show(self: *Self) void {
        // Show without activating.
        _ = win32_window_messaging.ShowWindow(self.handle, win32_window_messaging.SW_SHOWNA);
        self.data.flags.is_visible = true;
    }

    pub fn focus(self: *Self) void {
        _ = win32_window_messaging.BringWindowToTop(self.handle);
        _ = win32_window_messaging.SetForegroundWindow(self.handle);
        _ = SetFocus(self.handle);
    }

    pub fn scalingDPI(self: *const Self, scaler: ?*f64) u32 {
        const win32_globl = Win32Context.singleton().?;
        var dpi: u32 = win32.USER_DEFAULT_SCREEN_DPI;
        err_exit: {
            if (win32_globl.functions.GetDpiForWindow) |proc| {
                dpi = proc(self.handle);
            } else {
                // let's query the monitor's dpi.
                const monitor_handle = win32_gdi.MonitorFromWindow(self.handle, win32_gdi.MONITOR_DEFAULTTONEAREST) orelse break :err_exit;
                dpi = monitor_impl.monitorDPI(monitor_handle);
            }
        }
        if (scaler) |ptr| {
            ptr.* = (@intToFloat(f64, dpi) / @intToFloat(f64, win32.USER_DEFAULT_SCREEN_DPI));
        }
        return dpi;
    }

    /// the window should belong to the thread calling this function.
    pub fn processEvents(self: *Self) void {
        var msg: win32_window_messaging.MSG = undefined;
        while (win32_window_messaging.PeekMessageW(&msg, self.handle, 0, 0, win32_window_messaging.PM_REMOVE) != 0) {
            _ = win32_window_messaging.TranslateMessage(&msg);
            _ = win32_window_messaging.DispatchMessageW(&msg);
        }
        // Emit key up for released modifers keys.
        utils.clearStickyKeys(self);
    }

    /// Add an event to the events queue.
    pub fn sendEvent(self: *Self, event: *const common.event.Event) void {
        self.widow.events_queue.queueEvent(event);
    }

    /// the window should belong to the thread calling this function.
    pub fn waitEvent(self: *Self) void {
        _ = win32_window_messaging.WaitMessage();
        self.processEvents();
    }

    /// the window should belong to the thread calling this function.
    /// Waits for an input event or the timeout interval elapses.
    pub fn waitEventTimeout(self: *Self, timeout: u32) bool {
        if (win32_window_messaging.MsgWaitForMultipleObjects(
            0,
            null,
            0,
            timeout,
            win32_window_messaging.QS_ALLINPUT,
        ) == win32.WAIT_TIMEOUT) {
            // Timeout period elapsed.
            return false;
        }
        self.processEvents();
        return true;
    }

    /// Updates the registered window styles to match the current window config.
    fn updateStyles(self: *Self) void {
        const EX_STYLES_MASK: u32 = @enumToInt(win32_window_messaging.WS_EX_TOPMOST);
        const POSITION_FLAGS: u32 = comptime @enumToInt(win32_window_messaging.SWP_FRAMECHANGED) |
            @enumToInt(win32_window_messaging.SWP_NOACTIVATE) |
            @enumToInt(win32_window_messaging.SWP_NOZORDER);

        var reg_styles = @bitCast(usize, win32_window_messaging.GetWindowLongPtrW(
            self.handle,
            win32_window_messaging.GWL_STYLE,
        ));
        var reg_ex_styles = @bitCast(usize, win32_window_messaging.GetWindowLongPtrW(
            self.handle,
            win32_window_messaging.GWL_EXSTYLE,
        ));
        reg_styles &= ~STYLES_MASK;
        reg_ex_styles &= ~EX_STYLES_MASK;
        reg_styles |= windowStyles(&self.data.flags);
        reg_ex_styles |= windowExStyles(&self.data.flags);

        _ = win32_window_messaging.SetWindowLongPtrW(
            self.handle,
            win32_window_messaging.GWL_STYLE,
            @bitCast(isize, reg_styles),
        );

        _ = win32_window_messaging.SetWindowLongPtrW(
            self.handle,
            win32_window_messaging.GWL_EXSTYLE,
            @bitCast(isize, reg_ex_styles),
        );

        var rect = win32_foundation.RECT{
            .left = 0,
            .top = 0,
            .right = 0,
            .bottom = 0,
        };

        if (self.win32.restore_frame) |*frame| {
            // we're exiting fullscreen mode use the saved size.
            rect.left = frame.top_left.x;
            rect.top = frame.top_left.y;
            rect.right = frame.size.width + rect.left;
            rect.bottom = frame.size.height + rect.top;
        } else {
            // we're simply changing some styles.
            rect.left = self.data.client_area.top_left.x;
            rect.top = self.data.client_area.top_left.y;
            rect.right = self.data.client_area.size.width + rect.left;
            rect.bottom = self.data.client_area.size.height + rect.top;
        }

        var dpi: ?u32 = null;

        if (self.data.flags.allow_dpi_scaling) {
            dpi = self.scalingDPI(null);
        }

        adjustWindowRect(
            &rect,
            @truncate(u32, reg_styles),
            @truncate(u32, reg_ex_styles),
            dpi,
        );

        const top = if (self.data.flags.is_topmost)
            win32_window_messaging.HWND_TOPMOST
        else
            win32_window_messaging.HWND_NOTOPMOST;

        setWindowPositionIntern(
            self.handle,
            top,
            POSITION_FLAGS,
            rect.left,
            rect.top,
            (rect.right - rect.left),
            (rect.bottom - rect.top),
        );
    }

    pub fn cursorPositon(self: *const Self) common.geometry.WidowPoint2D {
        var cursor_pos: win32_foundation.POINT = undefined;
        _ = win32_window_messaging.GetCursorPos(&cursor_pos);
        _ = win32_gdi.ScreenToClient(self.handle, &cursor_pos);
        // the cursor_pos is relative to the upper left corner of the window.
        return common.geometry.WidowPoint2D{ .x = cursor_pos.x, .y = cursor_pos.y };
    }

    pub fn setCursorPosition(self: *const Self, x: i32, y: i32) void {
        var point = win32_foundation.POINT{
            .x = x,
            .y = y,
        };
        _ = win32_gdi.ClientToScreen(self.handle, &point);
        _ = win32_window_messaging.SetCursorPos(point.x, point.y);
    }

    pub fn setCursorMode(self: *Self, mode: common.cursor.CursorMode) void {
        if (self.win32.cursor.mode == mode) {
            return;
        }
        self.win32.cursor.mode = mode;
        enableCursor(&self.win32.cursor);
        switch (mode) {
            common.cursor.CursorMode.Captured => captureCursor(self.handle),
            common.cursor.CursorMode.Disabled => disableCursor(self.handle),
            else => {},
        }
    }

    /// Notify and flash the taskbar.
    pub fn flash(self: *const Self) void {
        var flash_info = win32_window_messaging.FLASHWINFO{
            .cbSize = @sizeOf(win32_window_messaging.FLASHWINFO),
            .hwnd = self.handle,
            .dwFlags = win32_window_messaging.FLASHW_ALL,
            .uCount = 3,
            .dwTimeout = 0,
        };
        _ = win32_window_messaging.FlashWindowEx(&flash_info);
    }

    /// Returns the position of the top left corner of the client area.
    pub fn clientPosition(self: *const Self) common.geometry.WidowPoint2D {
        return self.data.client_area.top_left;
    }

    /// Moves the client's top left corner
    /// to the specified screen coordinates.
    pub fn setClientPosition(self: *const Self, x: i32, y: i32) void {
        // Don't use SWP_NOSIZE to allow dpi change.
        const POSITION_FLAGS: u32 = comptime @enumToInt(win32_window_messaging.SWP_NOZORDER) |
            @enumToInt(win32_window_messaging.SWP_NOACTIVATE) |
            @enumToInt(win32_window_messaging.SWP_NOREPOSITION);

        if (self.data.flags.is_maximized) {
            // Moving a maximized window should restore it to it's orignal size
            self.restore();
        }

        var rect: win32.RECT = win32.RECT{
            .left = 0,
            .top = 0,
            .right = self.data.client_area.size.width,
            .bottom = self.data.client_area.size.height,
        };

        var dpi: ?u32 = null;

        if (self.data.flags.allow_dpi_scaling) {
            dpi = self.scalingDPI(null);
        }

        adjustWindowRect(
            &rect,
            windowStyles(&self.data.flags),
            windowExStyles(&self.data.flags),
            dpi,
        );

        rect.left += x;
        rect.top += y;

        const top = if (self.data.flags.is_topmost)
            win32_window_messaging.HWND_TOPMOST
        else
            win32_window_messaging.HWND_NOTOPMOST;

        setWindowPositionIntern(
            self.handle,
            top,
            POSITION_FLAGS,
            rect.left,
            rect.top,
            rect.right - rect.left,
            rect.bottom - rect.top,
        );
    }

    /// Returns the Size of the window's client area
    pub fn clientSize(self: *const Self) common.geometry.WidowSize {
        return common.geometry.WidowSize{
            .width = self.data.client_area.size.width,
            .height = self.data.client_area.size.height,
        };
    }

    /// Sets the new (width,height) of the window's client area
    pub fn setClientSize(self: *Self, size: *common.geometry.WidowSize) void {
        var dpi: ?u32 = null;
        if (self.data.flags.allow_dpi_scaling) {
            var scaler: f64 = undefined;
            dpi = self.scalingDPI(&scaler);
            size.scaleBy(scaler);
        }

        var new_client_rect = win32_foundation.RECT{
            .left = 0,
            .top = 0,
            .right = size.width,
            .bottom = size.height,
        };

        adjustWindowRect(
            &new_client_rect,
            windowStyles(&self.data.flags),
            windowExStyles(&self.data.flags),
            dpi,
        );
        if (self.data.flags.is_maximized) {
            // un-maximize the window
            self.restore();
        }

        const POSITION_FLAGS: u32 = comptime @enumToInt(win32_window_messaging.SWP_NOACTIVATE) |
            @enumToInt(win32_window_messaging.SWP_NOREPOSITION) |
            @enumToInt(win32_window_messaging.SWP_NOZORDER) |
            @enumToInt(win32_window_messaging.SWP_NOMOVE);

        const top = if (self.data.flags.is_topmost)
            win32_window_messaging.HWND_TOPMOST
        else
            win32_window_messaging.HWND_NOTOPMOST;

        setWindowPositionIntern(
            self.handle,
            top,
            POSITION_FLAGS,
            0,
            0,
            new_client_rect.right - new_client_rect.left,
            new_client_rect.bottom - new_client_rect.top,
        );

        if (self.data.flags.is_fullscreen) {
            // setting the client size in fullscreen mode should
            // translate to setting the video mode.
            const monitor_handle = self.occupiedMonitor();
            var video: common.video_mode.VideoMode = undefined;
            self.widow.monitors.monitorVideoMode(monitor_handle, &video) catch unreachable;
            video.width = size.width;
            video.height = size.height;
            _ = self.setFullscreen(true, &video) catch {
                std.debug.print("Failed To switch video Mode\n", .{});
                self.requestRestore();
            };
            // as to not change the restore position.
            // manually set the restore frame size.
            self.win32.restore_frame.?.size = self.data.client_area.size;
            self.acquireMonitor(monitor_handle) catch {
                self.requestRestore();
            };
        }
    }

    pub fn setMinSize(self: *Self, min_size: ?common.geometry.WidowSize) void {
        if (self.data.flags.is_fullscreen or !self.data.flags.is_resizable) {
            // No need to do anything.
            return;
        }

        if (min_size != null) {
            var size = min_size.?;
            // min size shouldn't be negative.
            std.debug.assert(size.width > 0);
            std.debug.assert(size.height > 0);

            if (self.data.max_size) |*max_size| {
                // the min size shouldn't be superior to the max size.
                if (max_size.width < size.width or max_size.height < size.height) {
                    std.log.err(
                        "[Window] Specified minimum size(w:{},h:{}) is less than the maximum size(w:{},h:{})\n",
                        .{ size.width, size.height, max_size.width, max_size.height },
                    );
                    return;
                }
            }

            if (self.data.flags.allow_dpi_scaling) {
                var scaler: f64 = undefined;
                _ = self.scalingDPI(&scaler);
                size.scaleBy(scaler);
            }

            self.data.min_size = size;
        } else {
            self.data.min_size = null;
        }

        const POSITION_FLAGS: u32 = comptime @enumToInt(win32_window_messaging.SWP_NOACTIVATE) |
            @enumToInt(win32_window_messaging.SWP_NOREPOSITION) |
            @enumToInt(win32_window_messaging.SWP_NOZORDER) |
            @enumToInt(win32_window_messaging.SWP_NOMOVE);

        const size = windowSize(self.handle);

        const top = if (self.data.flags.is_topmost)
            win32_window_messaging.HWND_TOPMOST
        else
            win32_window_messaging.HWND_NOTOPMOST;
        // We need the system to post a WM_MINMAXINFO.
        // in order for the new size limits to be applied,
        setWindowPositionIntern(
            self.handle,
            top,
            POSITION_FLAGS,
            0,
            0,
            size.width,
            size.height,
        );
    }

    pub fn setMaxSize(self: *Self, max_size: ?common.geometry.WidowSize) void {
        if (self.data.flags.is_fullscreen or !self.data.flags.is_resizable) {
            // No need to do anything.
            return;
        }

        if (max_size != null) {
            var size = max_size.?;
            // max size shouldn't be negative.
            std.debug.assert(size.width > 0);
            std.debug.assert(size.height > 0);
            if (self.data.min_size) |*min_size| {
                // the max size should be superior or equal to the min size.
                if (size.width < min_size.width or size.height < min_size.height) {
                    std.log.err(
                        "[Window] Specified maximum size(w:{},h:{}) is less than the minimum size(w:{},h:{})\n",
                        .{ size.width, size.height, min_size.width, min_size.height },
                    );
                    return;
                }
            }
            if (self.data.flags.allow_dpi_scaling) {
                var scaler: f64 = undefined;
                _ = self.scalingDPI(&scaler);
                size.scaleBy(scaler);
            }
            self.data.max_size = size;
        } else {
            self.data.max_size = null;
        }

        const POSITION_FLAGS: u32 = comptime @enumToInt(win32_window_messaging.SWP_NOACTIVATE) |
            @enumToInt(win32_window_messaging.SWP_NOREPOSITION) |
            @enumToInt(win32_window_messaging.SWP_NOZORDER) |
            @enumToInt(win32_window_messaging.SWP_NOMOVE);

        const size = windowSize(self.handle);

        const top = if (self.data.flags.is_topmost)
            win32_window_messaging.HWND_TOPMOST
        else
            win32_window_messaging.HWND_NOTOPMOST;
        // We need the system to post a WM_MINMAXINFO.
        // in order for the new size limits to be applied,
        setWindowPositionIntern(
            self.handle,
            top,
            POSITION_FLAGS,
            0,
            0,
            size.width,
            size.height,
        );
    }

    /// Hides the window, this is different from minimizing it.
    pub fn hide(self: *Self) void {
        _ = win32_window_messaging.ShowWindow(self.handle, win32_window_messaging.SW_HIDE);
        self.data.flags.is_visible = false;
    }

    /// Toggles window resizablitity on(true) or off(false).
    pub fn setResizable(self: *Self, value: bool) void {
        self.data.flags.is_resizable = value;
        self.updateStyles();
    }

    /// Toggles window resizablitity on(true) or off(false).
    pub fn setDecorated(self: *Self, value: bool) void {
        self.data.flags.is_decorated = value;
        self.updateStyles();
    }

    /// Maximize the window.
    pub fn maximize(self: *const Self) void {
        if (self.data.flags.is_resizable) {
            // Only maximize a resizable window.
            _ = win32_window_messaging.ShowWindow(self.handle, win32_window_messaging.SW_MAXIMIZE);
        }
    }

    /// Minimizes the window.
    pub fn minimize(self: *const Self) void {
        _ = win32_window_messaging.ShowWindow(self.handle, win32_window_messaging.SW_MINIMIZE);
    }

    /// Restores the minimized or maximized window to a normal window.
    pub fn restore(self: *const Self) void {
        _ = win32_window_messaging.ShowWindow(self.handle, win32_window_messaging.SW_RESTORE);
    }

    /// Changes the title of the window.
    pub fn setTitle(self: *Self, allocator: std.mem.Allocator, new_title: []const u8) !void {
        const wide_title = try utils.utf8ToWideZ(allocator, new_title);
        defer allocator.free(wide_title);
        _ = win32_window_messaging.SetWindowTextW(self.handle, wide_title);
    }

    /// Returns the title of the window.
    pub inline fn title(self: *const Self, allocator: std.mem.Allocator) ![]u8 {
        // This length doesn't take into account the null character so add it when allocating.
        const wide_title_len = win32_window_messaging.GetWindowTextLengthW(self.handle);
        if (wide_title_len > 0) {
            var wide_slice = try allocator.allocSentinel(u16, @intCast(usize, wide_title_len) + 1, 0);
            defer allocator.free(wide_slice);
            // to get the full title we must specify the full buffer length or we will be 1 character short.
            _ = win32_window_messaging.GetWindowTextW(self.handle, wide_slice.ptr, wide_title_len + 1);
            const slice = try utils.wideZToUtf8(allocator, wide_slice);
            return slice;
        }
        // TODO: why does using the WindowError doesn't compile?
        return error.FailedToCopyTitle;
    }

    /// Returns the window's current opacity
    /// # Note
    /// The value is between 1.0 and 0.0
    /// with 1 being opaque and 0 being full transparent.
    pub fn opacity(self: *const Self) f32 {
        const ex_styles = win32_window_messaging.GetWindowLongPtrW(self.handle, win32_window_messaging.GWL_EXSTYLE);
        if ((ex_styles & @enumToInt(win32_window_messaging.WS_EX_LAYERED)) != 0) {
            var alpha: u8 = undefined;
            var flags: win32_window_messaging.LAYERED_WINDOW_ATTRIBUTES_FLAGS = undefined;
            _ = win32_window_messaging.GetLayeredWindowAttributes(self.handle, null, &alpha, &flags);
            if ((@enumToInt(flags) & @enumToInt(win32_window_messaging.LWA_ALPHA)) != 0) {
                return (@intToFloat(f32, alpha) / 255.0);
            }
        }
        return 1.0;
    }

    /// Sets the window's opacity
    /// # Note
    /// The value is between 1.0 and 0.0
    /// with 1 being opaque and 0 being full transparent.
    pub fn setOpacity(self: *Self, value: f32) void {
        var ex_styles = @bitCast(usize, win32_window_messaging.GetWindowLongPtrW(
            self.handle,
            win32_window_messaging.GWL_EXSTYLE,
        ));

        if (value == @as(f32, 1.0)) {
            ex_styles &= ~@enumToInt(win32_window_messaging.WS_EX_LAYERED);
        } else {
            const alpha = @truncate(u8, @floatToInt(u32, value * 255.0));

            if ((ex_styles & @enumToInt(win32_window_messaging.WS_EX_LAYERED)) == 0) {
                ex_styles |= @enumToInt(win32_window_messaging.WS_EX_LAYERED);
            }

            _ = win32_window_messaging.SetLayeredWindowAttributes(
                self.handle,
                0,
                alpha,
                win32_window_messaging.LWA_ALPHA,
            );
        }
        _ = win32_window_messaging.SetWindowLongPtrW(
            self.handle,
            win32_window_messaging.GWL_EXSTYLE,
            @bitCast(isize, ex_styles),
        );
    }

    pub fn setAspectRatio(self: *Self, ratio: ?common.geometry.AspectRatio) void {
        // shamlessly copied from GLFW library.
        self.data.aspect_ratio = ratio;
        if (ratio != null) {
            var rect: win32.RECT = undefined;
            _ = win32_window_messaging.GetWindowRect(self.handle, &rect);
            self.applyAspectRatio(&rect, win32_window_messaging.WMSZ_BOTTOMLEFT);
            _ = win32_window_messaging.MoveWindow(
                self.handle,
                rect.left,
                rect.top,
                rect.right - rect.left,
                rect.bottom - rect.top,
                win32.TRUE,
            );
        }
    }

    pub fn applyAspectRatio(self: *const Self, client: *win32_foundation.RECT, edge: u32) void {
        const ratio = @intToFloat(f64, self.data.aspect_ratio.?.x) / @intToFloat(f64, self.data.aspect_ratio.?.y);

        var rect = win32_foundation.RECT{
            .left = 0,
            .top = 0,
            .right = 0,
            .bottom = 0,
        };

        adjustWindowRect(
            &rect,
            windowStyles(&self.data.flags),
            windowExStyles(&self.data.flags),
            self.scalingDPI(null),
        );

        switch (edge) {
            win32_window_messaging.WMSZ_LEFT, win32_window_messaging.WMSZ_RIGHT, win32_window_messaging.WMSZ_BOTTOMLEFT, win32_window_messaging.WMSZ_BOTTOMRIGHT => {
                client.bottom = client.top + (rect.bottom - rect.top) +
                    @floatToInt(i32, @intToFloat(f64, (client.right - client.left) - (rect.right - rect.left)) / ratio);
            },
            win32_window_messaging.WMSZ_TOPLEFT, win32_window_messaging.WMSZ_TOPRIGHT => {
                client.top = client.bottom - (rect.bottom - rect.top) -
                    @floatToInt(i32, @intToFloat(f64, (client.right - client.left) - (rect.right - rect.left)) / ratio);
            },
            win32_window_messaging.WMSZ_TOP, win32_window_messaging.WMSZ_BOTTOM => {
                client.right = client.left + (rect.right - rect.left) +
                    @floatToInt(i32, @intToFloat(f64, (client.bottom - client.top) - (rect.bottom - rect.top)) * ratio);
            },
            else => unreachable,
        }
    }

    /// Returns the fullscreen mode of the window;
    pub fn setFullscreen(self: *Self, value: bool, video_mode: ?*common.video_mode.VideoMode) !void {

        // The video mode switch should always be done first
        const monitor_handle = self.occupiedMonitor();
        try self.widow.monitors.setMonitorVideoMode(monitor_handle, video_mode);

        if (self.data.flags.is_fullscreen != value) {
            if (value) {
                // save for when we exit the fullscreen mode
                self.win32.restore_frame = self.data.client_area;

                self.data.flags.is_fullscreen = true;
                self.updateStyles();
                try self.acquireMonitor(monitor_handle);
            } else {
                try self.releaseMonitor(monitor_handle);
                self.requestRestore();
            }
        }
    }

    pub fn requestRestore(self: *Self) void {
        self.data.flags.is_fullscreen = false;
        self.updateStyles();
        self.win32.restore_frame = null;
    }

    pub fn acquireMonitor(self: *Self, monitor_handle: win32.HMONITOR) !void {
        var mon_area: common.geometry.WidowArea = undefined;

        try self.widow.monitors.setMonitorWindow(
            monitor_handle,
            self,
            &mon_area,
        );

        const POSITION_FLAGS: u32 = @enumToInt(win32_window_messaging.SWP_NOZORDER) |
            @enumToInt(win32_window_messaging.SWP_NOACTIVATE) |
            @enumToInt(win32_window_messaging.SWP_NOCOPYBITS);

        const top = if (self.data.flags.is_topmost)
            win32_window_messaging.HWND_TOPMOST
        else
            win32_window_messaging.HWND_NOTOPMOST;

        setWindowPositionIntern(
            self.handle,
            top,
            POSITION_FLAGS,
            mon_area.top_left.x,
            mon_area.top_left.y,
            mon_area.size.width,
            mon_area.size.height,
        );
    }

    pub fn releaseMonitor(self: *const Self, monitor_handle: win32.HMONITOR) !void {
        try self.widow.monitors.restoreMonitor(monitor_handle);
    }

    pub inline fn occupiedMonitor(self: *const Self) win32.HMONITOR {
        return win32_gdi.MonitorFromWindow(self.handle, win32_gdi.MONITOR_DEFAULTTONEAREST).?;
    }

    pub fn setCursorShape(self: *Self, new_cursor: *const icon.Cursor) void {
        icon.destroyCursor(&self.win32.cursor);
        self.win32.cursor = new_cursor.*;
        if (self.data.flags.cursor_in_client) {
            updateCursorImage(&self.win32.cursor);
        }
    }

    pub fn setIcon(self: *Self, new_icon: *const icon.Icon) void {
        const handles = if (new_icon.sm_handle != null and new_icon.bg_handle != null)
            .{ @ptrToInt(new_icon.bg_handle.?), @ptrToInt(new_icon.sm_handle.?) }
        else blk: {
            const bg_icon = win32_window_messaging.GetClassLongPtrW(self.handle, win32_window_messaging.GCLP_HICON);
            const sm_icon = win32_window_messaging.GetClassLongPtrW(self.handle, win32_window_messaging.GCLP_HICONSM);
            break :blk .{ bg_icon, sm_icon };
        };
        _ = win32_window_messaging.SendMessageW(
            self.handle,
            win32_window_messaging.WM_SETICON,
            win32_window_messaging.ICON_BIG,
            @bitCast(isize, handles[0]),
        );
        _ = win32_window_messaging.SendMessageW(
            self.handle,
            win32_window_messaging.WM_SETICON,
            win32_window_messaging.ICON_SMALL,
            @bitCast(isize, handles[1]),
        );
        icon.destroyIcon(&self.win32.icon);
        self.win32.icon = new_icon.*;
    }

    /// Returns a cached slice that contains the path(s) to the last dropped file(s).
    pub fn droppedFiles(self: *const Self) [][]const u8 {
        return self.win32.dropped_files.items;
    }

    pub inline fn setDragAndDrop(self: *Self, accepted: bool) void {
        const accept = if (accepted)
            win32.TRUE
        else blk: {
            self.freeDroppedFiles();
            break :blk win32.FALSE;
        };
        DragAcceptFiles(self.handle, accept);
    }

    /// Frees the allocated memory used to hold the file(s) path(s).
    pub fn freeDroppedFiles(self: *Self) void {
        // Avoid double free.
        if (self.win32.dropped_files.capacity == 0) {
            return;
        }
        const allocator = self.win32.dropped_files.allocator;
        for (self.win32.dropped_files.items) |item| {
            allocator.free(item);
        }
        self.win32.dropped_files.clearAndFree();
    }

    // DEBUG
    pub fn debugInfos(self: *const Self, size: bool, flags: bool) void {
        std.debug.print("0==========================0\n", .{});
        if (size) {
            std.debug.print("\nWindow #{}\n", .{self.data.id});
            var cs: win32.RECT = undefined;
            clientRect(self.handle, &cs);
            std.debug.print("Client Size (w:{},h:{}) | with API (w:{},h:{})\n", .{ self.data.client_area.size.width, self.data.client_area.size.height, cs.right - cs.left, cs.bottom - cs.top });
            const ws = windowSize(self.handle);
            std.debug.print("Window Size (w:{},h:{})\n", .{ ws.width, ws.height });
            if (self.data.min_size) |*value| {
                std.debug.print("Min Size: {}\n", .{value.*});
            } else {
                std.debug.print("No Min Size:\n", .{});
            }
            if (self.data.max_size) |*value| {
                std.debug.print("Max Size: {}\n", .{value.*});
            } else {
                std.debug.print("No Max Size:\n", .{});
            }
            if (self.data.aspect_ratio) |*value| {
                std.debug.print("Aspect Ratio: {}/{}\n", .{ value.x, value.y });
            } else {
                std.debug.print("No Aspect Ratio:\n", .{});
            }
        }
        if (flags) {
            std.debug.print("Flags Mode: {}\n", .{self.data.flags});
        }
    }
};
