const std = @import("std");
const zigwin32 = @import("zigwin32");
const win32 = @import("win32_defs.zig");
const helperWindowProc = @import("./window_proc.zig").helperWindowProc;
const utils = @import("./utils.zig");
const monitor_impl = @import("./monitor_impl.zig");
const icon = @import("./icon.zig");
const clipboard = @import("./clipboard.zig");
const common = @import("common");
const errors = @import("errors.zig");
const Win32Context = @import("globals.zig").Win32Context;
const win32_window_messaging = zigwin32.ui.windows_and_messaging;
const win32_system_power = zigwin32.system.power;
const win32_sys_service = zigwin32.system.system_services;
const WindowImpl = @import("window_impl.zig").WindowImpl;
const JoystickSubSystem = @import("joystick_impl.zig").JoystickSubSystem;

pub const HelperData = struct {
    monitor_store_ptr: ?*MonitorStore,
    joysubsys_ptr: ?*JoystickSubSystem,
    clipboard_change: bool, // So we can cache the clipboard value until it changes.
    next_clipboard_viewer: ?win32.HWND, // we're using the old api to watch the clipboard.
    clipboard_text: ?[]u8,
};

pub const Internals = struct {
    helper_data: HelperData,
    helper_window: win32.HWND,
    helper_class: u16,
    dev_notif: *anyopaque,
    const HELPER_CLASS_NAME = "WIDOW_HELPER";
    const HELPER_TITLE = "";
    const Self = @This();

    pub const StatePointerMode = enum {
        Monitor,
        Joystick,
    };

    pub fn init() !Self {
        var self: Self = undefined;

        // first time getting the singleton, must confirm successful init.
        const win32_singelton = Win32Context.singleton() orelse return errors.WidowWin32Error.FailedToInitPlatform;
        self.helper_class = try registerHelperClass(win32_singelton.handles.hinstance);
        self.helper_window = try createHelperWindow(win32_singelton.handles.hinstance);
        self.helper_data.joysubsys_ptr = null;
        self.helper_data.clipboard_change = false;
        self.helper_data.monitor_store_ptr = null;
        self.helper_data.next_clipboard_viewer = try clipboard.registerClipboardViewer(self.helper_window);
        self.helper_data.clipboard_text = null;
        registerDevicesNotif(self.helper_window, &self.dev_notif);
        _ = win32_window_messaging.SetWindowLongPtrW(self.helper_window, win32_window_messaging.GWLP_USERDATA, @intCast(isize, @ptrToInt(&self.helper_data)));
        return self;
    }

    pub fn deinit(self: *Self, allocator: std.mem.Allocator) void {
        _ = win32_sys_service.UnregisterDeviceNotification(self.dev_notif);

        // Clear up the Devices refrence
        _ = win32_window_messaging.SetWindowLongPtrW(
            self.helper_window,
            win32_window_messaging.GWLP_USERDATA,
            0,
        );

        _ = win32_window_messaging.DestroyWindow(self.helper_window);
        if (self.helper_data.clipboard_text) |text| {
            allocator.free(text);
            self.helper_data.clipboard_text = null;
        }

        var buffer: [(Self.HELPER_CLASS_NAME.len) * 4]u8 = undefined;
        var fba = std.heap.FixedBufferAllocator.init(&buffer);
        const fballocator = fba.allocator();

        // Shoudln't fail since the buffer is big enough.
        const helper_class_name = utils.utf8ToWideZ(fballocator, Self.HELPER_CLASS_NAME) catch unreachable;

        // Unregister the helper class.
        _ = win32_window_messaging.UnregisterClassW(
            // utils.makeIntAtom(u8, self.win32.handles.helper_class),
            helper_class_name,
            Win32Context.singleton().?.handles.hinstance,
        );

        clipboard.unregisterClipboardViewer(self.helper_window, self.helper_data.next_clipboard_viewer);

        // we're done.
        // destory the singelton.
        Win32Context.deinitSingleton();
    }

    pub inline fn setStatePointer(self: *Self, mode: StatePointerMode, pointer: ?*anyopaque) void {
        switch (mode) {
            StatePointerMode.Monitor => {
                self.helper_data.monitor_store_ptr = @ptrCast(?*MonitorStore, @alignCast(8, pointer));
            },
            StatePointerMode.Joystick => {
                self.helper_data.joysubsys_ptr = @ptrCast(?*JoystickSubSystem, pointer);
            },
        }
    }

    pub fn clipboardText(self: *Self, allocator: std.mem.Allocator) ![]u8 {
        if (self.helper_data.clipboard_change or self.user_data.clipboard_text == null) {
            // refetching clipboard data
            if (self.helper_data.clipboard_text) |text| {
                allocator.free(text);
                errdefer self.helper_data.clipboard_text = null;
            }
            self.helper_data.clipboard_text = try clipboard.clipboardText(allocator, self.win32.handles.helper_window);
            self.helper_data.clipboard_change = false;
        }
        return self.helper_data.clipboard_text.?;
    }

    pub fn setClipboardText(self: *Self, allocator: std.mem.Allocator, text: []const u8) !void {
        // refetch on the next call to Internals.clipboardText.
        return clipboard.setClipboardText(allocator, self.win32.handles.helper_window, text);
    }
};

