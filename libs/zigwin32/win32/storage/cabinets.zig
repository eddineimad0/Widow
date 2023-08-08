//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (10)
//--------------------------------------------------------------------------------
pub const INCLUDED_FCI = @as(u32, 1);
pub const _A_NAME_IS_UTF = @as(u32, 128);
pub const _A_EXEC = @as(u32, 64);
pub const INCLUDED_TYPES_FCI_FDI = @as(u32, 1);
pub const CB_MAX_DISK = @as(i32, 2147483647);
pub const CB_MAX_FILENAME = @as(u32, 256);
pub const CB_MAX_CABINET_NAME = @as(u32, 256);
pub const CB_MAX_CAB_PATH = @as(u32, 256);
pub const CB_MAX_DISK_NAME = @as(u32, 256);
pub const INCLUDED_FDI = @as(u32, 1);

//--------------------------------------------------------------------------------
// Section: Types (34)
//--------------------------------------------------------------------------------
pub const FDICREATE_CPU_TYPE = enum(u32) {
    @"286" = 0,
    @"386" = 1,
};
pub const cpu80286 = FDICREATE_CPU_TYPE.@"286";
pub const cpu80386 = FDICREATE_CPU_TYPE.@"386";

pub const ERF = extern struct {
    erfOper: i32,
    erfType: i32,
    fError: BOOL,
};

pub const FCIERROR = enum(i32) {
    NONE = 0,
    OPEN_SRC = 1,
    READ_SRC = 2,
    ALLOC_FAIL = 3,
    TEMP_FILE = 4,
    BAD_COMPR_TYPE = 5,
    CAB_FILE = 6,
    USER_ABORT = 7,
    MCI_FAIL = 8,
    CAB_FORMAT_LIMIT = 9,
};
pub const FCIERR_NONE = FCIERROR.NONE;
pub const FCIERR_OPEN_SRC = FCIERROR.OPEN_SRC;
pub const FCIERR_READ_SRC = FCIERROR.READ_SRC;
pub const FCIERR_ALLOC_FAIL = FCIERROR.ALLOC_FAIL;
pub const FCIERR_TEMP_FILE = FCIERROR.TEMP_FILE;
pub const FCIERR_BAD_COMPR_TYPE = FCIERROR.BAD_COMPR_TYPE;
pub const FCIERR_CAB_FILE = FCIERROR.CAB_FILE;
pub const FCIERR_USER_ABORT = FCIERROR.USER_ABORT;
pub const FCIERR_MCI_FAIL = FCIERROR.MCI_FAIL;
pub const FCIERR_CAB_FORMAT_LIMIT = FCIERROR.CAB_FORMAT_LIMIT;

pub const CCAB = extern struct {
    cb: u32,
    cbFolderThresh: u32,
    cbReserveCFHeader: u32,
    cbReserveCFFolder: u32,
    cbReserveCFData: u32,
    iCab: i32,
    iDisk: i32,
    fFailOnIncompressible: i32,
    setID: u16,
    szDisk: [256]CHAR,
    szCab: [256]CHAR,
    szCabPath: [256]CHAR,
};

pub const PFNFCIALLOC = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        cb: u32,
    ) callconv(@import("std").os.windows.WINAPI) ?*anyopaque,
    else => *const fn(
        cb: u32,
    ) callconv(@import("std").os.windows.WINAPI) ?*anyopaque,
} ;

pub const PFNFCIFREE = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        memory: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) void,
    else => *const fn(
        memory: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) void,
} ;

pub const PFNFCIOPEN = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        pszFile: ?PSTR,
        oflag: i32,
        pmode: i32,
        err: ?*i32,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) isize,
    else => *const fn(
        pszFile: ?PSTR,
        oflag: i32,
        pmode: i32,
        err: ?*i32,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) isize,
} ;

pub const PFNFCIREAD = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        hf: isize,
        memory: ?*anyopaque,
        cb: u32,
        err: ?*i32,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) u32,
    else => *const fn(
        hf: isize,
        memory: ?*anyopaque,
        cb: u32,
        err: ?*i32,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) u32,
} ;

