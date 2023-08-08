//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (101)
//--------------------------------------------------------------------------------
pub const TIMERR_NOERROR = @as(u32, 0);
pub const TIMERR_NOCANDO = @as(u32, 97);
pub const TIMERR_STRUCT = @as(u32, 129);
pub const MAXPNAMELEN = @as(u32, 32);
pub const MAXERRORLENGTH = @as(u32, 256);
pub const MM_MICROSOFT = @as(u32, 1);
pub const MM_MIDI_MAPPER = @as(u32, 1);
pub const MM_WAVE_MAPPER = @as(u32, 2);
pub const MM_SNDBLST_MIDIOUT = @as(u32, 3);
pub const MM_SNDBLST_MIDIIN = @as(u32, 4);
pub const MM_SNDBLST_SYNTH = @as(u32, 5);
pub const MM_SNDBLST_WAVEOUT = @as(u32, 6);
pub const MM_SNDBLST_WAVEIN = @as(u32, 7);
pub const MM_ADLIB = @as(u32, 9);
pub const MM_MPU401_MIDIOUT = @as(u32, 10);
pub const MM_MPU401_MIDIIN = @as(u32, 11);
pub const MM_PC_JOYSTICK = @as(u32, 12);
pub const TIME_MS = @as(u32, 1);
pub const TIME_SAMPLES = @as(u32, 2);
pub const TIME_BYTES = @as(u32, 4);
pub const TIME_SMPTE = @as(u32, 8);
pub const TIME_MIDI = @as(u32, 16);
pub const TIME_TICKS = @as(u32, 32);
pub const MM_JOY1MOVE = @as(u32, 928);
pub const MM_JOY2MOVE = @as(u32, 929);
pub const MM_JOY1ZMOVE = @as(u32, 930);
pub const MM_JOY2ZMOVE = @as(u32, 931);
pub const MM_JOY1BUTTONDOWN = @as(u32, 949);
pub const MM_JOY2BUTTONDOWN = @as(u32, 950);
pub const MM_JOY1BUTTONUP = @as(u32, 951);
pub const MM_JOY2BUTTONUP = @as(u32, 952);
pub const MM_MCINOTIFY = @as(u32, 953);
pub const MM_WOM_OPEN = @as(u32, 955);
pub const MM_WOM_CLOSE = @as(u32, 956);
pub const MM_WOM_DONE = @as(u32, 957);
pub const MM_WIM_OPEN = @as(u32, 958);
pub const MM_WIM_CLOSE = @as(u32, 959);
pub const MM_WIM_DATA = @as(u32, 960);
pub const MM_MIM_OPEN = @as(u32, 961);
pub const MM_MIM_CLOSE = @as(u32, 962);
pub const MM_MIM_DATA = @as(u32, 963);
pub const MM_MIM_LONGDATA = @as(u32, 964);
pub const MM_MIM_ERROR = @as(u32, 965);
pub const MM_MIM_LONGERROR = @as(u32, 966);
pub const MM_MOM_OPEN = @as(u32, 967);
pub const MM_MOM_CLOSE = @as(u32, 968);
pub const MM_MOM_DONE = @as(u32, 969);
pub const MM_DRVM_OPEN = @as(u32, 976);
pub const MM_DRVM_CLOSE = @as(u32, 977);
pub const MM_DRVM_DATA = @as(u32, 978);
pub const MM_DRVM_ERROR = @as(u32, 979);
pub const MM_STREAM_OPEN = @as(u32, 980);
pub const MM_STREAM_CLOSE = @as(u32, 981);
pub const MM_STREAM_DONE = @as(u32, 982);
pub const MM_STREAM_ERROR = @as(u32, 983);
pub const MM_MOM_POSITIONCB = @as(u32, 970);
pub const MM_MCISIGNAL = @as(u32, 971);
pub const MM_MIM_MOREDATA = @as(u32, 972);
pub const MM_MIXM_LINE_CHANGE = @as(u32, 976);
pub const MM_MIXM_CONTROL_CHANGE = @as(u32, 977);
pub const MMSYSERR_BASE = @as(u32, 0);
pub const WAVERR_BASE = @as(u32, 32);
pub const MIDIERR_BASE = @as(u32, 64);
pub const TIMERR_BASE = @as(u32, 96);
pub const JOYERR_BASE = @as(u32, 160);
pub const MCIERR_BASE = @as(u32, 256);
pub const MIXERR_BASE = @as(u32, 1024);
pub const MCI_STRING_OFFSET = @as(u32, 512);
pub const MCI_VD_OFFSET = @as(u32, 1024);
pub const MCI_CD_OFFSET = @as(u32, 1088);
pub const MCI_WAVE_OFFSET = @as(u32, 1152);
pub const MCI_SEQ_OFFSET = @as(u32, 1216);
pub const MMSYSERR_NOERROR = @as(u32, 0);
pub const MMSYSERR_ERROR = @as(u32, 1);
pub const MMSYSERR_BADDEVICEID = @as(u32, 2);
pub const MMSYSERR_NOTENABLED = @as(u32, 3);
pub const MMSYSERR_ALLOCATED = @as(u32, 4);
pub const MMSYSERR_INVALHANDLE = @as(u32, 5);
pub const MMSYSERR_NODRIVER = @as(u32, 6);
pub const MMSYSERR_NOMEM = @as(u32, 7);
pub const MMSYSERR_NOTSUPPORTED = @as(u32, 8);
pub const MMSYSERR_BADERRNUM = @as(u32, 9);
pub const MMSYSERR_INVALFLAG = @as(u32, 10);
pub const MMSYSERR_INVALPARAM = @as(u32, 11);
pub const MMSYSERR_HANDLEBUSY = @as(u32, 12);
pub const MMSYSERR_INVALIDALIAS = @as(u32, 13);
pub const MMSYSERR_BADDB = @as(u32, 14);
pub const MMSYSERR_KEYNOTFOUND = @as(u32, 15);
pub const MMSYSERR_READERROR = @as(u32, 16);
pub const MMSYSERR_WRITEERROR = @as(u32, 17);
pub const MMSYSERR_DELETEERROR = @as(u32, 18);
pub const MMSYSERR_VALNOTFOUND = @as(u32, 19);
pub const MMSYSERR_NODRIVERCB = @as(u32, 20);
pub const MMSYSERR_MOREDATA = @as(u32, 21);
pub const MMSYSERR_LASTERROR = @as(u32, 21);
pub const TIME_ONESHOT = @as(u32, 0);
pub const TIME_PERIODIC = @as(u32, 1);
pub const TIME_CALLBACK_FUNCTION = @as(u32, 0);
pub const TIME_CALLBACK_EVENT_SET = @as(u32, 16);
pub const TIME_CALLBACK_EVENT_PULSE = @as(u32, 32);
pub const TIME_KILL_SYNCHRONOUS = @as(u32, 256);

