//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (13)
//--------------------------------------------------------------------------------
pub const MAX_REASON_NAME_LEN = @as(u32, 64);
pub const MAX_REASON_DESC_LEN = @as(u32, 256);
pub const MAX_REASON_BUGID_LEN = @as(u32, 32);
pub const MAX_REASON_COMMENT_LEN = @as(u32, 512);
pub const SHUTDOWN_TYPE_LEN = @as(u32, 32);
pub const POLICY_SHOWREASONUI_NEVER = @as(u32, 0);
pub const POLICY_SHOWREASONUI_ALWAYS = @as(u32, 1);
pub const POLICY_SHOWREASONUI_WORKSTATIONONLY = @as(u32, 2);
pub const POLICY_SHOWREASONUI_SERVERONLY = @as(u32, 3);
pub const SNAPSHOT_POLICY_NEVER = @as(u32, 0);
pub const SNAPSHOT_POLICY_ALWAYS = @as(u32, 1);
pub const SNAPSHOT_POLICY_UNPLANNED = @as(u32, 2);
pub const MAX_NUM_REASONS = @as(u32, 256);

//--------------------------------------------------------------------------------
// Section: Types (3)
//--------------------------------------------------------------------------------
pub const SHUTDOWN_REASON = enum(u32) {
    NONE = 0,
    FLAG_COMMENT_REQUIRED = 16777216,
    FLAG_DIRTY_PROBLEM_ID_REQUIRED = 33554432,
    FLAG_CLEAN_UI = 67108864,
    FLAG_DIRTY_UI = 134217728,
    FLAG_MOBILE_UI_RESERVED = 268435456,
    FLAG_USER_DEFINED = 1073741824,
    FLAG_PLANNED = 2147483648,
    // MAJOR_OTHER = 0, this enum value conflicts with NONE
    // MAJOR_NONE = 0, this enum value conflicts with NONE
    MAJOR_HARDWARE = 65536,
    MAJOR_OPERATINGSYSTEM = 131072,
    MAJOR_SOFTWARE = 196608,
    MAJOR_APPLICATION = 262144,
    MAJOR_SYSTEM = 327680,
    MAJOR_POWER = 393216,
    MAJOR_LEGACY_API = 458752,
    // MINOR_OTHER = 0, this enum value conflicts with NONE
    MINOR_NONE = 255,
    MINOR_MAINTENANCE = 1,
    MINOR_INSTALLATION = 2,
    MINOR_UPGRADE = 3,
    MINOR_RECONFIG = 4,
    MINOR_HUNG = 5,
    MINOR_UNSTABLE = 6,
    MINOR_DISK = 7,
    MINOR_PROCESSOR = 8,
    MINOR_NETWORKCARD = 9,
    MINOR_POWER_SUPPLY = 10,
    MINOR_CORDUNPLUGGED = 11,
    MINOR_ENVIRONMENT = 12,
    MINOR_HARDWARE_DRIVER = 13,
    MINOR_OTHERDRIVER = 14,
    MINOR_BLUESCREEN = 15,
    MINOR_SERVICEPACK = 16,
    MINOR_HOTFIX = 17,
    MINOR_SECURITYFIX = 18,
    MINOR_SECURITY = 19,
    MINOR_NETWORK_CONNECTIVITY = 20,
    MINOR_WMI = 21,
    MINOR_SERVICEPACK_UNINSTALL = 22,
    MINOR_HOTFIX_UNINSTALL = 23,
    MINOR_SECURITYFIX_UNINSTALL = 24,
    MINOR_MMC = 25,
    MINOR_SYSTEMRESTORE = 26,
    MINOR_TERMSRV = 32,
    MINOR_DC_PROMOTION = 33,
    MINOR_DC_DEMOTION = 34,
    // UNKNOWN = 255, this enum value conflicts with MINOR_NONE
    LEGACY_API = 2147942400,
    VALID_BIT_MASK = 3238002687,
    _,
    pub fn initFlags(o: struct {
        NONE: u1 = 0,
        FLAG_COMMENT_REQUIRED: u1 = 0,
        FLAG_DIRTY_PROBLEM_ID_REQUIRED: u1 = 0,
        FLAG_CLEAN_UI: u1 = 0,
        FLAG_DIRTY_UI: u1 = 0,
        FLAG_MOBILE_UI_RESERVED: u1 = 0,
        FLAG_USER_DEFINED: u1 = 0,
        FLAG_PLANNED: u1 = 0,
        MAJOR_HARDWARE: u1 = 0,
        MAJOR_OPERATINGSYSTEM: u1 = 0,
        MAJOR_SOFTWARE: u1 = 0,
        MAJOR_APPLICATION: u1 = 0,
        MAJOR_SYSTEM: u1 = 0,
        MAJOR_POWER: u1 = 0,
        MAJOR_LEGACY_API: u1 = 0,
        MINOR_NONE: u1 = 0,
        MINOR_MAINTENANCE: u1 = 0,
        MINOR_INSTALLATION: u1 = 0,
        MINOR_UPGRADE: u1 = 0,
        MINOR_RECONFIG: u1 = 0,
        MINOR_HUNG: u1 = 0,
        MINOR_UNSTABLE: u1 = 0,
        MINOR_DISK: u1 = 0,
        MINOR_PROCESSOR: u1 = 0,
        MINOR_NETWORKCARD: u1 = 0,
        MINOR_POWER_SUPPLY: u1 = 0,
        MINOR_CORDUNPLUGGED: u1 = 0,
        MINOR_ENVIRONMENT: u1 = 0,
        MINOR_HARDWARE_DRIVER: u1 = 0,
        MINOR_OTHERDRIVER: u1 = 0,
        MINOR_BLUESCREEN: u1 = 0,
        MINOR_SERVICEPACK: u1 = 0,
        MINOR_HOTFIX: u1 = 0,
        MINOR_SECURITYFIX: u1 = 0,
        MINOR_SECURITY: u1 = 0,
        MINOR_NETWORK_CONNECTIVITY: u1 = 0,
        MINOR_WMI: u1 = 0,
        MINOR_SERVICEPACK_UNINSTALL: u1 = 0,
        MINOR_HOTFIX_UNINSTALL: u1 = 0,
        MINOR_SECURITYFIX_UNINSTALL: u1 = 0,
        MINOR_MMC: u1 = 0,
        MINOR_SYSTEMRESTORE: u1 = 0,
        MINOR_TERMSRV: u1 = 0,
        MINOR_DC_PROMOTION: u1 = 0,
        MINOR_DC_DEMOTION: u1 = 0,
        LEGACY_API: u1 = 0,
        VALID_BIT_MASK: u1 = 0,
    }) SHUTDOWN_REASON {
        return @as(SHUTDOWN_REASON, @enumFromInt(
              (if (o.NONE == 1) @intFromEnum(SHUTDOWN_REASON.NONE) else 0)
            | (if (o.FLAG_COMMENT_REQUIRED == 1) @intFromEnum(SHUTDOWN_REASON.FLAG_COMMENT_REQUIRED) else 0)
            | (if (o.FLAG_DIRTY_PROBLEM_ID_REQUIRED == 1) @intFromEnum(SHUTDOWN_REASON.FLAG_DIRTY_PROBLEM_ID_REQUIRED) else 0)
            | (if (o.FLAG_CLEAN_UI == 1) @intFromEnum(SHUTDOWN_REASON.FLAG_CLEAN_UI) else 0)
            | (if (o.FLAG_DIRTY_UI == 1) @intFromEnum(SHUTDOWN_REASON.FLAG_DIRTY_UI) else 0)
            | (if (o.FLAG_MOBILE_UI_RESERVED == 1) @intFromEnum(SHUTDOWN_REASON.FLAG_MOBILE_UI_RESERVED) else 0)
            | (if (o.FLAG_USER_DEFINED == 1) @intFromEnum(SHUTDOWN_REASON.FLAG_USER_DEFINED) else 0)
            | (if (o.FLAG_PLANNED == 1) @intFromEnum(SHUTDOWN_REASON.FLAG_PLANNED) else 0)
            | (if (o.MAJOR_HARDWARE == 1) @intFromEnum(SHUTDOWN_REASON.MAJOR_HARDWARE) else 0)
            | (if (o.MAJOR_OPERATINGSYSTEM == 1) @intFromEnum(SHUTDOWN_REASON.MAJOR_OPERATINGSYSTEM) else 0)
            | (if (o.MAJOR_SOFTWARE == 1) @intFromEnum(SHUTDOWN_REASON.MAJOR_SOFTWARE) else 0)
            | (if (o.MAJOR_APPLICATION == 1) @intFromEnum(SHUTDOWN_REASON.MAJOR_APPLICATION) else 0)
            | (if (o.MAJOR_SYSTEM == 1) @intFromEnum(SHUTDOWN_REASON.MAJOR_SYSTEM) else 0)
            | (if (o.MAJOR_POWER == 1) @intFromEnum(SHUTDOWN_REASON.MAJOR_POWER) else 0)
            | (if (o.MAJOR_LEGACY_API == 1) @intFromEnum(SHUTDOWN_REASON.MAJOR_LEGACY_API) else 0)
            | (if (o.MINOR_NONE == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_NONE) else 0)
            | (if (o.MINOR_MAINTENANCE == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_MAINTENANCE) else 0)
            | (if (o.MINOR_INSTALLATION == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_INSTALLATION) else 0)
            | (if (o.MINOR_UPGRADE == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_UPGRADE) else 0)
            | (if (o.MINOR_RECONFIG == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_RECONFIG) else 0)
            | (if (o.MINOR_HUNG == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_HUNG) else 0)
            | (if (o.MINOR_UNSTABLE == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_UNSTABLE) else 0)
            | (if (o.MINOR_DISK == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_DISK) else 0)
            | (if (o.MINOR_PROCESSOR == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_PROCESSOR) else 0)
            | (if (o.MINOR_NETWORKCARD == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_NETWORKCARD) else 0)
            | (if (o.MINOR_POWER_SUPPLY == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_POWER_SUPPLY) else 0)
            | (if (o.MINOR_CORDUNPLUGGED == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_CORDUNPLUGGED) else 0)
            | (if (o.MINOR_ENVIRONMENT == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_ENVIRONMENT) else 0)
            | (if (o.MINOR_HARDWARE_DRIVER == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_HARDWARE_DRIVER) else 0)
            | (if (o.MINOR_OTHERDRIVER == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_OTHERDRIVER) else 0)
            | (if (o.MINOR_BLUESCREEN == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_BLUESCREEN) else 0)
            | (if (o.MINOR_SERVICEPACK == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_SERVICEPACK) else 0)
            | (if (o.MINOR_HOTFIX == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_HOTFIX) else 0)
            | (if (o.MINOR_SECURITYFIX == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_SECURITYFIX) else 0)
            | (if (o.MINOR_SECURITY == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_SECURITY) else 0)
            | (if (o.MINOR_NETWORK_CONNECTIVITY == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_NETWORK_CONNECTIVITY) else 0)
            | (if (o.MINOR_WMI == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_WMI) else 0)
            | (if (o.MINOR_SERVICEPACK_UNINSTALL == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_SERVICEPACK_UNINSTALL) else 0)
            | (if (o.MINOR_HOTFIX_UNINSTALL == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_HOTFIX_UNINSTALL) else 0)
            | (if (o.MINOR_SECURITYFIX_UNINSTALL == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_SECURITYFIX_UNINSTALL) else 0)
            | (if (o.MINOR_MMC == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_MMC) else 0)
            | (if (o.MINOR_SYSTEMRESTORE == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_SYSTEMRESTORE) else 0)
            | (if (o.MINOR_TERMSRV == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_TERMSRV) else 0)
            | (if (o.MINOR_DC_PROMOTION == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_DC_PROMOTION) else 0)
            | (if (o.MINOR_DC_DEMOTION == 1) @intFromEnum(SHUTDOWN_REASON.MINOR_DC_DEMOTION) else 0)
            | (if (o.LEGACY_API == 1) @intFromEnum(SHUTDOWN_REASON.LEGACY_API) else 0)
            | (if (o.VALID_BIT_MASK == 1) @intFromEnum(SHUTDOWN_REASON.VALID_BIT_MASK) else 0)
        ));
    }
};
pub const SHTDN_REASON_NONE = SHUTDOWN_REASON.NONE;
pub const SHTDN_REASON_FLAG_COMMENT_REQUIRED = SHUTDOWN_REASON.FLAG_COMMENT_REQUIRED;
pub const SHTDN_REASON_FLAG_DIRTY_PROBLEM_ID_REQUIRED = SHUTDOWN_REASON.FLAG_DIRTY_PROBLEM_ID_REQUIRED;
pub const SHTDN_REASON_FLAG_CLEAN_UI = SHUTDOWN_REASON.FLAG_CLEAN_UI;
pub const SHTDN_REASON_FLAG_DIRTY_UI = SHUTDOWN_REASON.FLAG_DIRTY_UI;
pub const SHTDN_REASON_FLAG_MOBILE_UI_RESERVED = SHUTDOWN_REASON.FLAG_MOBILE_UI_RESERVED;
pub const SHTDN_REASON_FLAG_USER_DEFINED = SHUTDOWN_REASON.FLAG_USER_DEFINED;
pub const SHTDN_REASON_FLAG_PLANNED = SHUTDOWN_REASON.FLAG_PLANNED;
pub const SHTDN_REASON_MAJOR_OTHER = SHUTDOWN_REASON.NONE;
pub const SHTDN_REASON_MAJOR_NONE = SHUTDOWN_REASON.NONE;
pub const SHTDN_REASON_MAJOR_HARDWARE = SHUTDOWN_REASON.MAJOR_HARDWARE;
pub const SHTDN_REASON_MAJOR_OPERATINGSYSTEM = SHUTDOWN_REASON.MAJOR_OPERATINGSYSTEM;
pub const SHTDN_REASON_MAJOR_SOFTWARE = SHUTDOWN_REASON.MAJOR_SOFTWARE;
pub const SHTDN_REASON_MAJOR_APPLICATION = SHUTDOWN_REASON.MAJOR_APPLICATION;
pub const SHTDN_REASON_MAJOR_SYSTEM = SHUTDOWN_REASON.MAJOR_SYSTEM;
pub const SHTDN_REASON_MAJOR_POWER = SHUTDOWN_REASON.MAJOR_POWER;
pub const SHTDN_REASON_MAJOR_LEGACY_API = SHUTDOWN_REASON.MAJOR_LEGACY_API;
pub const SHTDN_REASON_MINOR_OTHER = SHUTDOWN_REASON.NONE;
pub const SHTDN_REASON_MINOR_NONE = SHUTDOWN_REASON.MINOR_NONE;
pub const SHTDN_REASON_MINOR_MAINTENANCE = SHUTDOWN_REASON.MINOR_MAINTENANCE;
pub const SHTDN_REASON_MINOR_INSTALLATION = SHUTDOWN_REASON.MINOR_INSTALLATION;
pub const SHTDN_REASON_MINOR_UPGRADE = SHUTDOWN_REASON.MINOR_UPGRADE;
pub const SHTDN_REASON_MINOR_RECONFIG = SHUTDOWN_REASON.MINOR_RECONFIG;
pub const SHTDN_REASON_MINOR_HUNG = SHUTDOWN_REASON.MINOR_HUNG;
pub const SHTDN_REASON_MINOR_UNSTABLE = SHUTDOWN_REASON.MINOR_UNSTABLE;
pub const SHTDN_REASON_MINOR_DISK = SHUTDOWN_REASON.MINOR_DISK;
pub const SHTDN_REASON_MINOR_PROCESSOR = SHUTDOWN_REASON.MINOR_PROCESSOR;
pub const SHTDN_REASON_MINOR_NETWORKCARD = SHUTDOWN_REASON.MINOR_NETWORKCARD;
pub const SHTDN_REASON_MINOR_POWER_SUPPLY = SHUTDOWN_REASON.MINOR_POWER_SUPPLY;
pub const SHTDN_REASON_MINOR_CORDUNPLUGGED = SHUTDOWN_REASON.MINOR_CORDUNPLUGGED;
pub const SHTDN_REASON_MINOR_ENVIRONMENT = SHUTDOWN_REASON.MINOR_ENVIRONMENT;
pub const SHTDN_REASON_MINOR_HARDWARE_DRIVER = SHUTDOWN_REASON.MINOR_HARDWARE_DRIVER;
pub const SHTDN_REASON_MINOR_OTHERDRIVER = SHUTDOWN_REASON.MINOR_OTHERDRIVER;
pub const SHTDN_REASON_MINOR_BLUESCREEN = SHUTDOWN_REASON.MINOR_BLUESCREEN;
pub const SHTDN_REASON_MINOR_SERVICEPACK = SHUTDOWN_REASON.MINOR_SERVICEPACK;
pub const SHTDN_REASON_MINOR_HOTFIX = SHUTDOWN_REASON.MINOR_HOTFIX;
pub const SHTDN_REASON_MINOR_SECURITYFIX = SHUTDOWN_REASON.MINOR_SECURITYFIX;
pub const SHTDN_REASON_MINOR_SECURITY = SHUTDOWN_REASON.MINOR_SECURITY;
pub const SHTDN_REASON_MINOR_NETWORK_CONNECTIVITY = SHUTDOWN_REASON.MINOR_NETWORK_CONNECTIVITY;
pub const SHTDN_REASON_MINOR_WMI = SHUTDOWN_REASON.MINOR_WMI;
pub const SHTDN_REASON_MINOR_SERVICEPACK_UNINSTALL = SHUTDOWN_REASON.MINOR_SERVICEPACK_UNINSTALL;
pub const SHTDN_REASON_MINOR_HOTFIX_UNINSTALL = SHUTDOWN_REASON.MINOR_HOTFIX_UNINSTALL;
pub const SHTDN_REASON_MINOR_SECURITYFIX_UNINSTALL = SHUTDOWN_REASON.MINOR_SECURITYFIX_UNINSTALL;
pub const SHTDN_REASON_MINOR_MMC = SHUTDOWN_REASON.MINOR_MMC;
pub const SHTDN_REASON_MINOR_SYSTEMRESTORE = SHUTDOWN_REASON.MINOR_SYSTEMRESTORE;
pub const SHTDN_REASON_MINOR_TERMSRV = SHUTDOWN_REASON.MINOR_TERMSRV;
pub const SHTDN_REASON_MINOR_DC_PROMOTION = SHUTDOWN_REASON.MINOR_DC_PROMOTION;
pub const SHTDN_REASON_MINOR_DC_DEMOTION = SHUTDOWN_REASON.MINOR_DC_DEMOTION;
pub const SHTDN_REASON_UNKNOWN = SHUTDOWN_REASON.MINOR_NONE;
pub const SHTDN_REASON_LEGACY_API = SHUTDOWN_REASON.LEGACY_API;
pub const SHTDN_REASON_VALID_BIT_MASK = SHUTDOWN_REASON.VALID_BIT_MASK;