pub const PFNFCIWRITE = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        hf: isize,
        memory: ?*anyopaque,
        cb: u32,
        err: ?*i32,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) u32,
    else => *const fn(
        hf: isize,
        memory: ?*anyopaque,
        cb: u32,
        err: ?*i32,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) u32,
} ;

pub const PFNFCICLOSE = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        hf: isize,
        err: ?*i32,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) i32,
    else => *const fn(
        hf: isize,
        err: ?*i32,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) i32,
} ;

pub const PFNFCISEEK = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        hf: isize,
        dist: i32,
        seektype: i32,
        err: ?*i32,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) i32,
    else => *const fn(
        hf: isize,
        dist: i32,
        seektype: i32,
        err: ?*i32,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) i32,
} ;

pub const PFNFCIDELETE = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        pszFile: ?PSTR,
        err: ?*i32,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) i32,
    else => *const fn(
        pszFile: ?PSTR,
        err: ?*i32,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) i32,
} ;

pub const PFNFCIGETNEXTCABINET = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        pccab: ?*CCAB,
        cbPrevCab: u32,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
    else => *const fn(
        pccab: ?*CCAB,
        cbPrevCab: u32,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
} ;

pub const PFNFCIFILEPLACED = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        pccab: ?*CCAB,
        pszFile: ?PSTR,
        cbFile: i32,
        fContinuation: BOOL,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) i32,
    else => *const fn(
        pccab: ?*CCAB,
        pszFile: ?PSTR,
        cbFile: i32,
        fContinuation: BOOL,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) i32,
} ;

pub const PFNFCIGETOPENINFO = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        pszName: ?PSTR,
        pdate: ?*u16,
        ptime: ?*u16,
        pattribs: ?*u16,
        err: ?*i32,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) isize,
    else => *const fn(
        pszName: ?PSTR,
        pdate: ?*u16,
        ptime: ?*u16,
        pattribs: ?*u16,
        err: ?*i32,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) isize,
} ;

pub const PFNFCISTATUS = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        typeStatus: u32,
        cb1: u32,
        cb2: u32,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) i32,
    else => *const fn(
        typeStatus: u32,
        cb1: u32,
        cb2: u32,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) i32,
} ;

pub const PFNFCIGETTEMPFILE = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        // TODO: what to do with BytesParamIndex 1?
        pszTempName: ?PSTR,
        cbTempName: i32,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
    else => *const fn(
        // TODO: what to do with BytesParamIndex 1?
        pszTempName: ?PSTR,
        cbTempName: i32,
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
} ;

pub const FDIERROR = enum(i32) {
    NONE = 0,
    CABINET_NOT_FOUND = 1,
    NOT_A_CABINET = 2,
    UNKNOWN_CABINET_VERSION = 3,
    CORRUPT_CABINET = 4,
    ALLOC_FAIL = 5,
    BAD_COMPR_TYPE = 6,
    MDI_FAIL = 7,
    TARGET_FILE = 8,
    RESERVE_MISMATCH = 9,
    WRONG_CABINET = 10,
    USER_ABORT = 11,
    EOF = 12,
};
pub const FDIERROR_NONE = FDIERROR.NONE;
pub const FDIERROR_CABINET_NOT_FOUND = FDIERROR.CABINET_NOT_FOUND;
pub const FDIERROR_NOT_A_CABINET = FDIERROR.NOT_A_CABINET;
pub const FDIERROR_UNKNOWN_CABINET_VERSION = FDIERROR.UNKNOWN_CABINET_VERSION;
pub const FDIERROR_CORRUPT_CABINET = FDIERROR.CORRUPT_CABINET;
pub const FDIERROR_ALLOC_FAIL = FDIERROR.ALLOC_FAIL;
pub const FDIERROR_BAD_COMPR_TYPE = FDIERROR.BAD_COMPR_TYPE;
pub const FDIERROR_MDI_FAIL = FDIERROR.MDI_FAIL;
pub const FDIERROR_TARGET_FILE = FDIERROR.TARGET_FILE;
pub const FDIERROR_RESERVE_MISMATCH = FDIERROR.RESERVE_MISMATCH;
pub const FDIERROR_WRONG_CABINET = FDIERROR.WRONG_CABINET;
pub const FDIERROR_USER_ABORT = FDIERROR.USER_ABORT;
pub const FDIERROR_EOF = FDIERROR.EOF;

