//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (14)
//--------------------------------------------------------------------------------
pub const FIND_RESOURCE_DIRECTORY_TYPES = @as(u32, 256);
pub const FIND_RESOURCE_DIRECTORY_NAMES = @as(u32, 512);
pub const FIND_RESOURCE_DIRECTORY_LANGUAGES = @as(u32, 1024);
pub const RESOURCE_ENUM_LN = @as(u32, 1);
pub const RESOURCE_ENUM_MUI = @as(u32, 2);
pub const RESOURCE_ENUM_MUI_SYSTEM = @as(u32, 4);
pub const RESOURCE_ENUM_VALIDATE = @as(u32, 8);
pub const RESOURCE_ENUM_MODULE_EXACT = @as(u32, 16);
pub const SUPPORT_LANG_NUMBER = @as(u32, 32);
pub const GET_MODULE_HANDLE_EX_FLAG_PIN = @as(u32, 1);
pub const GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT = @as(u32, 2);
pub const GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS = @as(u32, 4);
pub const CURRENT_IMPORT_REDIRECTION_VERSION = @as(u32, 1);
pub const LOAD_LIBRARY_OS_INTEGRITY_CONTINUITY = @as(u32, 32768);

//--------------------------------------------------------------------------------
// Section: Types (12)
//--------------------------------------------------------------------------------
pub const LOAD_LIBRARY_FLAGS = enum(u32) {
    DONT_RESOLVE_DLL_REFERENCES = 1,
    LOAD_LIBRARY_AS_DATAFILE = 2,
    LOAD_WITH_ALTERED_SEARCH_PATH = 8,
    LOAD_IGNORE_CODE_AUTHZ_LEVEL = 16,
    LOAD_LIBRARY_AS_IMAGE_RESOURCE = 32,
    LOAD_LIBRARY_AS_DATAFILE_EXCLUSIVE = 64,
    LOAD_LIBRARY_REQUIRE_SIGNED_TARGET = 128,
    LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR = 256,
    LOAD_LIBRARY_SEARCH_APPLICATION_DIR = 512,
    LOAD_LIBRARY_SEARCH_USER_DIRS = 1024,
    LOAD_LIBRARY_SEARCH_SYSTEM32 = 2048,
    LOAD_LIBRARY_SEARCH_DEFAULT_DIRS = 4096,
    LOAD_LIBRARY_SAFE_CURRENT_DIRS = 8192,
    LOAD_LIBRARY_SEARCH_SYSTEM32_NO_FORWARDER = 16384,
    _,
    pub fn initFlags(o: struct {
        DONT_RESOLVE_DLL_REFERENCES: u1 = 0,
        LOAD_LIBRARY_AS_DATAFILE: u1 = 0,
        LOAD_WITH_ALTERED_SEARCH_PATH: u1 = 0,
        LOAD_IGNORE_CODE_AUTHZ_LEVEL: u1 = 0,
        LOAD_LIBRARY_AS_IMAGE_RESOURCE: u1 = 0,
        LOAD_LIBRARY_AS_DATAFILE_EXCLUSIVE: u1 = 0,
        LOAD_LIBRARY_REQUIRE_SIGNED_TARGET: u1 = 0,
        LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR: u1 = 0,
        LOAD_LIBRARY_SEARCH_APPLICATION_DIR: u1 = 0,
        LOAD_LIBRARY_SEARCH_USER_DIRS: u1 = 0,
        LOAD_LIBRARY_SEARCH_SYSTEM32: u1 = 0,
        LOAD_LIBRARY_SEARCH_DEFAULT_DIRS: u1 = 0,
        LOAD_LIBRARY_SAFE_CURRENT_DIRS: u1 = 0,
        LOAD_LIBRARY_SEARCH_SYSTEM32_NO_FORWARDER: u1 = 0,
    }) LOAD_LIBRARY_FLAGS {
        return @as(LOAD_LIBRARY_FLAGS, @enumFromInt(
              (if (o.DONT_RESOLVE_DLL_REFERENCES == 1) @intFromEnum(LOAD_LIBRARY_FLAGS.DONT_RESOLVE_DLL_REFERENCES) else 0)
            | (if (o.LOAD_LIBRARY_AS_DATAFILE == 1) @intFromEnum(LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_AS_DATAFILE) else 0)
            | (if (o.LOAD_WITH_ALTERED_SEARCH_PATH == 1) @intFromEnum(LOAD_LIBRARY_FLAGS.LOAD_WITH_ALTERED_SEARCH_PATH) else 0)
            | (if (o.LOAD_IGNORE_CODE_AUTHZ_LEVEL == 1) @intFromEnum(LOAD_LIBRARY_FLAGS.LOAD_IGNORE_CODE_AUTHZ_LEVEL) else 0)
            | (if (o.LOAD_LIBRARY_AS_IMAGE_RESOURCE == 1) @intFromEnum(LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_AS_IMAGE_RESOURCE) else 0)
            | (if (o.LOAD_LIBRARY_AS_DATAFILE_EXCLUSIVE == 1) @intFromEnum(LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_AS_DATAFILE_EXCLUSIVE) else 0)
            | (if (o.LOAD_LIBRARY_REQUIRE_SIGNED_TARGET == 1) @intFromEnum(LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_REQUIRE_SIGNED_TARGET) else 0)
            | (if (o.LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR == 1) @intFromEnum(LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR) else 0)
            | (if (o.LOAD_LIBRARY_SEARCH_APPLICATION_DIR == 1) @intFromEnum(LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_SEARCH_APPLICATION_DIR) else 0)
            | (if (o.LOAD_LIBRARY_SEARCH_USER_DIRS == 1) @intFromEnum(LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_SEARCH_USER_DIRS) else 0)
            | (if (o.LOAD_LIBRARY_SEARCH_SYSTEM32 == 1) @intFromEnum(LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_SEARCH_SYSTEM32) else 0)
            | (if (o.LOAD_LIBRARY_SEARCH_DEFAULT_DIRS == 1) @intFromEnum(LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_SEARCH_DEFAULT_DIRS) else 0)
            | (if (o.LOAD_LIBRARY_SAFE_CURRENT_DIRS == 1) @intFromEnum(LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_SAFE_CURRENT_DIRS) else 0)
            | (if (o.LOAD_LIBRARY_SEARCH_SYSTEM32_NO_FORWARDER == 1) @intFromEnum(LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_SEARCH_SYSTEM32_NO_FORWARDER) else 0)
        ));
    }
};
pub const DONT_RESOLVE_DLL_REFERENCES = LOAD_LIBRARY_FLAGS.DONT_RESOLVE_DLL_REFERENCES;
pub const LOAD_LIBRARY_AS_DATAFILE = LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_AS_DATAFILE;
pub const LOAD_WITH_ALTERED_SEARCH_PATH = LOAD_LIBRARY_FLAGS.LOAD_WITH_ALTERED_SEARCH_PATH;
pub const LOAD_IGNORE_CODE_AUTHZ_LEVEL = LOAD_LIBRARY_FLAGS.LOAD_IGNORE_CODE_AUTHZ_LEVEL;
pub const LOAD_LIBRARY_AS_IMAGE_RESOURCE = LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_AS_IMAGE_RESOURCE;
pub const LOAD_LIBRARY_AS_DATAFILE_EXCLUSIVE = LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_AS_DATAFILE_EXCLUSIVE;
pub const LOAD_LIBRARY_REQUIRE_SIGNED_TARGET = LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_REQUIRE_SIGNED_TARGET;
pub const LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR = LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR;
pub const LOAD_LIBRARY_SEARCH_APPLICATION_DIR = LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_SEARCH_APPLICATION_DIR;
pub const LOAD_LIBRARY_SEARCH_USER_DIRS = LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_SEARCH_USER_DIRS;
pub const LOAD_LIBRARY_SEARCH_SYSTEM32 = LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_SEARCH_SYSTEM32;
pub const LOAD_LIBRARY_SEARCH_DEFAULT_DIRS = LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_SEARCH_DEFAULT_DIRS;
pub const LOAD_LIBRARY_SAFE_CURRENT_DIRS = LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_SAFE_CURRENT_DIRS;
pub const LOAD_LIBRARY_SEARCH_SYSTEM32_NO_FORWARDER = LOAD_LIBRARY_FLAGS.LOAD_LIBRARY_SEARCH_SYSTEM32_NO_FORWARDER;