//--------------------------------------------------------------------------------
// Section: Types (11)
//--------------------------------------------------------------------------------
pub const TIMECODE_SAMPLE_FLAGS = enum(u32) {
    TIMECODE_READ = 4121,
    ATN_READ = 5047,
    RTC_READ = 5050,
    _,
    pub fn initFlags(o: struct {
        TIMECODE_READ: u1 = 0,
        ATN_READ: u1 = 0,
        RTC_READ: u1 = 0,
    }) TIMECODE_SAMPLE_FLAGS {
        return @as(TIMECODE_SAMPLE_FLAGS, @enumFromInt(
              (if (o.TIMECODE_READ == 1) @intFromEnum(TIMECODE_SAMPLE_FLAGS.TIMECODE_READ) else 0)
            | (if (o.ATN_READ == 1) @intFromEnum(TIMECODE_SAMPLE_FLAGS.ATN_READ) else 0)
            | (if (o.RTC_READ == 1) @intFromEnum(TIMECODE_SAMPLE_FLAGS.RTC_READ) else 0)
        ));
    }
};
pub const ED_DEVCAP_TIMECODE_READ = TIMECODE_SAMPLE_FLAGS.TIMECODE_READ;
pub const ED_DEVCAP_ATN_READ = TIMECODE_SAMPLE_FLAGS.ATN_READ;
pub const ED_DEVCAP_RTC_READ = TIMECODE_SAMPLE_FLAGS.RTC_READ;

pub const HTASK = *opaque{};

pub const MMTIME = extern struct {
    wType: u32 align(1),
    u: extern union {
        ms: u32 align(1),
        sample: u32 align(1),
        cb: u32 align(1),
        ticks: u32 align(1),
        smpte: extern struct {
            hour: u8,
            min: u8,
            sec: u8,
            frame: u8,
            fps: u8,
            dummy: u8,
            pad: [2]u8,
        } align(1),
        midi: extern struct {
            songptrpos: u32 align(1),
        } align(1),
    } align(1),
};

pub const LPDRVCALLBACK = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        hdrvr: ?HDRVR,
        uMsg: u32,
        dwUser: usize,
        dw1: usize,
        dw2: usize,
    ) callconv(@import("std").os.windows.WINAPI) void,
    else => *const fn(
        hdrvr: ?HDRVR,
        uMsg: u32,
        dwUser: usize,
        dw1: usize,
        dw2: usize,
    ) callconv(@import("std").os.windows.WINAPI) void,
} ;