pub const FDICABINETINFO = extern struct {
    cbCabinet: i32,
    cFolders: u16,
    cFiles: u16,
    setID: u16,
    iCabinet: u16,
    fReserve: BOOL,
    hasprev: BOOL,
    hasnext: BOOL,
};

pub const FDIDECRYPTTYPE = enum(i32) {
    NEW_CABINET = 0,
    NEW_FOLDER = 1,
    DECRYPT = 2,
};
pub const fdidtNEW_CABINET = FDIDECRYPTTYPE.NEW_CABINET;
pub const fdidtNEW_FOLDER = FDIDECRYPTTYPE.NEW_FOLDER;
pub const fdidtDECRYPT = FDIDECRYPTTYPE.DECRYPT;

pub const FDIDECRYPT = extern struct {
    fdidt: FDIDECRYPTTYPE,
    pvUser: ?*anyopaque,
    Anonymous: extern union {
        cabinet: extern struct {
            pHeaderReserve: ?*anyopaque,
            cbHeaderReserve: u16,
            setID: u16,
            iCabinet: i32,
        },
        folder: extern struct {
            pFolderReserve: ?*anyopaque,
            cbFolderReserve: u16,
            iFolder: u16,
        },
        decrypt: extern struct {
            pDataReserve: ?*anyopaque,
            cbDataReserve: u16,
            pbData: ?*anyopaque,
            cbData: u16,
            fSplit: BOOL,
            cbPartial: u16,
        },
    },
};

pub const PFNALLOC = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        cb: u32,
    ) callconv(@import("std").os.windows.WINAPI) ?*anyopaque,
    else => *const fn(
        cb: u32,
    ) callconv(@import("std").os.windows.WINAPI) ?*anyopaque,
} ;

pub const PFNFREE = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) void,
    else => *const fn(
        pv: ?*anyopaque,
    ) callconv(@import("std").os.windows.WINAPI) void,
} ;

pub const PFNOPEN = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        pszFile: ?PSTR,
        oflag: i32,
        pmode: i32,
    ) callconv(@import("std").os.windows.WINAPI) isize,
    else => *const fn(
        pszFile: ?PSTR,
        oflag: i32,
        pmode: i32,
    ) callconv(@import("std").os.windows.WINAPI) isize,
} ;

pub const PFNREAD = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        hf: isize,
        // TODO: what to do with BytesParamIndex 2?
        pv: ?*anyopaque,
        cb: u32,
    ) callconv(@import("std").os.windows.WINAPI) u32,
    else => *const fn(
        hf: isize,
        // TODO: what to do with BytesParamIndex 2?
        pv: ?*anyopaque,
        cb: u32,
    ) callconv(@import("std").os.windows.WINAPI) u32,
} ;

pub const PFNWRITE = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        hf: isize,
        // TODO: what to do with BytesParamIndex 2?
        pv: ?*anyopaque,
        cb: u32,
    ) callconv(@import("std").os.windows.WINAPI) u32,
    else => *const fn(
        hf: isize,
        // TODO: what to do with BytesParamIndex 2?
        pv: ?*anyopaque,
        cb: u32,
    ) callconv(@import("std").os.windows.WINAPI) u32,
} ;

pub const PFNCLOSE = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        hf: isize,
    ) callconv(@import("std").os.windows.WINAPI) i32,
    else => *const fn(
        hf: isize,
    ) callconv(@import("std").os.windows.WINAPI) i32,
} ;

pub const PFNSEEK = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        hf: isize,
        dist: i32,
        seektype: i32,
    ) callconv(@import("std").os.windows.WINAPI) i32,
    else => *const fn(
        hf: isize,
        dist: i32,
        seektype: i32,
    ) callconv(@import("std").os.windows.WINAPI) i32,
} ;