fn registerHelperClass(hinstance: win32.HINSTANCE) !u16 {
    var helper_class: win32_window_messaging.WNDCLASSEXW = std.mem.zeroes(win32_window_messaging.WNDCLASSEXW);
    helper_class.cbSize = @sizeOf(win32_window_messaging.WNDCLASSEXW);
    helper_class.style = win32_window_messaging.CS_OWNDC;
    helper_class.lpfnWndProc = helperWindowProc;
    helper_class.hInstance = hinstance;
    // Estimate five times the curent utf8 string len.
    var buffer: [Internals.HELPER_CLASS_NAME.len * 4]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    // Shoudln't fail since the buffer is big enough.
    const wide_class_name = utils.utf8ToWideZ(fba.allocator(), Internals.HELPER_CLASS_NAME) catch unreachable;
    helper_class.lpszClassName = wide_class_name;
    const class = win32_window_messaging.RegisterClassExW(&helper_class);
    if (class == 0) {
        return errors.WindowError.FailedToCreate;
    }
    return class;
}

/// Create an invisible helper window that lives as long as the internals struct.
/// the helper window is used for handeling hardware related messages.
fn createHelperWindow(hinstance: win32.HINSTANCE) !win32.HWND {
    // Estimate five times the curent utf8 string len.
    var buffer: [(Internals.HELPER_CLASS_NAME.len + Internals.HELPER_TITLE.len) * 4]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    // Shoudln't fail since the buffer is big enough.
    const wide_class_name = utils.utf8ToWideZ(fba.allocator(), Internals.HELPER_CLASS_NAME) catch unreachable;
    const helper_title = utils.utf8ToWideZ(fba.allocator(), Internals.HELPER_TITLE) catch unreachable;

    const helper_window = win32_window_messaging.CreateWindowExW(
        @intToEnum(win32_window_messaging.WINDOW_EX_STYLE, 0),
        wide_class_name,
        // utils.makeIntAtom(u16, helper_handle.*),
        helper_title,
        win32_window_messaging.WS_OVERLAPPED,
        win32.CW_USEDEFAULT,
        win32.CW_USEDEFAULT,
        win32.CW_USEDEFAULT,
        win32.CW_USEDEFAULT,
        null,
        null,
        hinstance,
        null,
    ) orelse {
        return errors.WindowError.FailedToCreate;
    };

    _ = win32_window_messaging.ShowWindow(helper_window, win32_window_messaging.SW_HIDE);
    return helper_window;
}

fn registerDevicesNotif(helper_window: win32.HWND, dbi_handle: **anyopaque) void {

    // Register window to recieve HID notification
    var dbi: win32_sys_service.DEV_BROADCAST_DEVICEINTERFACE_A = undefined;
    dbi.dbcc_size = @sizeOf(win32_sys_service.DEV_BROADCAST_DEVICEINTERFACE_A);
    dbi.dbcc_devicetype = @enumToInt(win32_sys_service.DBT_DEVTYP_DEVICEINTERFACE);
    dbi.dbcc_classguid = win32.GUID_DEVINTERFACE_HID;
    dbi_handle.* = win32_window_messaging.RegisterDeviceNotificationW(
        helper_window,
        @ptrCast(*anyopaque, &dbi),
        win32.DEVICE_NOTIFY_WINDOW_HANDLE,
    ) orelse unreachable; // Should always succeed.
}