pub const SHUTDOWN_FLAGS = enum(u32) {
    FORCE_OTHERS = 1,
    FORCE_SELF = 2,
    RESTART = 4,
    POWEROFF = 8,
    NOREBOOT = 16,
    GRACE_OVERRIDE = 32,
    INSTALL_UPDATES = 64,
    RESTARTAPPS = 128,
    SKIP_SVC_PRESHUTDOWN = 256,
    HYBRID = 512,
    RESTART_BOOTOPTIONS = 1024,
    SOFT_REBOOT = 2048,
    MOBILE_UI = 4096,
    ARSO = 8192,
    CHECK_SAFE_FOR_SERVER = 16384,
    VAIL_CONTAINER = 32768,
    SYSTEM_INITIATED = 65536,
    _,
    pub fn initFlags(o: struct {
        FORCE_OTHERS: u1 = 0,
        FORCE_SELF: u1 = 0,
        RESTART: u1 = 0,
        POWEROFF: u1 = 0,
        NOREBOOT: u1 = 0,
        GRACE_OVERRIDE: u1 = 0,
        INSTALL_UPDATES: u1 = 0,
        RESTARTAPPS: u1 = 0,
        SKIP_SVC_PRESHUTDOWN: u1 = 0,
        HYBRID: u1 = 0,
        RESTART_BOOTOPTIONS: u1 = 0,
        SOFT_REBOOT: u1 = 0,
        MOBILE_UI: u1 = 0,
        ARSO: u1 = 0,
        CHECK_SAFE_FOR_SERVER: u1 = 0,
        VAIL_CONTAINER: u1 = 0,
        SYSTEM_INITIATED: u1 = 0,
    }) SHUTDOWN_FLAGS {
        return @as(SHUTDOWN_FLAGS, @enumFromInt(
              (if (o.FORCE_OTHERS == 1) @intFromEnum(SHUTDOWN_FLAGS.FORCE_OTHERS) else 0)
            | (if (o.FORCE_SELF == 1) @intFromEnum(SHUTDOWN_FLAGS.FORCE_SELF) else 0)
            | (if (o.RESTART == 1) @intFromEnum(SHUTDOWN_FLAGS.RESTART) else 0)
            | (if (o.POWEROFF == 1) @intFromEnum(SHUTDOWN_FLAGS.POWEROFF) else 0)
            | (if (o.NOREBOOT == 1) @intFromEnum(SHUTDOWN_FLAGS.NOREBOOT) else 0)
            | (if (o.GRACE_OVERRIDE == 1) @intFromEnum(SHUTDOWN_FLAGS.GRACE_OVERRIDE) else 0)
            | (if (o.INSTALL_UPDATES == 1) @intFromEnum(SHUTDOWN_FLAGS.INSTALL_UPDATES) else 0)
            | (if (o.RESTARTAPPS == 1) @intFromEnum(SHUTDOWN_FLAGS.RESTARTAPPS) else 0)
            | (if (o.SKIP_SVC_PRESHUTDOWN == 1) @intFromEnum(SHUTDOWN_FLAGS.SKIP_SVC_PRESHUTDOWN) else 0)
            | (if (o.HYBRID == 1) @intFromEnum(SHUTDOWN_FLAGS.HYBRID) else 0)
            | (if (o.RESTART_BOOTOPTIONS == 1) @intFromEnum(SHUTDOWN_FLAGS.RESTART_BOOTOPTIONS) else 0)
            | (if (o.SOFT_REBOOT == 1) @intFromEnum(SHUTDOWN_FLAGS.SOFT_REBOOT) else 0)
            | (if (o.MOBILE_UI == 1) @intFromEnum(SHUTDOWN_FLAGS.MOBILE_UI) else 0)
            | (if (o.ARSO == 1) @intFromEnum(SHUTDOWN_FLAGS.ARSO) else 0)
            | (if (o.CHECK_SAFE_FOR_SERVER == 1) @intFromEnum(SHUTDOWN_FLAGS.CHECK_SAFE_FOR_SERVER) else 0)
            | (if (o.VAIL_CONTAINER == 1) @intFromEnum(SHUTDOWN_FLAGS.VAIL_CONTAINER) else 0)
            | (if (o.SYSTEM_INITIATED == 1) @intFromEnum(SHUTDOWN_FLAGS.SYSTEM_INITIATED) else 0)
        ));
    }
};
pub const SHUTDOWN_FORCE_OTHERS = SHUTDOWN_FLAGS.FORCE_OTHERS;
pub const SHUTDOWN_FORCE_SELF = SHUTDOWN_FLAGS.FORCE_SELF;
pub const SHUTDOWN_RESTART = SHUTDOWN_FLAGS.RESTART;
pub const SHUTDOWN_POWEROFF = SHUTDOWN_FLAGS.POWEROFF;
pub const SHUTDOWN_NOREBOOT = SHUTDOWN_FLAGS.NOREBOOT;
pub const SHUTDOWN_GRACE_OVERRIDE = SHUTDOWN_FLAGS.GRACE_OVERRIDE;
pub const SHUTDOWN_INSTALL_UPDATES = SHUTDOWN_FLAGS.INSTALL_UPDATES;
pub const SHUTDOWN_RESTARTAPPS = SHUTDOWN_FLAGS.RESTARTAPPS;
pub const SHUTDOWN_SKIP_SVC_PRESHUTDOWN = SHUTDOWN_FLAGS.SKIP_SVC_PRESHUTDOWN;
pub const SHUTDOWN_HYBRID = SHUTDOWN_FLAGS.HYBRID;
pub const SHUTDOWN_RESTART_BOOTOPTIONS = SHUTDOWN_FLAGS.RESTART_BOOTOPTIONS;
pub const SHUTDOWN_SOFT_REBOOT = SHUTDOWN_FLAGS.SOFT_REBOOT;
pub const SHUTDOWN_MOBILE_UI = SHUTDOWN_FLAGS.MOBILE_UI;
pub const SHUTDOWN_ARSO = SHUTDOWN_FLAGS.ARSO;
pub const SHUTDOWN_CHECK_SAFE_FOR_SERVER = SHUTDOWN_FLAGS.CHECK_SAFE_FOR_SERVER;
pub const SHUTDOWN_VAIL_CONTAINER = SHUTDOWN_FLAGS.VAIL_CONTAINER;
pub const SHUTDOWN_SYSTEM_INITIATED = SHUTDOWN_FLAGS.SYSTEM_INITIATED;