pub const PFNFDIDECRYPT = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        pfdid: ?*FDIDECRYPT,
    ) callconv(@import("std").os.windows.WINAPI) i32,
    else => *const fn(
        pfdid: ?*FDIDECRYPT,
    ) callconv(@import("std").os.windows.WINAPI) i32,
} ;

pub const FDINOTIFICATION = extern struct {
    cb: i32,
    psz1: ?PSTR,
    psz2: ?PSTR,
    psz3: ?PSTR,
    pv: ?*anyopaque,
    hf: isize,
    date: u16,
    time: u16,
    attribs: u16,
    setID: u16,
    iCabinet: u16,
    iFolder: u16,
    fdie: FDIERROR,
};

pub const FDINOTIFICATIONTYPE = enum(i32) {
    CABINET_INFO = 0,
    PARTIAL_FILE = 1,
    COPY_FILE = 2,
    CLOSE_FILE_INFO = 3,
    NEXT_CABINET = 4,
    ENUMERATE = 5,
};
pub const fdintCABINET_INFO = FDINOTIFICATIONTYPE.CABINET_INFO;
pub const fdintPARTIAL_FILE = FDINOTIFICATIONTYPE.PARTIAL_FILE;
pub const fdintCOPY_FILE = FDINOTIFICATIONTYPE.COPY_FILE;
pub const fdintCLOSE_FILE_INFO = FDINOTIFICATIONTYPE.CLOSE_FILE_INFO;
pub const fdintNEXT_CABINET = FDINOTIFICATIONTYPE.NEXT_CABINET;
pub const fdintENUMERATE = FDINOTIFICATIONTYPE.ENUMERATE;

pub const PFNFDINOTIFY = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        fdint: FDINOTIFICATIONTYPE,
        pfdin: ?*FDINOTIFICATION,
    ) callconv(@import("std").os.windows.WINAPI) isize,
    else => *const fn(
        fdint: FDINOTIFICATIONTYPE,
        pfdin: ?*FDINOTIFICATION,
    ) callconv(@import("std").os.windows.WINAPI) isize,
} ;



pub const FDISPILLFILE = switch(@import("../zig.zig").arch) {
    .X64, .Arm64 => extern struct {
        ach: [2]CHAR,
        cbFile: i32,
    },
    .X86 => extern struct {
        ach: [2]CHAR align(1),
        cbFile: i32 align(1),
    },
};

//--------------------------------------------------------------------------------
// Section: Functions (10)
//--------------------------------------------------------------------------------
pub extern "cabinet" fn FCICreate(
    perf: ?*ERF,
    pfnfcifp: ?PFNFCIFILEPLACED,
    pfna: ?PFNFCIALLOC,
    pfnf: ?PFNFCIFREE,
    pfnopen: ?PFNFCIOPEN,
    pfnread: ?PFNFCIREAD,
    pfnwrite: ?PFNFCIWRITE,
    pfnclose: ?PFNFCICLOSE,
    pfnseek: ?PFNFCISEEK,
    pfndelete: ?PFNFCIDELETE,
    pfnfcigtf: ?PFNFCIGETTEMPFILE,
    pccab: ?*CCAB,
    pv: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) ?*anyopaque;