pub const ENUMUILANG = extern struct {
    NumOfEnumUILang: u32,
    SizeOfEnumUIBuffer: u32,
    pEnumUIBuffer: ?*u16,
};

pub const ENUMRESLANGPROCA = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        hModule: ?HINSTANCE,
        lpType: ?[*:0]const u8,
        lpName: ?[*:0]const u8,
        wLanguage: u16,
        lParam: isize,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
    else => *const fn(
        hModule: ?HINSTANCE,
        lpType: ?[*:0]const u8,
        lpName: ?[*:0]const u8,
        wLanguage: u16,
        lParam: isize,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
} ;

pub const ENUMRESLANGPROCW = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        hModule: ?HINSTANCE,
        lpType: ?[*:0]const u16,
        lpName: ?[*:0]const u16,
        wLanguage: u16,
        lParam: isize,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
    else => *const fn(
        hModule: ?HINSTANCE,
        lpType: ?[*:0]const u16,
        lpName: ?[*:0]const u16,
        wLanguage: u16,
        lParam: isize,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
} ;

pub const ENUMRESNAMEPROCA = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        hModule: ?HINSTANCE,
        lpType: ?[*:0]const u8,
        lpName: ?PSTR,
        lParam: isize,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
    else => *const fn(
        hModule: ?HINSTANCE,
        lpType: ?[*:0]const u8,
        lpName: ?PSTR,
        lParam: isize,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
} ;

