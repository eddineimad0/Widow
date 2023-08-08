//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (0)
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------
// Section: Types (0)
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------
// Section: Functions (3)
//--------------------------------------------------------------------------------
pub extern "wsclient" fn CheckDeveloperLicense(
    pExpiration: ?*FILETIME,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "wsclient" fn AcquireDeveloperLicense(
    hwndParent: ?HWND,
    pExpiration: ?*FILETIME,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "wsclient" fn RemoveDeveloperLicense(
    hwndParent: ?HWND,
) callconv(@import("std").os.windows.WINAPI) HRESULT;


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
// Section: Imports (3)
//--------------------------------------------------------------------------------
const FILETIME = @import("../foundation.zig").FILETIME;
const HRESULT = @import("../foundation.zig").HRESULT;
const HWND = @import("../foundation.zig").HWND;

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
