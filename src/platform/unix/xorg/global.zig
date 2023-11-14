const std = @import("std");
const b = @import("builtin");
const module = @import("module.zig");
const libx11 = @import("x11/xlib.zig");
const x11ext = @import("x11/extensions.zig");
const utils = @import("utils.zig");

/// Determine the modules name at comptime.
const ext_libs = switch (b.target.os.tag) {
    .linux => [_][*:0]const u8{
        "libXrandr.so.2", "libXinerama.so.1",
    },
    .freebsd, .netbsd, .openbsd => [_][*:0]const u8{
        "libXrandr.so", "libXinerama.so",
    },
    else => @compileError("Unsupported Unix Platform"),
};

const LIB_XRANDR_INDEX = @as(u8, 0);
const LIB_XINERAMA_INDEX = @as(u8, 1);

pub const XConnectionError = error{
    ConnectionFailed,
    XRandRNotFound,
};

const X11Handles = struct {
    xdisplay: *libx11.Display,
    root_window: libx11.Window,
    default_screen: u32,
    xrandr: ?*anyopaque,
    xinerama: ?*anyopaque,
};

// XRandRInterf
const XRRInterface = struct {
    is_v1point3: bool,
    XRRGetScreenResourcesCurrent: x11ext.XRRGetScreenResourcesCurrentProc,
    XRRGetScreenResources: x11ext.XRRGetScreenResourcesProc,
    XRRFreeScreenResources: x11ext.XRRFreeScreenResourcesProc,
    XRRGetCrtcInfo: x11ext.XRRGetCrtcInfoProc,
    XRRFreeCrtcInfo: x11ext.XRRFreeCrtcInfoProc,
    XRRGetOutputInfo: x11ext.XRRGetOutputInfoProc,
    XRRFreeOutputInfo: x11ext.XRRFreeOutputInfoProc,
    XRRGetOutputPrimary: x11ext.XRRGetOutputPrimaryProc,
    XRRQueryVersion: x11ext.XRRQueryVersionProc,
    XRRSetCrtcConfig: x11ext.XRRSetCrtcConfigProc,
};

// XineramaIntef
const XrmInterface = struct {
    is_active: bool,
    IsActive: x11ext.XineramaIsActiveProc,
    QueryScreens: x11ext.XineramaQueryScreens,
};

const X11Extensions = struct {
    xrandr: XRRInterface,
    xinerama: XrmInterface,
};

/// holds the various hints a window manager can have.
/// https://specifications.freedesktop.org/wm-spec/wm-spce-1.3.html
const X11EWMH = struct {
    //########### Root Window Propeties ##############
    _NET_SUPPORTING_WM_CHECK: libx11.Atom,
    // gives the window of the active WM.
    _NET_SUPPORTED: libx11.Atom,
    // lists all the EWMH protocols supported by this WM.
    _NET_CURRENT_DESKTOP: libx11.Atom,
    // gives the index of the current desktop.
    _NET_ACTIVE_WINDOW: libx11.Atom,
    // gives the currently active window.
    _NET_WORKAREA: libx11.Atom,
    // contains a geometry for each desktop.

    // _NET_NUMBER_OF_DESKTOPS: libx11.Atom,
    // indicates the number of virtual desktops.
    // _NET_VIRTUAL_ROOTS: libx11.Atom,
    // if the WM supports virtual root windows.
    // _NET_DESKTOP_VIEWPORT: libx11.Atom,
    // defines the top left corner of each desktop.
    // _NET_CLIENT_LIST
    // lists all application windows managed by this WM.
    // _NET_DESKTOP_GEOMETRY
    //     defines the common size of all desktops.
    // _NET_DESKTOP_NAMES
    //     lists the names of all virtual desktops.
    // _NET_DESKTOP_LAYOUT
    //     shows the layout of the active pager.
    // _NET_SHOWING_DESKTOP
    //     is 1 for "showing the desktop" mode.

    //############ Client messages ###############
    _NET_WM_STATE: libx11.Atom,
    _NET_WM_STATE_DEMANDS_ATTENTION: libx11.Atom,

    //########### Application Window Properties ##########
    _NET_WM_NAME: libx11.Atom,
    _NET_WM_VISIBLE_NAME: libx11.Atom,
    _NET_WM_ICON_NAME: libx11.Atom,
    _NET_WM_VISIBLE_ICON_NAME: libx11.Atom,
    _NET_WM_DESKTOP: libx11.Atom,

    //########## Property Types ################
    UTF8_STRING: libx11.Atom,
};