pub const ENUMRESNAMEPROCW = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        hModule: ?HINSTANCE,
        lpType: ?[*:0]const u16,
        lpName: ?PWSTR,
        lParam: isize,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
    else => *const fn(
        hModule: ?HINSTANCE,
        lpType: ?[*:0]const u16,
        lpName: ?PWSTR,
        lParam: isize,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
} ;

pub const ENUMRESTYPEPROCA = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        hModule: ?HINSTANCE,
        lpType: ?PSTR,
        lParam: isize,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
    else => *const fn(
        hModule: ?HINSTANCE,
        lpType: ?PSTR,
        lParam: isize,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
} ;

pub const ENUMRESTYPEPROCW = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        hModule: ?HINSTANCE,
        lpType: ?PWSTR,
        lParam: isize,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
    else => *const fn(
        hModule: ?HINSTANCE,
        lpType: ?PWSTR,
        lParam: isize,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
} ;

pub const PGET_MODULE_HANDLE_EXA = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        dwFlags: u32,
        lpModuleName: ?[*:0]const u8,
        phModule: ?*?HINSTANCE,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
    else => *const fn(
        dwFlags: u32,
        lpModuleName: ?[*:0]const u8,
        phModule: ?*?HINSTANCE,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
} ;

pub const PGET_MODULE_HANDLE_EXW = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        dwFlags: u32,
        lpModuleName: ?[*:0]const u16,
        phModule: ?*?HINSTANCE,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
    else => *const fn(
        dwFlags: u32,
        lpModuleName: ?[*:0]const u16,
        phModule: ?*?HINSTANCE,
    ) callconv(@import("std").os.windows.WINAPI) BOOL,
} ;

pub const REDIRECTION_FUNCTION_DESCRIPTOR = extern struct {
    DllName: ?[*:0]const u8,
    FunctionName: ?[*:0]const u8,
    RedirectionTarget: ?*anyopaque,
};

pub const REDIRECTION_DESCRIPTOR = extern struct {
    Version: u32,
    FunctionCount: u32,
    Redirections: ?*REDIRECTION_FUNCTION_DESCRIPTOR,
};