pub extern "cabinet" fn FCIAddFile(
    hfci: ?*anyopaque,
    pszSourceFile: ?PSTR,
    pszFileName: ?PSTR,
    fExecute: BOOL,
    pfnfcignc: ?PFNFCIGETNEXTCABINET,
    pfnfcis: ?PFNFCISTATUS,
    pfnfcigoi: ?PFNFCIGETOPENINFO,
    typeCompress: u16,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "cabinet" fn FCIFlushCabinet(
    hfci: ?*anyopaque,
    fGetNextCab: BOOL,
    pfnfcignc: ?PFNFCIGETNEXTCABINET,
    pfnfcis: ?PFNFCISTATUS,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "cabinet" fn FCIFlushFolder(
    hfci: ?*anyopaque,
    pfnfcignc: ?PFNFCIGETNEXTCABINET,
    pfnfcis: ?PFNFCISTATUS,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "cabinet" fn FCIDestroy(
    hfci: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.0'
pub extern "cabinet" fn FDICreate(
    pfnalloc: ?PFNALLOC,
    pfnfree: ?PFNFREE,
    pfnopen: ?PFNOPEN,
    pfnread: ?PFNREAD,
    pfnwrite: ?PFNWRITE,
    pfnclose: ?PFNCLOSE,
    pfnseek: ?PFNSEEK,
    cpuType: FDICREATE_CPU_TYPE,
    perf: ?*ERF,
) callconv(@import("std").os.windows.WINAPI) ?*anyopaque;

// TODO: this type is limited to platform 'windows5.0'
pub extern "cabinet" fn FDIIsCabinet(
    hfdi: ?*anyopaque,
    hf: isize,
    pfdici: ?*FDICABINETINFO,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.0'
pub extern "cabinet" fn FDICopy(
    hfdi: ?*anyopaque,
    pszCabinet: ?PSTR,
    pszCabPath: ?PSTR,
    flags: i32,
    pfnfdin: ?PFNFDINOTIFY,
    pfnfdid: ?PFNFDIDECRYPT,
    pvUser: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.0'
pub extern "cabinet" fn FDIDestroy(
    hfdi: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "cabinet" fn FDITruncateCabinet(
    hfdi: ?*anyopaque,
    pszCabinetName: ?PSTR,
    iFolderToDelete: u16,
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
// Section: Imports (3)
//--------------------------------------------------------------------------------
const BOOL = @import("../foundation.zig").BOOL;
const CHAR = @import("../foundation.zig").CHAR;
const PSTR = @import("../foundation.zig").PSTR;

test {
    // The following '_ = <FuncPtrType>' lines are a workaround for https://github.com/ziglang/zig/issues/4476
    if (@hasDecl(@This(), "PFNFCIALLOC")) { _ = PFNFCIALLOC; }
    if (@hasDecl(@This(), "PFNFCIFREE")) { _ = PFNFCIFREE; }
    if (@hasDecl(@This(), "PFNFCIOPEN")) { _ = PFNFCIOPEN; }
    if (@hasDecl(@This(), "PFNFCIREAD")) { _ = PFNFCIREAD; }
    if (@hasDecl(@This(), "PFNFCIWRITE")) { _ = PFNFCIWRITE; }
    if (@hasDecl(@This(), "PFNFCICLOSE")) { _ = PFNFCICLOSE; }
    if (@hasDecl(@This(), "PFNFCISEEK")) { _ = PFNFCISEEK; }
    if (@hasDecl(@This(), "PFNFCIDELETE")) { _ = PFNFCIDELETE; }
    if (@hasDecl(@This(), "PFNFCIGETNEXTCABINET")) { _ = PFNFCIGETNEXTCABINET; }
    if (@hasDecl(@This(), "PFNFCIFILEPLACED")) { _ = PFNFCIFILEPLACED; }
    if (@hasDecl(@This(), "PFNFCIGETOPENINFO")) { _ = PFNFCIGETOPENINFO; }
    if (@hasDecl(@This(), "PFNFCISTATUS")) { _ = PFNFCISTATUS; }
    if (@hasDecl(@This(), "PFNFCIGETTEMPFILE")) { _ = PFNFCIGETTEMPFILE; }
    if (@hasDecl(@This(), "PFNALLOC")) { _ = PFNALLOC; }
    if (@hasDecl(@This(), "PFNFREE")) { _ = PFNFREE; }
    if (@hasDecl(@This(), "PFNOPEN")) { _ = PFNOPEN; }
    if (@hasDecl(@This(), "PFNREAD")) { _ = PFNREAD; }
    if (@hasDecl(@This(), "PFNWRITE")) { _ = PFNWRITE; }
    if (@hasDecl(@This(), "PFNCLOSE")) { _ = PFNCLOSE; }
    if (@hasDecl(@This(), "PFNSEEK")) { _ = PFNSEEK; }
    if (@hasDecl(@This(), "PFNFDIDECRYPT")) { _ = PFNFDIDECRYPT; }
    if (@hasDecl(@This(), "PFNFDINOTIFY")) { _ = PFNFDINOTIFY; }

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