pub fn createIcon(
    window: *WindowImpl,
    pixels: []const u8,
    width: i32,
    height: i32,
) !void {
    const sm_handle = try icon.createIcon(pixels, width, height, null, null);
    const bg_handle = try icon.createIcon(pixels, width, height, null, null);
    window.setIcon(&icon.Icon{ .sm_handle = sm_handle, .bg_handle = bg_handle });
}

pub fn createCursor(
    window: *WindowImpl,
    pixels: []const u8,
    width: i32,
    height: i32,
    xhot: u32,
    yhot: u32,
) !void {
    const handle = try icon.createIcon(pixels, width, height, xhot, yhot);
    window.setCursorShape(&icon.Cursor{ .handle = handle, .shared = false, .mode = common.cursor.CursorMode.Normal });
}

pub const MonitorStore = struct {
    monitors_map: std.AutoArrayHashMap(win32.HMONITOR, monitor_impl.MonitorImpl),
    used_monitors: u8,
    expected_video_change: bool, // For skipping unnecessary updates.
    prev_exec_state: win32_system_power.EXECUTION_STATE,
    const Self = @This();

    /// Initialize the `MonitorStore` struct.
    pub fn init(allocator: std.mem.Allocator) !Self {
        var self = Self{
            .monitors_map = std.AutoArrayHashMap(win32.HMONITOR, monitor_impl.MonitorImpl).init(allocator),
            .used_monitors = 0,
            .expected_video_change = false,
            .prev_exec_state = win32_system_power.ES_SYSTEM_REQUIRED,
        };

        // Populate the monitor map
        var monitors = try monitor_impl.pollMonitors(allocator);
        defer monitors.deinit();
        errdefer {
            for (monitors.items) |*monitor| {
                monitor.deinit();
            }
            monitors.deinit();
            self.monitors_map.deinit();
        }
        for (monitors.items) |*monitor| {
            try self.monitors_map.put(monitor.handle, monitor.*);
        }
        return self;
    }

    /// Deinitialize the `MonitorStore` struct.
    /// this frees the monitors map and invalidate all monitors refrence.
    pub fn deinit(self: *Self) void {
        self.expected_video_change = true;
        for (self.monitors_map.values()) |*monitor| {
            if (monitor.window) |*window| {
                window.*.requestRestore();
            }
            // free allocated data.
            monitor.deinit();
        }
        self.monitors_map.deinit();
    }

    /// Updates the monitor map by removing all disconnected monitors
    /// and adding new connected ones.
    /// # Note
    /// the update is very slow but it's only triggered if a monitor was connected, or disconnected.
    pub fn updateMonitors(self: *Self) !void {
        self.expected_video_change = true;
        defer self.expected_video_change = false;

        const all_monitors = try monitor_impl.pollMonitors(self.monitors_map.allocator);
        // keep track of the index in case of an error to free the remaining monitors.
        var i: usize = 0;
        defer all_monitors.deinit();
        errdefer {
            // clean the remaning monitors.
            for (i..all_monitors.items.len) |index| {
                all_monitors.items[index].deinit();
            }
        }

        // Remove the disconnected monitors.
        for (self.monitors_map.values()) |*monitor| {
            var disconnected = true;
            for (all_monitors.items) |*new_monitor| {
                if (monitor.equals(new_monitor)) {
                    disconnected = false;
                    break;
                }
            }
            if (disconnected) {
                // Free the name pointer.
                if (monitor.window) |*window| {
                    window.*.requestRestore();
                }
                monitor.deinit();
                _ = self.monitors_map.swapRemove(monitor.handle);
            }
        }

        // Insert the new ones
        for (all_monitors.items) |*monitor| {
            var connected = true;
            for (self.monitors_map.values()) |*value| {
                if (monitor.equals(value)) {
                    connected = false;
                    break;
                }
            }

            if (connected) {
                try self.monitors_map.put(monitor.handle, monitor.*);
            } else {
                monitor.deinit();
            }
            i += 1;
        }
    }

    /// Acquire a monitor for a window
    pub fn setMonitorWindow(
        self: *Self,
        monitor_handle: win32.HMONITOR,
        window: *WindowImpl,
        mode: ?*const common.video_mode.VideoMode,
        monitor_area: *common.geometry.WidowArea,
    ) !void {
        const monitor = self.monitors_map.getPtr(monitor_handle) orelse {
            return;
        };

        // ChangeDisplaySettigns sends a WM_DISPLAYCHANGED message
        // We Set this here to avoid wastefully updating the monitors map.
        self.expected_video_change = true;
        defer self.expected_video_change = false;
        try monitor.setVideoMode(mode);

        if (self.used_monitors == 0) {
            const thread_exec_state = comptime @enumToInt(win32_system_power.ES_CONTINUOUS) | @enumToInt(win32_system_power.ES_DISPLAY_REQUIRED);
            // first time acquiring a  monitor
            // prevent the system from entering sleep or turning off.
            self.prev_exec_state = win32_system_power.SetThreadExecutionState(@intToEnum(win32_system_power.EXECUTION_STATE, thread_exec_state));
        } else {
            if (monitor.window) |old_window| {
                if (window.handle != old_window.handle) {
                    old_window.requestRestore();
                }
                self.used_monitors -= 1;
            }
        }

        monitor.setWindow(window);
        self.used_monitors += 1;
        monitor.fullscreenArea(monitor_area);
    }

    /// Called by the window instance to release any occupied monitor
    pub fn restoreMonitor(self: *Self, monitor_handle: win32.HMONITOR) !void {
        const monitor = self.monitors_map.getPtr(monitor_handle) orelse {
            return errors.MonitorError.MonitorNotFound;
        };
        monitor.setWindow(null);

        self.expected_video_change = true;
        defer self.expected_video_change = false;
        monitor.restoreOrignalVideo();

        self.used_monitors -= 1;
        if (self.used_monitors == 0) {
            _ = win32_system_power.SetThreadExecutionState(self.prev_exec_state);
        }
    }
};