pub const X11Context = struct {
    handles: X11Handles,
    extensions: X11Extensions,
    ewmh: X11EWMH,
    g_dpi: f32,
    g_scale: f32,
    last_error_code: u8,
    last_error_handler: ?*libx11.XErrorHandlerFunc,
    var g_init_mutex: std.Thread.Mutex = std.Thread.Mutex{};
    var g_init: bool = false;

    var globl_instance: X11Context = X11Context{
        .handles = X11Handles{
            .xdisplay = undefined,
            .root_window = undefined,
            .default_screen = undefined,
            .xrandr = null,
            .xinerama = null,
        },
        .extensions = X11Extensions{
            .xrandr = XRRInterface{
                .is_v1point3 = false,
                .XRRGetCrtcInfo = undefined,
                .XRRFreeCrtcInfo = undefined,
                .XRRGetOutputInfo = undefined,
                .XRRFreeOutputInfo = undefined,
                .XRRGetOutputPrimary = undefined,
                .XRRGetScreenResourcesCurrent = undefined,
                .XRRGetScreenResources = undefined,
                .XRRFreeScreenResources = undefined,
                .XRRQueryVersion = undefined,
                .XRRSetCrtcConfig = undefined,
            },
            .xinerama = XrmInterface{
                .is_active = false,
                .IsActive = undefined,
                .QueryScreens = undefined,
            },
        },
        .ewmh = X11EWMH{
            ._NET_SUPPORTING_WM_CHECK = 0,
            ._NET_SUPPORTED = 0,
            ._NET_CURRENT_DESKTOP = 0,
            ._NET_ACTIVE_WINDOW = 0,
            ._NET_WORKAREA = 0,
            ._NET_WM_STATE = 0,
            ._NET_WM_STATE_DEMANDS_ATTENTION = 0,

            ._NET_WM_NAME = 0,
            ._NET_WM_VISIBLE_NAME = 0,
            ._NET_WM_ICON_NAME = 0,
            ._NET_WM_VISIBLE_ICON_NAME = 0,
            ._NET_WM_DESKTOP = 0,

            .UTF8_STRING = 0,
        },
        .g_dpi = 0.0,
        .g_scale = 0.0,
        .last_error_code = 0,
        .last_error_handler = null,
    };

    const Self = @This();

    pub fn initSingleton() XConnectionError!void {
        @setCold(true);

        Self.g_init_mutex.lock();
        defer g_init_mutex.unlock();
        if (!Self.g_init) {
            const g_instance = &Self.globl_instance;
            // Open a connection to the X server.
            g_instance.handles.xdisplay = libx11.XOpenDisplay(null) orelse {
                return XConnectionError.ConnectionFailed;
            };
            // Grab the default screen(monitor) and the root window on it.
            g_instance.handles.default_screen = @intCast(libx11.DefaultScreen(g_instance.handles.xdisplay));
            // Grab the root window on the default screen.
            g_instance.handles.root_window = libx11.RootWindow(g_instance.handles.xdisplay, g_instance.handles.default_screen);

            try g_instance.loadXExtensions();
            g_instance.getSystemGlobalScale();

            // read root window properties
            g_instance.ewmh._NET_SUPPORTING_WM_CHECK = libx11.XInternAtom(
                g_instance.handles.xdisplay,
                "_NET_SUPPORTING_WM_CHECK",
                libx11.False,
            );
            g_instance.ewmh._NET_SUPPORTED = libx11.XInternAtom(
                g_instance.handles.xdisplay,
                "_NET_SUPPORTED",
                libx11.False,
            );

            g_instance.ewmh.UTF8_STRING = libx11.XInternAtom(
                g_instance.handles.xdisplay,
                "UTF8_STRING",
                libx11.False,
            );

            g_instance.queryEWMH();

            Self.g_init = true;
        }
    }

    pub fn deinitSingleton() void {
        @setCold(true);
        Self.g_init_mutex.lock();
        defer Self.g_init_mutex.unlock();
        if (Self.g_init) {
            Self.g_init = false;
            _ = libx11.XCloseDisplay(globl_instance.handles.xdisplay);
            globl_instance.unloadXExtensions();
        }
    }

    fn loadXExtensions(self: *Self) XConnectionError!void {
        self.handles.xrandr = module.loadPosixModule(ext_libs[LIB_XRANDR_INDEX]);
        if (self.handles.xrandr) |handle| {
            self.extensions.xrandr.XRRGetCrtcInfo = @ptrCast(
                module.moduleSymbol(handle, "XRRGetCrtcInfo"),
            );
            self.extensions.xrandr.XRRFreeCrtcInfo = @ptrCast(
                module.moduleSymbol(handle, "XRRFreeCrtcInfo"),
            );
            self.extensions.xrandr.XRRGetOutputInfo = @ptrCast(
                module.moduleSymbol(handle, "XRRGetOutputInfo"),
            );
            self.extensions.xrandr.XRRFreeOutputInfo = @ptrCast(
                module.moduleSymbol(handle, "XRRFreeOutputInfo"),
            );
            self.extensions.xrandr.XRRGetOutputPrimary = @ptrCast(
                module.moduleSymbol(handle, "XRRGetOutputPrimary"),
            );
            self.extensions.xrandr.XRRGetScreenResourcesCurrent = @ptrCast(
                module.moduleSymbol(handle, "XRRGetScreenResourcesCurrent"),
            );
            self.extensions.xrandr.XRRGetScreenResources = @ptrCast(
                module.moduleSymbol(handle, "XRRGetScreenResources"),
            );
            self.extensions.xrandr.XRRFreeScreenResources = @ptrCast(
                module.moduleSymbol(handle, "XRRFreeScreenResources"),
            );
            self.extensions.xrandr.XRRQueryVersion = @ptrCast(
                module.moduleSymbol(handle, "XRRQueryVersion"),
            );
            self.extensions.xrandr.XRRSetCrtcConfig = @ptrCast(
                module.moduleSymbol(handle, "XRRSetCrtcConfig"),
            );
            var minor: i32 = 0;
            var major: i32 = 0;
            _ = self.extensions.xrandr.XRRQueryVersion(self.handles.xdisplay, &major, &minor);
            self.extensions.xrandr.is_v1point3 = (major >= 1 and minor >= 3);
        } else {
            std.log.err("[X11]: XRandR library not found.\n", .{});
            // Error out since a lot functionalties rely on xrandr.
            return XConnectionError.XRandRNotFound;
        }

        self.handles.xinerama = module.loadPosixModule(ext_libs[LIB_XINERAMA_INDEX]);
        if (self.handles.xinerama) |handle| {
            self.extensions.xinerama.IsActive = @ptrCast(
                module.moduleSymbol(handle, "XineramaIsActive").?,
            );
            self.extensions.xinerama.QueryScreens = @ptrCast(
                module.moduleSymbol(handle, "XineramaQueryScreens").?,
            );
            self.extensions.xinerama.is_active = (self.extensions.xinerama.IsActive(self.handles.xdisplay) != 0);
        } else {
            std.log.warn("[X11]: Xinerama library not found.\n", .{});
        }
    }

    fn unloadXExtensions(self: *Self) void {
        if (self.handles.xinerama) |handle| {
            module.freePosixModule(handle);
            self.handles.xinerama = null;
        }

        if (self.handles.xrandr) |handle| {
            module.freePosixModule(handle);
            self.handles.xrandr = null;
        }
    }

    fn getSystemGlobalScale(self: *Self) void {
        // https://dec05eba.com/2021/10/11/x11-multiple-monitor-dpi-trick/
        // INFO:
        // there is no per monitor dpi property in X11, there is only a global dpi property.
        // the property is set by the user to a value that works best for his highest resolution monitor
        // using it should give the user the best experience.

        // if we fail set dpi to 96 default.
        var dpi: f32 = 96.0;
        libx11.XrmInitialize();
        const res_str = libx11.XResourceManagerString(self.handles.xdisplay);
        if (res_str) |s| {
            const db = libx11.XrmGetStringDatabase(s);
            defer libx11.XrmDestroyDatabase(db);
            var value_type: ?[*:0]const u8 = null;
            var value: libx11.XrmValue = undefined;
            _ = libx11.XrmGetResource(db, "Xft.dpi", "Xft.Dpi", &value_type, &value);
            if (value_type) |t| {
                if (utils.strEquals(t, "String")) {
                    var src: []const u8 = undefined;
                    src.len = value.size;
                    src.ptr = value.addr.?;
                    dpi = std.fmt.parseFloat(f32, src) catch 96.0;
                }
            }
        }

        self.g_dpi = dpi;
        self.g_scale = dpi / 96.0;
    }

    /// changes the x server protocol error handler
    /// Note: 2 calls to this function must be separated by a call to
    /// unsetXErrorHandler,
    pub fn setXErrorHandler(self: *Self) void {
        std.debug.print("\nlast_error_handler:{?}\n", .{self.last_error_handler});
        std.debug.assert(self.last_error_handler == null);
        // clear last error.
        self.last_error_code = 0;
        self.last_error_handler = libx11.XSetErrorHandler(handleXError);
    }

    /// returns an error if the last error_code is not 0.
    pub fn unsetXErrorHandler(self: *Self) !void {
        libx11.XSync(self.handles.xdisplay, libx11.False);
        _ = libx11.XSetErrorHandler(self.last_error_handler);
        self.last_error_handler = null;
        if (self.last_error_code != 0) {
            // TODO:
            std.debug.print("\n[-] Error \n", .{});
            return error.ConnectionError;
        }
    }

    // TODO: report error
    // pub fn errorMsg()

    fn queryEWMH(self: *Self) void {

        // if the _NET_WM_SUPPORTING_WM_CHECK is missing client should
        // assume a non conforming window manager is present
        var window_ptr: ?*libx11.Window = null;
        if (x11WindowProperty(
            self.handles.xdisplay,
            self.handles.root_window,
            self.ewmh._NET_SUPPORTING_WM_CHECK,
            libx11.XA_WINDOW,
            @ptrCast(&window_ptr),
        ) == 0) {
            // non conforming.
            return;
        }

        std.debug.assert(window_ptr != null);
        defer _ = libx11.XFree(window_ptr.?);

        // on success the window_ptr points to the id of the child window created by
        // the window manager.
        // this window must also have _NET_WM_SUPPORTING_WM_CHECK property
        // set to the same id(the id of the child window).

        var child_window_ptr: ?*libx11.Window = null;
        if (x11WindowProperty(
            self.handles.xdisplay,
            window_ptr.?.*,
            self.ewmh._NET_SUPPORTING_WM_CHECK,
            libx11.XA_WINDOW,
            @ptrCast(&child_window_ptr),
        ) == 0) {
            return;
        }

        std.debug.assert(child_window_ptr != null);
        defer _ = libx11.XFree(child_window_ptr.?);

        if (window_ptr.?.* != child_window_ptr.?.*) {
            // breaks the rules.
            return;
        }

        // the window manager is EWMH-compliant we can get
        // a list of all supported features through the _NET_SUPPORTED
        // property on the root window.

        var supported: ?[*]libx11.Atom = null;
        const atom_count = x11WindowProperty(
            self.handles.xdisplay,
            self.handles.root_window,
            self.ewmh._NET_SUPPORTED,
            libx11.XA_ATOM,
            @ptrCast(&supported),
        );

        if (atom_count == 0) {
            std.debug.print("\n 0 Supported atoms\n", .{});
            return;
        }

        std.debug.assert(supported != null);
        defer _ = libx11.XFree(supported.?);

        self.ewmh._NET_WM_STATE = atomIfSupported(
            self.handles.xdisplay,
            supported.?,
            atom_count,
            "_NET_WM_STATE",
        );
        self.ewmh._NET_WM_STATE_DEMANDS_ATTENTION = atomIfSupported(
            self.handles.xdisplay,
            supported.?,
            atom_count,
            "_NET_WM_STATE_DEMANDS_ATTENTION",
        );
        self.ewmh._NET_WORKAREA = atomIfSupported(
            self.handles.xdisplay,
            supported.?,
            atom_count,
            "_NET_WORKAREA",
        );
        self.ewmh._NET_CURRENT_DESKTOP = atomIfSupported(
            self.handles.xdisplay,
            supported.?,
            atom_count,
            "_NET_CURRENT_DESKTOP",
        );
        self.ewmh._NET_ACTIVE_WINDOW = atomIfSupported(
            self.handles.xdisplay,
            supported.?,
            atom_count,
            "_NET_ACTIVE_WINDOW",
        );

        self.ewmh._NET_WM_NAME = atomIfSupported(
            self.handles.xdisplay,
            supported.?,
            atom_count,
            "_NET_WM_NAME",
        );

        self.ewmh._NET_WM_VISIBLE_NAME = atomIfSupported(
            self.handles.xdisplay,
            supported.?,
            atom_count,
            "_NET_WM_VISIBLE_NAME",
        );

        self.ewmh._NET_WM_ICON_NAME = atomIfSupported(
            self.handles.xdisplay,
            supported.?,
            atom_count,
            "_NET_WM_ICON_NAME",
        );

        self.ewmh._NET_WM_VISIBLE_ICON_NAME = atomIfSupported(
            self.handles.xdisplay,
            supported.?,
            atom_count,
            "_NET_WM_VISIBLE_ICON_NAME",
        );

        // Easy shortcut but require the field.name to be sentinel terminated since it will be passed to a c function.
        // const info = @typeInfo(X11EWMH);
        // inline for (info.Struct.fields) |*f| {
        //     if (comptime std.mem.eql(u8, "_NET_SUPPORTING_WM_CHECK", f.name)) {
        //         continue;
        //     }
        //     if (comptime std.mem.eql(u8, "_NET_SUPPORTED", f.name)) {
        //         continue;
        //     }
        //     @field(self.ewmh, f.name) = atomIfSupported(
        //         self.handles.xdisplay,
        //         supported.?,
        //         atom_count,
        //         f.name.ptr,
        //     );
        // }
    }

    /// Sends all requests currently in the xlib output bufffer
    /// to the x server.
    /// doesn't block since it use XFlush.
    pub fn flushXRequests(self: *const Self) void {
        _ = libx11.XFlush(self.handles.xdisplay);
    }
    // Enfoce readonly.
    pub fn singleton() *const Self {
        std.debug.assert(g_init == true);
        return &Self.globl_instance;
    }

    // TODO: find a better way to check for X11 errors.
    pub fn mutSingelton() *Self {
        std.debug.assert(g_init == true);
        return &Self.globl_instance;
    }
};

