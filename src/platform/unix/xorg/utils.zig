//! This file contains helper function to use on the linux platforms
const std = @import("std");
const common = @import("common");
const ScanCode = common.keyboard_and_mouse.ScanCode;
const libx11 = @import("x11/xlib.zig");
const maxInt = std.math.maxInt;

pub const DEFAULT_SCREEN_DPI: f32 = @as(f32, 96);

pub inline fn strCpy(src: [*:0]const u8, dst: [*]u8, count: usize) void {
    // TODO: is there any benefit in using libc strCpy.
    for (0..count) |i| {
        dst[i] = src[i];
    }
}

pub inline fn strLen(src: [*:0]const u8) usize {
    return std.mem.len(src);
}

/// returns true if both strings are equals.
pub inline fn strEquals(a: [*:0]const u8, b: [*:0]const u8) bool {
    return (std.mem.orderZ(u8, a, b) == std.math.Order.eq);
}

pub const WindowPropError = error{
    BadPropType,
    PropNotFound,
};

pub fn x11WindowProperty(
    display: *libx11.Display,
    w: libx11.Window,
    property: libx11.Atom,
    prop_type: libx11.Atom,
    value: ?[*]?[*]u8,
) WindowPropError!u32 {
    const MAX_C_LONG = @as(c_long, maxInt(c_long));
    var actual_type: libx11.Atom = undefined;
    var actual_format: c_int = undefined;
    var nitems: c_ulong = 0;
    var bytes_after: c_ulong = undefined;
    const result = libx11.XGetWindowProperty(
        display,
        w,
        property,
        0,
        MAX_C_LONG,
        libx11.False,
        prop_type,
        &actual_type,
        &actual_format,
        &nitems,
        &bytes_after,
        value,
    );

    if (result != libx11.Success) {
        if (actual_type != libx11.None and actual_type != prop_type) {
            return WindowPropError.BadPropType;
        }
        return WindowPropError.PropNotFound;
    }
    // make sure no bytes are left behind.
    std.debug.assert(bytes_after == 0);
    return @intCast(nitems);
}

/// Returns the state of the Key Modifiers for the current event,
/// by decoding the state field.
pub fn decodeKeyMods(state: c_uint) common.keyboard_and_mouse.KeyModifiers {
    var mods = common.keyboard_and_mouse.KeyModifiers{
        .shift = (state & libx11.ShiftMask != 0),
        .ctrl = (state & libx11.ControlMask != 0),
        .alt = (state & libx11.Mod1Mask != 0),
        .num_lock = (state & libx11.Mod2Mask != 0),
        .meta = (state & libx11.Mod4Mask != 0),
        .caps_lock = (state & libx11.LockMask != 0),
    };
    return mods;
}

pub fn keycodeToScancode(code: u32) ScanCode {
    const look_up_table = [256]ScanCode{
        // the first 8 are never produced by the xserver.
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Escape,
        ScanCode.Num1,
        ScanCode.Num2,
        ScanCode.Num3,
        ScanCode.Num4,
        ScanCode.Num5,
        ScanCode.Num6,
        ScanCode.Num7,
        ScanCode.Num8,
        ScanCode.Num9,
        ScanCode.Num0,
        ScanCode.Hyphen,
        ScanCode.Equal,
        ScanCode.Backspace,
        ScanCode.Tab,
        ScanCode.Q,
        ScanCode.W,
        ScanCode.E,
        ScanCode.R,
        ScanCode.T,
        ScanCode.Y,
        ScanCode.U,
        ScanCode.I,
        ScanCode.O,
        ScanCode.P,
        ScanCode.LBracket,
        ScanCode.RBracket,
        ScanCode.Return,
        ScanCode.LControl,
        ScanCode.A,
        ScanCode.S,
        ScanCode.D,
        ScanCode.F,
        ScanCode.G,
        ScanCode.H,
        ScanCode.J,
        ScanCode.K,
        ScanCode.L,
        ScanCode.Semicolon,
        ScanCode.Quote,
        ScanCode.Grave,
        ScanCode.LShift,
        ScanCode.Backslash,
        ScanCode.Z,
        ScanCode.X,
        ScanCode.C,
        ScanCode.V,
        ScanCode.B,
        ScanCode.N,
        ScanCode.M,
        ScanCode.Comma,
        ScanCode.Period,
        ScanCode.Slash,
        ScanCode.RShift,
        ScanCode.NumpadMultiply,
        ScanCode.LAlt,
        ScanCode.Space,
        ScanCode.CapsLock,
        ScanCode.F1,
        ScanCode.F2,
        ScanCode.F3,
        ScanCode.F4,
        ScanCode.F5,
        ScanCode.F6,
        ScanCode.F7,
        ScanCode.F8,
        ScanCode.F9,
        ScanCode.F10,
        ScanCode.NumLock,
        ScanCode.ScrollLock,
        ScanCode.Numpad7,
        ScanCode.Numpad8,
        ScanCode.Numpad9,
        ScanCode.NumpadSubtract,
        ScanCode.Numpad4,
        ScanCode.Numpad5,
        ScanCode.Numpad6,
        ScanCode.NumpadAdd,
        ScanCode.Numpad1,
        ScanCode.Numpad2,
        ScanCode.Numpad3,
        ScanCode.Numpad0,
        ScanCode.NumpadDecimal,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Key102nd,
        ScanCode.F11,
        ScanCode.F12,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.NumpadReturn,
        ScanCode.RControl,
        ScanCode.NumpadDivide,
        ScanCode.PrintScreen,
        ScanCode.RAlt,
        ScanCode.Return, // LineFeed
        ScanCode.Home,
        ScanCode.Up,
        ScanCode.PageUp,
        ScanCode.Left,
        ScanCode.Right,
        ScanCode.End,
        ScanCode.Down,
        ScanCode.PageDown,
        ScanCode.Insert,
        ScanCode.Delete,
        ScanCode.Unknown, // Macro
        ScanCode.VolumeMute,
        ScanCode.VolumeDown,
        ScanCode.VolumeUp,
        ScanCode.Unknown, // Power
        ScanCode.NumpadEqual,
        ScanCode.Unknown,
        ScanCode.Pause,
        ScanCode.Unknown,
        ScanCode.NumpadDecimal,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Menu,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.NextTrack,
        ScanCode.PlayPause,
        ScanCode.PrevTrack,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown, // start F13 to F24
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown, // end of F13 to f24
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
        ScanCode.Unknown,
    };

    return look_up_table[code];
}