// Zigwin32 libary doesn't have definitions for IDC constants probably due to alignement issues.
// pub fn createStandardCursor(window: *WindowImpl, shape: CursorShape) !void {
//     const cursor_id = switch (shape) {
//         CursorShape.PointingHand => win32_window_messaging.IDC_HAND,
//         CursorShape.Crosshair => win32_window_messaging.IDC_CROSS,
//         CursorShape.Text => win32_window_messaging.IDC_IBEAM,
//         CursorShape.Wait => win32_window_messaging.IDC_WAIT,
//         CursorShape.Help => win32_window_messaging.IDC_HELP,
//         CursorShape.Busy => win32_window_messaging.IDC_APPSTARTING,
//         CursorShape.Forbidden => win32_window_messaging.IDC_NO,
//         else => win32_window_messaging.IDC_ARROW,
//     };
//     // LoadCursorW takes a handle to an instance of the module
//     // whose executable file contains the cursor to be loaded.
//     const handle = win32_window_messaging.LoadCursorW(0, cursor_id);
//     if (handle == 0) {
//         // We failed.
//         return error.FailedToLoadStdCursor;
//     }
//     window.setCursorShape(&icon.Cursor{ .handle = handle, .shared = true, .mode = common.cursor.CursorMode.Normal });
// }

test "Internals.init()" {
    const testing = std.testing;
    var result = try Internals.init();
    defer result.deinit(testing.allocator);
}

test "MonitorStore.init()" {
    const VideoMode = @import("common").video_mode.VideoMode;
    const testing = std.testing;
    var ph_dev = try MonitorStore.init(testing.allocator);
    defer ph_dev.deinit();
    var all_monitors = try monitor_impl.pollMonitors(testing.allocator);
    defer {
        for (all_monitors.items) |*monitor| {
            // monitors contain heap allocated data that need
            // to be freed.
            monitor.deinit();
        }
        all_monitors.deinit();
    }
    var main_monitor = all_monitors.items[0];
    try ph_dev.updateMonitors();
    var primary_monitor = ph_dev.monitors_map.getPtr(main_monitor.handle).?;
    const mode = VideoMode.init(1600, 900, 32, 60);
    try primary_monitor.*.setVideoMode(&mode);
    std.time.sleep(std.time.ns_per_s * 3);
    std.debug.print("Restoring Original Mode....\n", .{});
    primary_monitor.*.restoreOrignalVideo();
}
