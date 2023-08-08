//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (5)
//--------------------------------------------------------------------------------
pub const MS_SHOWMAGNIFIEDCURSOR = @as(i32, 1);
pub const MS_CLIPAROUNDCURSOR = @as(i32, 2);
pub const MS_INVERTCOLORS = @as(i32, 4);
pub const MW_FILTERMODE_EXCLUDE = @as(u32, 0);
pub const MW_FILTERMODE_INCLUDE = @as(u32, 1);

//--------------------------------------------------------------------------------
// Section: Types (4)
//--------------------------------------------------------------------------------
pub const MAGTRANSFORM = extern struct {
    v: [9]f32,
};

pub const MAGIMAGEHEADER = extern struct {
    width: u32,
    height: u32,
    format: Guid,
    stride: u32,
    offset: u32,
    cbSize: usize,
};

pub const MAGCOLOREFFECT = extern struct {
    transform: [25]f32,
};

pub const MagImageScalingCallback = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        hwnd: ?HWND,
        srcdata: ?*anyopaque,
        srcheader: MAGIMAGEHEADER,
        destdata: ?*anyopaque,
        destheader: MAGIMAGEHEADER,
        unclipped: RECT,
        clipped: RECT,
        dirty: ?HRGN,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
    else => *const fn(
        hwnd: ?HWND,
        srcdata: ?*anyopaque,
        srcheader: MAGIMAGEHEADER,
        destdata: ?*anyopaque,
        destheader: MAGIMAGEHEADER,
        unclipped: RECT,
        clipped: RECT,
        dirty: ?HRGN,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
} ;


//--------------------------------------------------------------------------------
// Section: Functions (19)
//--------------------------------------------------------------------------------
// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "magnification" fn MagInitialize(
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "magnification" fn MagUninitialize(
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "magnification" fn MagSetWindowSource(
    hwnd: ?HWND,
    rect: RECT,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "magnification" fn MagGetWindowSource(
    hwnd: ?HWND,
    pRect: ?*RECT,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "magnification" fn MagSetWindowTransform(
    hwnd: ?HWND,
    pTransform: ?*MAGTRANSFORM,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "magnification" fn MagGetWindowTransform(
    hwnd: ?HWND,
    pTransform: ?*MAGTRANSFORM,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "magnification" fn MagSetWindowFilterList(
    hwnd: ?HWND,
    dwFilterMode: u32,
    count: i32,
    pHWND: ?*?HWND,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "magnification" fn MagGetWindowFilterList(
    hwnd: ?HWND,
    pdwFilterMode: ?*u32,
    count: i32,
    pHWND: ?*?HWND,
) callconv(@import("std").os.windows.WINAPI) i32;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "magnification" fn MagSetImageScalingCallback(
    hwnd: ?HWND,
    callback: ?MagImageScalingCallback,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "magnification" fn MagGetImageScalingCallback(
    hwnd: ?HWND,
) callconv(@import("std").os.windows.WINAPI) ?MagImageScalingCallback;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "magnification" fn MagSetColorEffect(
    hwnd: ?HWND,
    pEffect: ?*MAGCOLOREFFECT,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "magnification" fn MagGetColorEffect(
    hwnd: ?HWND,
    pEffect: ?*MAGCOLOREFFECT,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "magnification" fn MagSetFullscreenTransform(
    magLevel: f32,
    xOffset: i32,
    yOffset: i32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "magnification" fn MagGetFullscreenTransform(
    pMagLevel: ?*f32,
    pxOffset: ?*i32,
    pyOffset: ?*i32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "magnification" fn MagSetFullscreenColorEffect(
    pEffect: ?*MAGCOLOREFFECT,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "magnification" fn MagGetFullscreenColorEffect(
    pEffect: ?*MAGCOLOREFFECT,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "magnification" fn MagSetInputTransform(
    fEnabled: BOOL,
    pRectSource: ?*const RECT,
    pRectDest: ?*const RECT,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "magnification" fn MagGetInputTransform(
    pfEnabled: ?*BOOL,
    pRectSource: ?*RECT,
    pRectDest: ?*RECT,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "magnification" fn MagShowSystemCursor(
    fShowCursor: BOOL,
) callconv(@import("std").os.windows.WINAPI) BOOL;


//--------------------------------------------------------------------------------
// Section: Unicode Aliases (0)
//--------------------------------------------------------------------------------
const thismodule = @This();
pub usingnamespace switch (@import("../zig.zig").unicode_mode) {
    .ansi => struct {
    },
    .wide => struct {
    },
    .unspecified => if (@import("builtin").is_test) struct {
    } else struct {
    },
};
//--------------------------------------------------------------------------------
// Section: Imports (5)
//--------------------------------------------------------------------------------
const Guid = @import("../zig.zig").Guid;
const BOOL = @import("../foundation.zig").BOOL;
const HRGN = @import("../graphics/gdi.zig").HRGN;
const HWND = @import("../foundation.zig").HWND;
const RECT = @import("../foundation.zig").RECT;

test {
    // The following '_ = <FuncPtrType>' lines are a workaround for https://github.com/ziglang/zig/issues/4476
    if (@hasDecl(@This(), "MagImageScalingCallback")) { _ = MagImageScalingCallback; }

    @setEvalBranchQuota(
        comptime @import("std").meta.declarations(@This()).len * 3
    );

    // reference all the pub declarations
    if (!@import("builtin").is_test) return;
    inline for (comptime @import("std").meta.declarations(@This())) |decl| {
        if (decl.is_pub) {
            _ = @field(@This(), decl.name);
        }
    }
}
