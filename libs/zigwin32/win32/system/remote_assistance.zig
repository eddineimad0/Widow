//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (4)
//--------------------------------------------------------------------------------
pub const DISPID_EVENT_ON_STATE_CHANGED = @as(u32, 5);
pub const DISPID_EVENT_ON_TERMINATION = @as(u32, 6);
pub const DISPID_EVENT_ON_CONTEXT_DATA = @as(u32, 7);
pub const DISPID_EVENT_ON_SEND_ERROR = @as(u32, 8);

//--------------------------------------------------------------------------------
// Section: Types (6)
//--------------------------------------------------------------------------------
const CLSID_RendezvousApplication_Value = Guid.initString("0b7e019a-b5de-47fa-8966-9082f82fb192");
pub const CLSID_RendezvousApplication = &CLSID_RendezvousApplication_Value;

pub const RENDEZVOUS_SESSION_STATE = enum(i32) {
    UNKNOWN = 0,
    READY = 1,
    INVITATION = 2,
    ACCEPTED = 3,
    CONNECTED = 4,
    CANCELLED = 5,
    DECLINED = 6,
    TERMINATED = 7,
};
pub const RSS_UNKNOWN = RENDEZVOUS_SESSION_STATE.UNKNOWN;
pub const RSS_READY = RENDEZVOUS_SESSION_STATE.READY;
pub const RSS_INVITATION = RENDEZVOUS_SESSION_STATE.INVITATION;
pub const RSS_ACCEPTED = RENDEZVOUS_SESSION_STATE.ACCEPTED;
pub const RSS_CONNECTED = RENDEZVOUS_SESSION_STATE.CONNECTED;
pub const RSS_CANCELLED = RENDEZVOUS_SESSION_STATE.CANCELLED;
pub const RSS_DECLINED = RENDEZVOUS_SESSION_STATE.DECLINED;
pub const RSS_TERMINATED = RENDEZVOUS_SESSION_STATE.TERMINATED;

pub const RENDEZVOUS_SESSION_FLAGS = enum(i32) {
    NONE = 0,
    INVITER = 1,
    INVITEE = 2,
    ORIGINAL_INVITER = 4,
    REMOTE_LEGACYSESSION = 8,
    REMOTE_WIN7SESSION = 16,
};
pub const RSF_NONE = RENDEZVOUS_SESSION_FLAGS.NONE;
pub const RSF_INVITER = RENDEZVOUS_SESSION_FLAGS.INVITER;
pub const RSF_INVITEE = RENDEZVOUS_SESSION_FLAGS.INVITEE;
pub const RSF_ORIGINAL_INVITER = RENDEZVOUS_SESSION_FLAGS.ORIGINAL_INVITER;
pub const RSF_REMOTE_LEGACYSESSION = RENDEZVOUS_SESSION_FLAGS.REMOTE_LEGACYSESSION;
pub const RSF_REMOTE_WIN7SESSION = RENDEZVOUS_SESSION_FLAGS.REMOTE_WIN7SESSION;