/// check the supported atoms for a specified atom name
/// if found it returns the atom
/// if not it returns 0.
fn atomIfSupported(display: ?*libx11.Display, supported: [*]libx11.Atom, atom_count: u32, atom_name: [*:0]const u8) libx11.Atom {
    const atom = libx11.XInternAtom(display, atom_name, libx11.False);

    for (0..atom_count) |i| {
        if (supported[i] == atom) {
            return atom;
        }
    }

    return 0;
}

pub fn x11WindowProperty(display: ?*libx11.Display, w: libx11.Window, property: libx11.Atom, prop_type: libx11.Atom, value: ?[*]?[*]u8) u32 {
    var actual_type: libx11.Atom = undefined;
    var actual_format: c_int = undefined;
    var nitems: c_ulong = 0;
    var bytes_after: c_ulong = undefined;
    _ = libx11.XGetWindowProperty(
        display,
        w,
        property,
        0,
        utils.MAX_C_LONG,
        libx11.False,
        prop_type,
        &actual_type,
        &actual_format,
        &nitems,
        &bytes_after,
        value,
    );
    // make sure no bytes are left behind.
    std.debug.assert(bytes_after == 0);
    return @intCast(nitems);
}

fn handleXError(display: ?*libx11.Display, err: *libx11.XErrorEvent) callconv(.C) c_int {
    const x11cntxt = X11Context.mutSingelton();
    if (x11cntxt.handles.xdisplay != display) {
        return 0;
    }
    // TODO: saftey concerns ? of mutating the global constant.
    x11cntxt.last_error_code = err.error_code;
    return 0;
}

