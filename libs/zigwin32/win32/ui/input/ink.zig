//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (0)
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------
// Section: Types (9)
//--------------------------------------------------------------------------------
const CLSID_InkDesktopHost_Value = Guid.initString("062584a6-f830-4bdc-a4d2-0a10ab062b1d");
pub const CLSID_InkDesktopHost = &CLSID_InkDesktopHost_Value;

// TODO: this type is limited to platform 'windows10.0.10240'
const IID_IInkCommitRequestHandler_Value = Guid.initString("fabea3fc-b108-45b6-a9fc-8d08fa9f85cf");
pub const IID_IInkCommitRequestHandler = &IID_IInkCommitRequestHandler_Value;
pub const IInkCommitRequestHandler = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        OnCommitRequested: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IInkCommitRequestHandler,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IInkCommitRequestHandler,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IInkCommitRequestHandler_OnCommitRequested(self: *const T) callconv(.Inline) HRESULT {
            return @as(*const IInkCommitRequestHandler.VTable, @ptrCast(self.vtable)).OnCommitRequested(@as(*const IInkCommitRequestHandler, @ptrCast(self)));
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

// TODO: this type is limited to platform 'windows10.0.10240'
const IID_IInkPresenterDesktop_Value = Guid.initString("73f3c0d9-2e8b-48f3-895e-20cbd27b723b");
pub const IID_IInkPresenterDesktop = &IID_IInkPresenterDesktop_Value;
pub const IInkPresenterDesktop = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        SetRootVisual: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IInkPresenterDesktop,
                rootVisual: ?*IUnknown,
                device: ?*IUnknown,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IInkPresenterDesktop,
                rootVisual: ?*IUnknown,
                device: ?*IUnknown,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
        SetCommitRequestHandler: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IInkPresenterDesktop,
                handler: ?*IInkCommitRequestHandler,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IInkPresenterDesktop,
                handler: ?*IInkCommitRequestHandler,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
        GetSize: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IInkPresenterDesktop,
                width: ?*f32,
                height: ?*f32,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IInkPresenterDesktop,
                width: ?*f32,
                height: ?*f32,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
        SetSize: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IInkPresenterDesktop,
                width: f32,
                height: f32,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IInkPresenterDesktop,
                width: f32,
                height: f32,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
        OnHighContrastChanged: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IInkPresenterDesktop,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IInkPresenterDesktop,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IInkPresenterDesktop_SetRootVisual(self: *const T, rootVisual: ?*IUnknown, device: ?*IUnknown) callconv(.Inline) HRESULT {
            return @as(*const IInkPresenterDesktop.VTable, @ptrCast(self.vtable)).SetRootVisual(@as(*const IInkPresenterDesktop, @ptrCast(self)), rootVisual, device);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IInkPresenterDesktop_SetCommitRequestHandler(self: *const T, handler: ?*IInkCommitRequestHandler) callconv(.Inline) HRESULT {
            return @as(*const IInkPresenterDesktop.VTable, @ptrCast(self.vtable)).SetCommitRequestHandler(@as(*const IInkPresenterDesktop, @ptrCast(self)), handler);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IInkPresenterDesktop_GetSize(self: *const T, width: ?*f32, height: ?*f32) callconv(.Inline) HRESULT {
            return @as(*const IInkPresenterDesktop.VTable, @ptrCast(self.vtable)).GetSize(@as(*const IInkPresenterDesktop, @ptrCast(self)), width, height);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IInkPresenterDesktop_SetSize(self: *const T, width: f32, height: f32) callconv(.Inline) HRESULT {
            return @as(*const IInkPresenterDesktop.VTable, @ptrCast(self.vtable)).SetSize(@as(*const IInkPresenterDesktop, @ptrCast(self)), width, height);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IInkPresenterDesktop_OnHighContrastChanged(self: *const T) callconv(.Inline) HRESULT {
            return @as(*const IInkPresenterDesktop.VTable, @ptrCast(self.vtable)).OnHighContrastChanged(@as(*const IInkPresenterDesktop, @ptrCast(self)));
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

// TODO: this type is limited to platform 'windows10.0.10240'
const IID_IInkHostWorkItem_Value = Guid.initString("ccda0a9a-1b78-4632-bb96-97800662e26c");
pub const IID_IInkHostWorkItem = &IID_IInkHostWorkItem_Value;
pub const IInkHostWorkItem = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        Invoke: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IInkHostWorkItem,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IInkHostWorkItem,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IInkHostWorkItem_Invoke(self: *const T) callconv(.Inline) HRESULT {
            return @as(*const IInkHostWorkItem.VTable, @ptrCast(self.vtable)).Invoke(@as(*const IInkHostWorkItem, @ptrCast(self)));
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

// TODO: this type is limited to platform 'windows10.0.10240'
const IID_IInkDesktopHost_Value = Guid.initString("4ce7d875-a981-4140-a1ff-ad93258e8d59");
pub const IID_IInkDesktopHost = &IID_IInkDesktopHost_Value;
pub const IInkDesktopHost = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        QueueWorkItem: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IInkDesktopHost,
                workItem: ?*IInkHostWorkItem,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IInkDesktopHost,
                workItem: ?*IInkHostWorkItem,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
        CreateInkPresenter: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IInkDesktopHost,
                riid: ?*const Guid,
                ppv: ?*?*anyopaque,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IInkDesktopHost,
                riid: ?*const Guid,
                ppv: ?*?*anyopaque,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
        CreateAndInitializeInkPresenter: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IInkDesktopHost,
                rootVisual: ?*IUnknown,
                width: f32,
                height: f32,
                riid: ?*const Guid,
                ppv: ?*?*anyopaque,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IInkDesktopHost,
                rootVisual: ?*IUnknown,
                width: f32,
                height: f32,
                riid: ?*const Guid,
                ppv: ?*?*anyopaque,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IInkDesktopHost_QueueWorkItem(self: *const T, workItem: ?*IInkHostWorkItem) callconv(.Inline) HRESULT {
            return @as(*const IInkDesktopHost.VTable, @ptrCast(self.vtable)).QueueWorkItem(@as(*const IInkDesktopHost, @ptrCast(self)), workItem);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IInkDesktopHost_CreateInkPresenter(self: *const T, riid: ?*const Guid, ppv: ?*?*anyopaque) callconv(.Inline) HRESULT {
            return @as(*const IInkDesktopHost.VTable, @ptrCast(self.vtable)).CreateInkPresenter(@as(*const IInkDesktopHost, @ptrCast(self)), riid, ppv);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IInkDesktopHost_CreateAndInitializeInkPresenter(self: *const T, rootVisual: ?*IUnknown, width: f32, height: f32, riid: ?*const Guid, ppv: ?*?*anyopaque) callconv(.Inline) HRESULT {
            return @as(*const IInkDesktopHost.VTable, @ptrCast(self.vtable)).CreateAndInitializeInkPresenter(@as(*const IInkDesktopHost, @ptrCast(self)), rootVisual, width, height, riid, ppv);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

const CLSID_InkD2DRenderer_Value = Guid.initString("4044e60c-7b01-4671-a97c-04e0210a07a5");
pub const CLSID_InkD2DRenderer = &CLSID_InkD2DRenderer_Value;

pub const INK_HIGH_CONTRAST_ADJUSTMENT = enum(i32) {
    SYSTEM_COLORS_WHEN_NECESSARY = 0,
    SYSTEM_COLORS = 1,
    ORIGINAL_COLORS = 2,
};
pub const USE_SYSTEM_COLORS_WHEN_NECESSARY = INK_HIGH_CONTRAST_ADJUSTMENT.SYSTEM_COLORS_WHEN_NECESSARY;
pub const USE_SYSTEM_COLORS = INK_HIGH_CONTRAST_ADJUSTMENT.SYSTEM_COLORS;
pub const USE_ORIGINAL_COLORS = INK_HIGH_CONTRAST_ADJUSTMENT.ORIGINAL_COLORS;

// TODO: this type is limited to platform 'windows10.0.10240'
const IID_IInkD2DRenderer_Value = Guid.initString("407fb1de-f85a-4150-97cf-b7fb274fb4f8");
pub const IID_IInkD2DRenderer = &IID_IInkD2DRenderer_Value;
pub const IInkD2DRenderer = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        Draw: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IInkD2DRenderer,
                pD2D1DeviceContext: ?*IUnknown,
                pInkStrokeIterable: ?*IUnknown,
                fHighContrast: BOOL,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IInkD2DRenderer,
                pD2D1DeviceContext: ?*IUnknown,
                pInkStrokeIterable: ?*IUnknown,
                fHighContrast: BOOL,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IInkD2DRenderer_Draw(self: *const T, pD2D1DeviceContext: ?*IUnknown, pInkStrokeIterable: ?*IUnknown, fHighContrast: BOOL) callconv(.Inline) HRESULT {
            return @as(*const IInkD2DRenderer.VTable, @ptrCast(self.vtable)).Draw(@as(*const IInkD2DRenderer, @ptrCast(self)), pD2D1DeviceContext, pInkStrokeIterable, fHighContrast);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

const IID_IInkD2DRenderer2_Value = Guid.initString("0a95dcd9-4578-4b71-b20b-bf664d4bfeee");
pub const IID_IInkD2DRenderer2 = &IID_IInkD2DRenderer2_Value;
pub const IInkD2DRenderer2 = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        Draw: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IInkD2DRenderer2,
                pD2D1DeviceContext: ?*IUnknown,
                pInkStrokeIterable: ?*IUnknown,
                highContrastAdjustment: INK_HIGH_CONTRAST_ADJUSTMENT,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IInkD2DRenderer2,
                pD2D1DeviceContext: ?*IUnknown,
                pInkStrokeIterable: ?*IUnknown,
                highContrastAdjustment: INK_HIGH_CONTRAST_ADJUSTMENT,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IInkD2DRenderer2_Draw(self: *const T, pD2D1DeviceContext: ?*IUnknown, pInkStrokeIterable: ?*IUnknown, highContrastAdjustment: INK_HIGH_CONTRAST_ADJUSTMENT) callconv(.Inline) HRESULT {
            return @as(*const IInkD2DRenderer2.VTable, @ptrCast(self.vtable)).Draw(@as(*const IInkD2DRenderer2, @ptrCast(self)), pD2D1DeviceContext, pInkStrokeIterable, highContrastAdjustment);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};


//--------------------------------------------------------------------------------
// Section: Functions (0)
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------
// Section: Unicode Aliases (0)
//--------------------------------------------------------------------------------
const thismodule = @This();
pub usingnamespace switch (@import("../../zig.zig").unicode_mode) {
    .ansi => struct {
    },
    .wide => struct {
    },
    .unspecified => if (@import("builtin").is_test) struct {
    } else struct {
    },
};
//--------------------------------------------------------------------------------
// Section: Imports (4)
//--------------------------------------------------------------------------------
const Guid = @import("../../zig.zig").Guid;
const BOOL = @import("../../foundation.zig").BOOL;
const HRESULT = @import("../../foundation.zig").HRESULT;
const IUnknown = @import("../../system/com.zig").IUnknown;

test {
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