pub const EXIT_WINDOWS_FLAGS = enum(u32) {
    HYBRID_SHUTDOWN = 4194304,
    LOGOFF = 0,
    POWEROFF = 8,
    REBOOT = 2,
    RESTARTAPPS = 64,
    SHUTDOWN = 1,
};
pub const EWX_HYBRID_SHUTDOWN = EXIT_WINDOWS_FLAGS.HYBRID_SHUTDOWN;
pub const EWX_LOGOFF = EXIT_WINDOWS_FLAGS.LOGOFF;
pub const EWX_POWEROFF = EXIT_WINDOWS_FLAGS.POWEROFF;
pub const EWX_REBOOT = EXIT_WINDOWS_FLAGS.REBOOT;
pub const EWX_RESTARTAPPS = EXIT_WINDOWS_FLAGS.RESTARTAPPS;
pub const EWX_SHUTDOWN = EXIT_WINDOWS_FLAGS.SHUTDOWN;


//--------------------------------------------------------------------------------
// Section: Functions (14)
//--------------------------------------------------------------------------------
// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "advapi32" fn InitiateSystemShutdownA(
    lpMachineName: ?PSTR,
    lpMessage: ?PSTR,
    dwTimeout: u32,
    bForceAppsClosed: BOOL,
    bRebootAfterShutdown: BOOL,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "advapi32" fn InitiateSystemShutdownW(
    lpMachineName: ?PWSTR,
    lpMessage: ?PWSTR,
    dwTimeout: u32,
    bForceAppsClosed: BOOL,
    bRebootAfterShutdown: BOOL,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "advapi32" fn AbortSystemShutdownA(
    lpMachineName: ?PSTR,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "advapi32" fn AbortSystemShutdownW(
    lpMachineName: ?PWSTR,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "advapi32" fn InitiateSystemShutdownExA(
    lpMachineName: ?PSTR,
    lpMessage: ?PSTR,
    dwTimeout: u32,
    bForceAppsClosed: BOOL,
    bRebootAfterShutdown: BOOL,
    dwReason: SHUTDOWN_REASON,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "advapi32" fn InitiateSystemShutdownExW(
    lpMachineName: ?PWSTR,
    lpMessage: ?PWSTR,
    dwTimeout: u32,
    bForceAppsClosed: BOOL,
    bRebootAfterShutdown: BOOL,
    dwReason: SHUTDOWN_REASON,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "advapi32" fn InitiateShutdownA(
    lpMachineName: ?PSTR,
    lpMessage: ?PSTR,
    dwGracePeriod: u32,
    dwShutdownFlags: SHUTDOWN_FLAGS,
    dwReason: SHUTDOWN_REASON,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "advapi32" fn InitiateShutdownW(
    lpMachineName: ?PWSTR,
    lpMessage: ?PWSTR,
    dwGracePeriod: u32,
    dwShutdownFlags: SHUTDOWN_FLAGS,
    dwReason: SHUTDOWN_REASON,
) callconv(@import("std").os.windows.WINAPI) u32;

pub extern "advapi32" fn CheckForHiberboot(
    pHiberboot: ?*BOOLEAN,
    bClearFlag: BOOLEAN,
) callconv(@import("std").os.windows.WINAPI) u32;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "user32" fn ExitWindowsEx(
    uFlags: EXIT_WINDOWS_FLAGS,
    dwReason: u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows5.1.2600'
pub extern "user32" fn LockWorkStation(
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "user32" fn ShutdownBlockReasonCreate(
    hWnd: ?HWND,
    pwszReason: ?[*:0]const u16,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "user32" fn ShutdownBlockReasonQuery(
    hWnd: ?HWND,
    pwszBuff: ?[*:0]u16,
    pcchBuff: ?*u32,
) callconv(@import("std").os.windows.WINAPI) BOOL;

// TODO: this type is limited to platform 'windows6.0.6000'
pub extern "user32" fn ShutdownBlockReasonDestroy(
    hWnd: ?HWND,
) callconv(@import("std").os.windows.WINAPI) BOOL;


//--------------------------------------------------------------------------------
// Section: Unicode Aliases (4)
//--------------------------------------------------------------------------------
const thismodule = @This();
pub usingnamespace switch (@import("../zig.zig").unicode_mode) {
    .ansi => struct {
        pub const InitiateSystemShutdown = thismodule.InitiateSystemShutdownA;
        pub const AbortSystemShutdown = thismodule.AbortSystemShutdownA;
        pub const InitiateSystemShutdownEx = thismodule.InitiateSystemShutdownExA;
        pub const InitiateShutdown = thismodule.InitiateShutdownA;
    },
    .wide => struct {
        pub const InitiateSystemShutdown = thismodule.InitiateSystemShutdownW;
        pub const AbortSystemShutdown = thismodule.AbortSystemShutdownW;
        pub const InitiateSystemShutdownEx = thismodule.InitiateSystemShutdownExW;
        pub const InitiateShutdown = thismodule.InitiateShutdownW;
    },
    .unspecified => if (@import("builtin").is_test) struct {
        pub const InitiateSystemShutdown = *opaque{};
        pub const AbortSystemShutdown = *opaque{};
        pub const InitiateSystemShutdownEx = *opaque{};
        pub const InitiateShutdown = *opaque{};
    } else struct {
        pub const InitiateSystemShutdown = @compileError("'InitiateSystemShutdown' requires that UNICODE be set to true or false in the root module");
        pub const AbortSystemShutdown = @compileError("'AbortSystemShutdown' requires that UNICODE be set to true or false in the root module");
        pub const InitiateSystemShutdownEx = @compileError("'InitiateSystemShutdownEx' requires that UNICODE be set to true or false in the root module");
        pub const InitiateShutdown = @compileError("'InitiateShutdown' requires that UNICODE be set to true or false in the root module");
    },
};
//--------------------------------------------------------------------------------
// Section: Imports (5)
//--------------------------------------------------------------------------------
const BOOL = @import("../foundation.zig").BOOL;
const BOOLEAN = @import("../foundation.zig").BOOLEAN;
const HWND = @import("../foundation.zig").HWND;
const PSTR = @import("../foundation.zig").PSTR;
const PWSTR = @import("../foundation.zig").PWSTR;

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