pub const TIMECAPS = extern struct {
    wPeriodMin: u32,
    wPeriodMax: u32,
};

pub const LPTIMECALLBACK = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        uTimerID: u32,
        uMsg: u32,
        dwUser: usize,
        dw1: usize,
        dw2: usize,
    ) callconv(@import("std").os.windows.WINAPI) void,
    else => *const fn(
        uTimerID: u32,
        uMsg: u32,
        dwUser: usize,
        dw1: usize,
        dw2: usize,
    ) callconv(@import("std").os.windows.WINAPI) void,
} ;

// TODO: this type is limited to platform 'windows5.0'
const IID_IReferenceClock_Value = Guid.initString("56a86897-0ad4-11ce-b03a-0020af0ba770");
pub const IID_IReferenceClock = &IID_IReferenceClock_Value;
pub const IReferenceClock = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        GetTime: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IReferenceClock,
                pTime: ?*i64,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IReferenceClock,
                pTime: ?*i64,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
        AdviseTime: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IReferenceClock,
                baseTime: i64,
                streamTime: i64,
                hEvent: ?HANDLE,
                pdwAdviseCookie: ?*usize,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IReferenceClock,
                baseTime: i64,
                streamTime: i64,
                hEvent: ?HANDLE,
                pdwAdviseCookie: ?*usize,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
        AdvisePeriodic: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IReferenceClock,
                startTime: i64,
                periodTime: i64,
                hSemaphore: ?HANDLE,
                pdwAdviseCookie: ?*usize,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IReferenceClock,
                startTime: i64,
                periodTime: i64,
                hSemaphore: ?HANDLE,
                pdwAdviseCookie: ?*usize,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
        Unadvise: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IReferenceClock,
                dwAdviseCookie: usize,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IReferenceClock,
                dwAdviseCookie: usize,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IReferenceClock_GetTime(self: *const T, pTime: ?*i64) callconv(.Inline) HRESULT {
            return @as(*const IReferenceClock.VTable, @ptrCast(self.vtable)).GetTime(@as(*const IReferenceClock, @ptrCast(self)), pTime);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IReferenceClock_AdviseTime(self: *const T, baseTime: i64, streamTime: i64, hEvent: ?HANDLE, pdwAdviseCookie: ?*usize) callconv(.Inline) HRESULT {
            return @as(*const IReferenceClock.VTable, @ptrCast(self.vtable)).AdviseTime(@as(*const IReferenceClock, @ptrCast(self)), baseTime, streamTime, hEvent, pdwAdviseCookie);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IReferenceClock_AdvisePeriodic(self: *const T, startTime: i64, periodTime: i64, hSemaphore: ?HANDLE, pdwAdviseCookie: ?*usize) callconv(.Inline) HRESULT {
            return @as(*const IReferenceClock.VTable, @ptrCast(self.vtable)).AdvisePeriodic(@as(*const IReferenceClock, @ptrCast(self)), startTime, periodTime, hSemaphore, pdwAdviseCookie);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IReferenceClock_Unadvise(self: *const T, dwAdviseCookie: usize) callconv(.Inline) HRESULT {
            return @as(*const IReferenceClock.VTable, @ptrCast(self.vtable)).Unadvise(@as(*const IReferenceClock, @ptrCast(self)), dwAdviseCookie);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

// TODO: this type is limited to platform 'windows6.0.6000'
const IID_IReferenceClockTimerControl_Value = Guid.initString("ebec459c-2eca-4d42-a8af-30df557614b8");
pub const IID_IReferenceClockTimerControl = &IID_IReferenceClockTimerControl_Value;
pub const IReferenceClockTimerControl = extern struct {
    pub const VTable = extern struct {
        base: IUnknown.VTable,
        SetDefaultTimerResolution: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IReferenceClockTimerControl,
                timerResolution: i64,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IReferenceClockTimerControl,
                timerResolution: i64,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
        GetDefaultTimerResolution: switch (@import("builtin").zig_backend) {
            .stage1 => fn(
                self: *const IReferenceClockTimerControl,
                pTimerResolution: ?*i64,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
            else => *const fn(
                self: *const IReferenceClockTimerControl,
                pTimerResolution: ?*i64,
            ) callconv(@import("std").os.windows.WINAPI) HRESULT,
        },
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IUnknown.MethodMixin(T);
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IReferenceClockTimerControl_SetDefaultTimerResolution(self: *const T, timerResolution: i64) callconv(.Inline) HRESULT {
            return @as(*const IReferenceClockTimerControl.VTable, @ptrCast(self.vtable)).SetDefaultTimerResolution(@as(*const IReferenceClockTimerControl, @ptrCast(self)), timerResolution);
        }
        // NOTE: method is namespaced with interface name to avoid conflicts for now
        pub fn IReferenceClockTimerControl_GetDefaultTimerResolution(self: *const T, pTimerResolution: ?*i64) callconv(.Inline) HRESULT {
            return @as(*const IReferenceClockTimerControl.VTable, @ptrCast(self.vtable)).GetDefaultTimerResolution(@as(*const IReferenceClockTimerControl, @ptrCast(self)), pTimerResolution);
        }
    };}
    pub usingnamespace MethodMixin(@This());
};

const IID_IReferenceClock2_Value = Guid.initString("36b73885-c2c8-11cf-8b46-00805f6cef60");
pub const IID_IReferenceClock2 = &IID_IReferenceClock2_Value;
pub const IReferenceClock2 = extern struct {
    pub const VTable = extern struct {
        base: IReferenceClock.VTable,
    };
    vtable: *const VTable,
    pub fn MethodMixin(comptime T: type) type { return struct {
        pub usingnamespace IReferenceClock.MethodMixin(T);
    };}
    pub usingnamespace MethodMixin(@This());
};

pub const TIMECODE = extern union {
    Anonymous: extern struct {
        wFrameRate: u16,
        wFrameFract: u16,
        dwFrames: u32,
    },
    qw: u64,
};

pub const TIMECODE_SAMPLE = extern struct {
    qwTick: i64,
    timecode: TIMECODE,
    dwUser: u32,
    dwFlags: TIMECODE_SAMPLE_FLAGS,
};


//--------------------------------------------------------------------------------
// Section: Functions (7)
//--------------------------------------------------------------------------------
// TODO: this type is limited to platform 'windows5.0'
pub extern "winmm" fn timeGetSystemTime(
    // TODO: what to do with BytesParamIndex 1?
    pmmt: ?*MMTIME,
    cbmmt: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "winmm" fn timeGetTime(
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "winmm" fn timeGetDevCaps(
    // TODO: what to do with BytesParamIndex 1?
    ptc: ?*TIMECAPS,
    cbtc: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "winmm" fn timeBeginPeriod(
    uPeriod: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.0'
pub extern "winmm" fn timeEndPeriod(
    uPeriod: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "winmm" fn timeSetEvent(
    uDelay: u32,
    uResolution: u32,
    fptc: ?LPTIMECALLBACK,
    dwUser: usize,
    fuEvent: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "winmm" fn timeKillEvent(
    uTimerID: u32,
) callconv(@import("std").os.windows.WINAPI) u32;


//--------------------------------------------------------------------------------
// Section: Unicode Aliases (0)
//--------------------------------------------------------------------------------
const thismodule = @This();
pub usingnamespace switch (@import("zig.zig").unicode_mode) {
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
const Guid = @import("zig.zig").Guid;
const HANDLE = @import("foundation.zig").HANDLE;
const HDRVR = @import("media/multimedia.zig").HDRVR;
const HRESULT = @import("foundation.zig").HRESULT;
const IUnknown = @import("system/com.zig").IUnknown;

test {
    // The following '_ = <FuncPtrType>' lines are a workaround for https://github.com/ziglang/zig/issues/4476
    if (@hasDecl(@This(), "LPDRVCALLBACK")) { _ = LPDRVCALLBACK; }
    if (@hasDecl(@This(), "LPTIMECALLBACK")) { _ = LPTIMECALLBACK; }

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
//--------------------------------------------------------------------------------
// Section: SubModules (13)
//--------------------------------------------------------------------------------
pub const audio = @import("media/audio.zig");
pub const device_manager = @import("media/device_manager.zig");
pub const direct_show = @import("media/direct_show.zig");
pub const dx_media_objects = @import("media/dx_media_objects.zig");
pub const kernel_streaming = @import("media/kernel_streaming.zig");
pub const library_sharing_services = @import("media/library_sharing_services.zig");
pub const media_foundation = @import("media/media_foundation.zig");
pub const media_player = @import("media/media_player.zig");
pub const multimedia = @import("media/multimedia.zig");
pub const picture_acquisition = @import("media/picture_acquisition.zig");
pub const speech = @import("media/speech.zig");
pub const streaming = @import("media/streaming.zig");
pub const windows_media_format = @import("media/windows_media_format.zig");