// TODO: this type is limited to platform 'windows6.0.6000'
const IID_IRendezvousSession_Value = Guid.initString("9ba4b1dd-8b0c-48b7-9e7c-2f25857c8df5");
pub const IID_IRendezvousSession = &IID_IRendezvousSession_Value;
pub const IRendezvousSession = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        // TODO: this function has a "SpecialName", should Zig do anything with this?
        get_State: switch (@import("builtin").zig_backend) {
            // TODO: this function has a "SpecialName", should Zig do anything with this?
            .stage1 => fn(
                self: *const IRendezvousSession,
                pSessionState: ?*RENDEZVOUS_SESSION_STATE,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            // TODO: this function has a "SpecialName", should Zig do anything with this?
            else => *const fn(
                self: *const IRendezvousSession,
                pSessionState: ?*RENDEZVOUS_SESSION_STATE,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
        // TODO: this function has a "SpecialName", should Zig do anything with this?
        get_RemoteUser: switch (@import("builtin").zig_backend) {
            // TODO: this function has a "SpecialName", should Zig do anything with this?
            .stage1 => fn(
                self: *const IRendezvousSession,
                bstrUserName: ?*?BSTR,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            // TODO: this function has a "SpecialName", should Zig do anything with this?
            else => *const fn(
                self: *const IRendezvousSession,
                bstrUserName: ?*?BSTR,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
        // TODO: this function has a "SpecialName", should Zig do anything with this?
        get_Flags: switch (@import("builtin").zig_backend) {
            // TODO: this function has a "SpecialName", should Zig do anything with this?
            .stage1 => fn(
                self: *const IRendezvousSession,
                pFlags: ?*i32,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            // TODO: this function has a "SpecialName", should Zig do anything with this?
            else => *const fn(
                self: *const IRendezvousSession,
                pFlags: ?*i32,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
        SendContextData: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IRendezvousSession,
                bstrData: ?BSTR,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IRendezvousSession,
                bstrData: ?BSTR,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
        Terminate: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IRendezvousSession,
                hr: HRESULT,
                bstrAppData: ?BSTR,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IRendezvousSession,
                hr: HRESULT,
                bstrAppData: ?BSTR,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IRendezvousSession_get_State(self: *const T, pSessionState: ?*RENDEZVOUS_SESSION_STATE) callconv(.Inline) HRESULT {
            return @as(*const IRendezvousSession.VTable, @ptrCast(self.vtable)).get_State(@as(*const IRendezvousSession, @ptrCast(self)), pSessionState);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IRendezvousSession_get_RemoteUser(self: *const T, bstrUserName: ?*?BSTR) callconv(.Inline) HRESULT {
            return @as(*const IRendezvousSession.VTable, @ptrCast(self.vtable)).get_RemoteUser(@as(*const IRendezvousSession, @ptrCast(self)), bstrUserName);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IRendezvousSession_get_Flags(self: *const T, pFlags: ?*i32) callconv(.Inline) HRESULT {
            return @as(*const IRendezvousSession.VTable, @ptrCast(self.vtable)).get_Flags(@as(*const IRendezvousSession, @ptrCast(self)), pFlags);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IRendezvousSession_SendContextData(self: *const T, bstrData: ?BSTR) callconv(.Inline) HRESULT {
            return @as(*const IRendezvousSession.VTable, @ptrCast(self.vtable)).SendContextData(@as(*const IRendezvousSession, @ptrCast(self)), bstrData);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IRendezvousSession_Terminate(self: *const T, hr: HRESULT, bstrAppData: ?BSTR) callconv(.Inline) HRESULT {
            return @as(*const IRendezvousSession.VTable, @ptrCast(self.vtable)).Terminate(@as(*const IRendezvousSession, @ptrCast(self)), hr, bstrAppData);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

// TODO: this type is limited to platform 'windows6.0.6000'
const IID_DRendezvousSessionEvents_Value = Guid.initString("3fa19cf8-64c4-4f53-ae60-635b3806eca6");
pub const IID_DRendezvousSessionEvents = &IID_DRendezvousSessionEvents_Value;
pub const DRendezvousSessionEvents = extern struct {
    pub const VTable = extern struct {
        base: IDispatch.VTable,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IDispatch.MethodMixin(T);
    };}
    pub usingnamespace MethodMixin(@This());
};

// TODO: this type is limited to platform 'windows6.0.6000'
const IID_IRendezvousApplication_Value = Guid.initString("4f4d070b-a275-49fb-b10d-8ec26387b50d");
pub const IID_IRendezvousApplication = &IID_IRendezvousApplication_Value;
pub const IRendezvousApplication = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        SetRendezvousSession: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IRendezvousApplication,
                pRendezvousSession: ?*IUnknown,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IRendezvousApplication,
                pRendezvousSession: ?*IUnknown,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IRendezvousApplication_SetRendezvousSession(self: *const T, pRendezvousSession: ?*IUnknown) callconv(.Inline) HRESULT {
            return @as(*const IRendezvousApplication.VTable, @ptrCast(self.vtable)).SetRendezvousSession(@as(*const IRendezvousApplication, @ptrCast(self)), pRendezvousSession);
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
const BSTR = @import("../foundation.zig").BSTR;
const HRESULT = @import("../foundation.zig").HRESULT;
const IDispatch = @import("../system/com.zig").IDispatch;
const IUnknown = @import("../system/com.zig").IUnknown;

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