test "X11Context Thread safety" {
    const testing = std.testing;
    _ = testing;
    const builtin = @import("builtin");
    if (builtin.single_threaded) {
        try X11Context.initSingleton();
        try X11Context.initSingleton();
        defer X11Context.deinitSingleton();
    } else {
        var threads: [10]std.Thread = undefined;
        defer for (threads) |handle| handle.join();

        for (&threads) |*handle| {
            handle.* = try std.Thread.spawn(.{}, struct {
                fn thread_fn() !void {
                    try X11Context.initSingleton();
                    defer X11Context.deinitSingleton();
                }
            }.thread_fn, .{});
        }
    }
}

test "Win32Context init" {
    try X11Context.initSingleton();
    const singleton = X11Context.singleton();
    std.debug.print("\nX11 execution context:\n", .{});
    std.debug.print("[+] DPI:{d},Scale:{d}\n", .{ singleton.g_dpi, singleton.g_scale });
    std.debug.print("[+] Handles: {any}\n", .{singleton.handles});
    std.debug.print("[+] XRRInterface: {any}\n", .{singleton.extensions.xrandr});
    std.debug.print("[+] XineramaIntef: {any}\n", .{singleton.extensions.xinerama});
    std.debug.print("[+] EWMH:{any}\n", .{singleton.ewmh});
    X11Context.deinitSingleton();
}