//--------------------------------------------------------------------------------
// Section: Functions (49)
//--------------------------------------------------------------------------------
// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "kernel32" fn DisableThreadLibraryCalls(
    hLibModule: ?HINSTANCE,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn FindResourceExW(
    hModule: ?HINSTANCE,
    lpType: ?[*:0]const u16,
    lpName: ?[*:0]const u16,
    wLanguage: u16,
) callconv(@import("std").os.windows.WINAPI) ?HRSRC;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "kernel32" fn FreeLibrary(
    hLibModule: ?HINSTANCE,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "kernel32" fn FreeLibraryAndExitThread(
    hLibModule: ?HINSTANCE,
    dwExitCode: u32,
) callconv(@import("std").os.windows.WINAPI) void;

// TODO: this type is limited to platform 'windows5.0'
pub extern "kernel32" fn FreeResource(
    hResData: isize,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "kernel32" fn GetModuleFileNameA(
    hModule: ?HINSTANCE,
    lpFilename: [*:0]u8,
    nSize: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "kernel32" fn GetModuleFileNameW(
    hModule: ?HINSTANCE,
    lpFilename: [*:0]u16,
    nSize: u32,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "kernel32" fn GetModuleHandleA(
    lpModuleName: ?[*:0]const u8,
) callconv(@import("std").os.windows.WINAPI) ?HINSTANCE;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "kernel32" fn GetModuleHandleW(
    lpModuleName: ?[*:0]const u16,
) callconv(@import("std").os.windows.WINAPI) ?HINSTANCE;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "kernel32" fn GetModuleHandleExA(
    dwFlags: u32,
    lpModuleName: ?[*:0]const u8,
    phModule: ?*?HINSTANCE,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "kernel32" fn GetModuleHandleExW(
    dwFlags: u32,
    lpModuleName: ?[*:0]const u16,
    phModule: ?*?HINSTANCE,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "kernel32" fn GetProcAddress(
    hModule: ?HINSTANCE,
    lpProcName: ?[*:0]const u8,
) callconv(@import("std").os.windows.WINAPI) ?FARPROC;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "kernel32" fn LoadLibraryExA(
    lpLibFileName: ?[*:0]const u8,
    hFile: ?HANDLE,
    dwFlags: LOAD_LIBRARY_FLAGS,
) callconv(@import("std").os.windows.WINAPI) ?HINSTANCE;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "kernel32" fn LoadLibraryExW(
    lpLibFileName: ?[*:0]const u16,
    hFile: ?HANDLE,
    dwFlags: LOAD_LIBRARY_FLAGS,
) callconv(@import("std").os.windows.WINAPI) ?HINSTANCE;

// TODO: this type is limited to platform 'windows5.0'
pub extern "kernel32" fn LoadResource(
    hModule: ?HINSTANCE,
    hResInfo: ?HRSRC,
) callconv(@import("std").os.windows.WINAPI) isize;

// TODO: this type is limited to platform 'windows5.0'
pub extern "kernel32" fn LockResource(
    hResData: isize,
) callconv(@import("std").os.windows.WINAPI) ?*anyopaque;

// TODO: this type is limited to platform 'windows5.0'
pub extern "kernel32" fn SizeofResource(
    hModule: ?HINSTANCE,
    hResInfo: ?HRSRC,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows8.0'
pub extern "kernel32" fn AddDllDirectory(
    NewDirectory: ?[*:0]const u16,
) callconv(@import("std").os.windows.WINAPI) ?*anyopaque;

// TODO: this type is limited to platform 'windows8.0'
pub extern "kernel32" fn RemoveDllDirectory(
    Cookie: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows8.0'
pub extern "kernel32" fn SetDefaultDllDirectories(
    DirectoryFlags: LOAD_LIBRARY_FLAGS,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "kernel32" fn EnumResourceLanguagesExA(
    hModule: ?HINSTANCE,
    lpType: ?[*:0]const u8,
    lpName: ?[*:0]const u8,
    lpEnumFunc: ?ENUMRESLANGPROCA,
    lParam: isize,
    dwFlags: u32,
    LangId: u16,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "kernel32" fn EnumResourceLanguagesExW(
    hModule: ?HINSTANCE,
    lpType: ?[*:0]const u16,
    lpName: ?[*:0]const u16,
    lpEnumFunc: ?ENUMRESLANGPROCW,
    lParam: isize,
    dwFlags: u32,
    LangId: u16,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "kernel32" fn EnumResourceNamesExA(
    hModule: ?HINSTANCE,
    lpType: ?[*:0]const u8,
    lpEnumFunc: ?ENUMRESNAMEPROCA,
    lParam: isize,
    dwFlags: u32,
    LangId: u16,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "kernel32" fn EnumResourceNamesExW(
    hModule: ?HINSTANCE,
    lpType: ?[*:0]const u16,
    lpEnumFunc: ?ENUMRESNAMEPROCW,
    lParam: isize,
    dwFlags: u32,
    LangId: u16,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "kernel32" fn EnumResourceTypesExA(
    hModule: ?HINSTANCE,
    lpEnumFunc: ?ENUMRESTYPEPROCA,
    lParam: isize,
    dwFlags: u32,
    LangId: u16,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "kernel32" fn EnumResourceTypesExW(
    hModule: ?HINSTANCE,
    lpEnumFunc: ?ENUMRESTYPEPROCW,
    lParam: isize,
    dwFlags: u32,
    LangId: u16,
) callconv(@import("std").os.windows.WINAPI) BOOL;

pub extern "kernel32" fn FindResourceW(
    hModule: ?HINSTANCE,
    lpName: ?[*:0]const u16,
    lpType: ?[*:0]const u16,
) callconv(@import("std").os.windows.WINAPI) ?HRSRC;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "kernel32" fn LoadLibraryA(
    lpLibFileName: ?[*:0]const u8,
) callconv(@import("std").os.windows.WINAPI) ?HINSTANCE;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "kernel32" fn LoadLibraryW(
    lpLibFileName: ?[*:0]const u16,
) callconv(@import("std").os.windows.WINAPI) ?HINSTANCE;

pub extern "kernel32" fn EnumResourceNamesW(
    hModule: ?HINSTANCE,
    lpType: ?[*:0]const u16,
    lpEnumFunc: ?ENUMRESNAMEPROCW,
    lParam: isize,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.0'
pub extern "kernel32" fn EnumResourceNamesA(
    hModule: ?HINSTANCE,
    lpType: ?[*:0]const u8,
    lpEnumFunc: ?ENUMRESNAMEPROCA,
    lParam: isize,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "kernel32" fn LoadModule(
    lpModuleName: ?[*:0]const u8,
    lpParameterBlock: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows8.0'
pub extern "kernel32" fn LoadPackagedLibrary(
    lpwLibFileName: ?[*:0]const u16,
    Reserved: u32,
) callconv(@import("std").os.windows.WINAPI) ?HINSTANCE;

// TODO: this type is limited to platform 'windows5.0'
pub extern "kernel32" fn FindResourceA(
    hModule: ?HINSTANCE,
    lpName: ?[*:0]const u8,
    lpType: ?[*:0]const u8,
) callconv(@import("std").os.windows.WINAPI) ?HRSRC;

// TODO: this type is limited to platform 'windows5.0'
pub extern "kernel32" fn FindResourceExA(
    hModule: ?HINSTANCE,
    lpType: ?[*:0]const u8,
    lpName: ?[*:0]const u8,
    wLanguage: u16,
) callconv(@import("std").os.windows.WINAPI) ?HRSRC;

// TODO: this type is limited to platform 'windows5.0'
pub extern "kernel32" fn EnumResourceTypesA(
    hModule: ?HINSTANCE,
    lpEnumFunc: ?ENUMRESTYPEPROCA,
    lParam: isize,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.0'
pub extern "kernel32" fn EnumResourceTypesW(
    hModule: ?HINSTANCE,
    lpEnumFunc: ?ENUMRESTYPEPROCW,
    lParam: isize,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.0'
pub extern "kernel32" fn EnumResourceLanguagesA(
    hModule: ?HINSTANCE,
    lpType: ?[*:0]const u8,
    lpName: ?[*:0]const u8,
    lpEnumFunc: ?ENUMRESLANGPROCA,
    lParam: isize,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.0'
pub extern "kernel32" fn EnumResourceLanguagesW(
    hModule: ?HINSTANCE,
    lpType: ?[*:0]const u16,
    lpName: ?[*:0]const u16,
    lpEnumFunc: ?ENUMRESLANGPROCW,
    lParam: isize,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.0'
pub extern "kernel32" fn BeginUpdateResourceA(
    pFileName: ?[*:0]const u8,
    bDeleteExistingResources: BOOL,
) callconv(@import("std").os.windows.WINAPI) ?HANDLE;

// TODO: this type is limited to platform 'windows5.0'
pub extern "kernel32" fn BeginUpdateResourceW(
    pFileName: ?[*:0]const u16,
    bDeleteExistingResources: BOOL,
) callconv(@import("std").os.windows.WINAPI) ?HANDLE;

// TODO: this type is limited to platform 'windows5.0'
pub extern "kernel32" fn UpdateResourceA(
    hUpdate: ?HANDLE,
    lpType: ?[*:0]const u8,
    lpName: ?[*:0]const u8,
    wLanguage: u16,
    // TODO: what to do with BytesParamIndex 5?
    lpData: ?*anyopaque,
    cb: u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.0'
pub extern "kernel32" fn UpdateResourceW(
    hUpdate: ?HANDLE,
    lpType: ?[*:0]const u16,
    lpName: ?[*:0]const u16,
    wLanguage: u16,
    // TODO: what to do with BytesParamIndex 5?
    lpData: ?*anyopaque,
    cb: u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.0'
pub extern "kernel32" fn EndUpdateResourceA(
    hUpdate: ?HANDLE,
    fDiscard: BOOL,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.0'
pub extern "kernel32" fn EndUpdateResourceW(
    hUpdate: ?HANDLE,
    fDiscard: BOOL,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "kernel32" fn SetDllDirectoryA(
    lpPathName: ?[*:0]const u8,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "kernel32" fn SetDllDirectoryW(
    lpPathName: ?[*:0]const u16,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "kernel32" fn GetDllDirectoryA(
    nBufferLength: u32,
    lpBuffer: ?[*:0]u8,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "kernel32" fn GetDllDirectoryW(
    nBufferLength: u32,
    lpBuffer: ?[*:0]u16,
) callconv(@import("std").os.windows.WINAPI) u32;


//--------------------------------------------------------------------------------
// Section: Unicode Aliases (22)
//--------------------------------------------------------------------------------
const thismodule = @This();
pub usingnamespace switch (@import("../zig.zig").unicode_mode) {
    .ansi => struct {
        pub const ENUMRESLANGPROC = thismodule.ENUMRESLANGPROCA;
        pub const ENUMRESNAMEPROC = thismodule.ENUMRESNAMEPROCA;
        pub const ENUMRESTYPEPROC = thismodule.ENUMRESTYPEPROCA;
        pub const PGET_MODULE_HANDLE_EX = thismodule.PGET_MODULE_HANDLE_EXA;
        pub const FindResourceEx = thismodule.FindResourceExA;
        pub const GetModuleFileName = thismodule.GetModuleFileNameA;
        pub const GetModuleHandle = thismodule.GetModuleHandleA;
        pub const GetModuleHandleEx = thismodule.GetModuleHandleExA;
        pub const LoadLibraryEx = thismodule.LoadLibraryExA;
        pub const EnumResourceLanguagesEx = thismodule.EnumResourceLanguagesExA;
        pub const EnumResourceNamesEx = thismodule.EnumResourceNamesExA;
        pub const EnumResourceTypesEx = thismodule.EnumResourceTypesExA;
        pub const FindResource = thismodule.FindResourceA;
        pub const LoadLibrary = thismodule.LoadLibraryA;
        pub const EnumResourceNames = thismodule.EnumResourceNamesA;
        pub const EnumResourceTypes = thismodule.EnumResourceTypesA;
        pub const EnumResourceLanguages = thismodule.EnumResourceLanguagesA;
        pub const BeginUpdateResource = thismodule.BeginUpdateResourceA;
        pub const UpdateResource = thismodule.UpdateResourceA;
        pub const EndUpdateResource = thismodule.EndUpdateResourceA;
        pub const SetDllDirectory = thismodule.SetDllDirectoryA;
        pub const GetDllDirectory = thismodule.GetDllDirectoryA;
    },
    .wide => struct {
        pub const ENUMRESLANGPROC = thismodule.ENUMRESLANGPROCW;
        pub const ENUMRESNAMEPROC = thismodule.ENUMRESNAMEPROCW;
        pub const ENUMRESTYPEPROC = thismodule.ENUMRESTYPEPROCW;
        pub const PGET_MODULE_HANDLE_EX = thismodule.PGET_MODULE_HANDLE_EXW;
        pub const FindResourceEx = thismodule.FindResourceExW;
        pub const GetModuleFileName = thismodule.GetModuleFileNameW;
        pub const GetModuleHandle = thismodule.GetModuleHandleW;
        pub const GetModuleHandleEx = thismodule.GetModuleHandleExW;
        pub const LoadLibraryEx = thismodule.LoadLibraryExW;
        pub const EnumResourceLanguagesEx = thismodule.EnumResourceLanguagesExW;
        pub const EnumResourceNamesEx = thismodule.EnumResourceNamesExW;
        pub const EnumResourceTypesEx = thismodule.EnumResourceTypesExW;
        pub const FindResource = thismodule.FindResourceW;
        pub const LoadLibrary = thismodule.LoadLibraryW;
        pub const EnumResourceNames = thismodule.EnumResourceNamesW;
        pub const EnumResourceTypes = thismodule.EnumResourceTypesW;
        pub const EnumResourceLanguages = thismodule.EnumResourceLanguagesW;
        pub const BeginUpdateResource = thismodule.BeginUpdateResourceW;
        pub const UpdateResource = thismodule.UpdateResourceW;
        pub const EndUpdateResource = thismodule.EndUpdateResourceW;
        pub const SetDllDirectory = thismodule.SetDllDirectoryW;
        pub const GetDllDirectory = thismodule.GetDllDirectoryW;
    },
    .unspecified => if (@import("builtin").is_test) struct {
        pub const ENUMRESLANGPROC = *opaque{};
        pub const ENUMRESNAMEPROC = *opaque{};
        pub const ENUMRESTYPEPROC = *opaque{};
        pub const PGET_MODULE_HANDLE_EX = *opaque{};
        pub const FindResourceEx = *opaque{};
        pub const GetModuleFileName = *opaque{};
        pub const GetModuleHandle = *opaque{};
        pub const GetModuleHandleEx = *opaque{};
        pub const LoadLibraryEx = *opaque{};
        pub const EnumResourceLanguagesEx = *opaque{};
        pub const EnumResourceNamesEx = *opaque{};
        pub const EnumResourceTypesEx = *opaque{};
        pub const FindResource = *opaque{};
        pub const LoadLibrary = *opaque{};
        pub const EnumResourceNames = *opaque{};
        pub const EnumResourceTypes = *opaque{};
        pub const EnumResourceLanguages = *opaque{};
        pub const BeginUpdateResource = *opaque{};
        pub const UpdateResource = *opaque{};
        pub const EndUpdateResource = *opaque{};
        pub const SetDllDirectory = *opaque{};
        pub const GetDllDirectory = *opaque{};
    } else struct {
        pub const ENUMRESLANGPROC = @compileError("'ENUMRESLANGPROC' requires that UNICODE be set to true or false in the root module");
        pub const ENUMRESNAMEPROC = @compileError("'ENUMRESNAMEPROC' requires that UNICODE be set to true or false in the root module");
        pub const ENUMRESTYPEPROC = @compileError("'ENUMRESTYPEPROC' requires that UNICODE be set to true or false in the root module");
        pub const PGET_MODULE_HANDLE_EX = @compileError("'PGET_MODULE_HANDLE_EX' requires that UNICODE be set to true or false in the root module");
        pub const FindResourceEx = @compileError("'FindResourceEx' requires that UNICODE be set to true or false in the root module");
        pub const GetModuleFileName = @compileError("'GetModuleFileName' requires that UNICODE be set to true or false in the root module");
        pub const GetModuleHandle = @compileError("'GetModuleHandle' requires that UNICODE be set to true or false in the root module");
        pub const GetModuleHandleEx = @compileError("'GetModuleHandleEx' requires that UNICODE be set to true or false in the root module");
        pub const LoadLibraryEx = @compileError("'LoadLibraryEx' requires that UNICODE be set to true or false in the root module");
        pub const EnumResourceLanguagesEx = @compileError("'EnumResourceLanguagesEx' requires that UNICODE be set to true or false in the root module");
        pub const EnumResourceNamesEx = @compileError("'EnumResourceNamesEx' requires that UNICODE be set to true or false in the root module");
        pub const EnumResourceTypesEx = @compileError("'EnumResourceTypesEx' requires that UNICODE be set to true or false in the root module");
        pub const FindResource = @compileError("'FindResource' requires that UNICODE be set to true or false in the root module");
        pub const LoadLibrary = @compileError("'LoadLibrary' requires that UNICODE be set to true or false in the root module");
        pub const EnumResourceNames = @compileError("'EnumResourceNames' requires that UNICODE be set to true or false in the root module");
        pub const EnumResourceTypes = @compileError("'EnumResourceTypes' requires that UNICODE be set to true or false in the root module");
        pub const EnumResourceLanguages = @compileError("'EnumResourceLanguages' requires that UNICODE be set to true or false in the root module");
        pub const BeginUpdateResource = @compileError("'BeginUpdateResource' requires that UNICODE be set to true or false in the root module");
        pub const UpdateResource = @compileError("'UpdateResource' requires that UNICODE be set to true or false in the root module");
        pub const EndUpdateResource = @compileError("'EndUpdateResource' requires that UNICODE be set to true or false in the root module");
        pub const SetDllDirectory = @compileError("'SetDllDirectory' requires that UNICODE be set to true or false in the root module");
        pub const GetDllDirectory = @compileError("'GetDllDirectory' requires that UNICODE be set to true or false in the root module");
    },
};
//--------------------------------------------------------------------------------
// Section: Imports (7)
//--------------------------------------------------------------------------------
const BOOL = @import("../foundation.zig").BOOL;
const FARPROC = @import("../foundation.zig").FARPROC;
const HANDLE = @import("../foundation.zig").HANDLE;
const HINSTANCE = @import("../foundation.zig").HINSTANCE;
const HRSRC = @import("../foundation.zig").HRSRC;
const PSTR = @import("../foundation.zig").PSTR;
const PWSTR = @import("../foundation.zig").PWSTR;

test {
    // The following '_ = <FuncPtrType>' lines are a workaround for https://github.com/ziglang/zig/issues/4476
    if (@hasDecl(@This(), "ENUMRESLANGPROCA")) { _ = ENUMRESLANGPROCA; }
    if (@hasDecl(@This(), "ENUMRESLANGPROCW")) { _ = ENUMRESLANGPROCW; }
    if (@hasDecl(@This(), "ENUMRESNAMEPROCA")) { _ = ENUMRESNAMEPROCA; }
    if (@hasDecl(@This(), "ENUMRESNAMEPROCW")) { _ = ENUMRESNAMEPROCW; }
    if (@hasDecl(@This(), "ENUMRESTYPEPROCA")) { _ = ENUMRESTYPEPROCA; }
    if (@hasDecl(@This(), "ENUMRESTYPEPROCW")) { _ = ENUMRESTYPEPROCW; }
    if (@hasDecl(@This(), "PGET_MODULE_HANDLE_EXA")) { _ = PGET_MODULE_HANDLE_EXA; }
    if (@hasDecl(@This(), "PGET_MODULE_HANDLE_EXW")) { _ = PGET_MODULE_HANDLE_EXW; }

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
