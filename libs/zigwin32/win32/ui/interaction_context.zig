//! NOTE: this file is autogenerated, DO NOT MODIFY
//--------------------------------------------------------------------------------
// Section: Constants (0)
//--------------------------------------------------------------------------------

//--------------------------------------------------------------------------------
// Section: Types (25)
//--------------------------------------------------------------------------------
pub const HINTERACTIONCONTEXT = *opaque{};

pub const INTERACTION_ID = enum(i32) {
    NONE = 0,
    MANIPULATION = 1,
    TAP = 2,
    SECONDARY_TAP = 3,
    HOLD = 4,
    DRAG = 5,
    CROSS_SLIDE = 6,
    MAX = -1,
};
pub const INTERACTION_ID_NONE = INTERACTION_ID.NONE;
pub const INTERACTION_ID_MANIPULATION = INTERACTION_ID.MANIPULATION;
pub const INTERACTION_ID_TAP = INTERACTION_ID.TAP;
pub const INTERACTION_ID_SECONDARY_TAP = INTERACTION_ID.SECONDARY_TAP;
pub const INTERACTION_ID_HOLD = INTERACTION_ID.HOLD;
pub const INTERACTION_ID_DRAG = INTERACTION_ID.DRAG;
pub const INTERACTION_ID_CROSS_SLIDE = INTERACTION_ID.CROSS_SLIDE;
pub const INTERACTION_ID_MAX = INTERACTION_ID.MAX;

pub const INTERACTION_FLAGS = enum(u32) {
    NONE = 0,
    BEGIN = 1,
    END = 2,
    CANCEL = 4,
    INERTIA = 8,
    MAX = 4294967295,
    _,
    pub fn initFlags(o: struct {
        NONE: u1 = 0,
        BEGIN: u1 = 0,
        END: u1 = 0,
        CANCEL: u1 = 0,
        INERTIA: u1 = 0,
        MAX: u1 = 0,
    }) INTERACTION_FLAGS {
        return @as(INTERACTION_FLAGS, @enumFromInt(
              (if (o.NONE == 1) @intFromEnum(INTERACTION_FLAGS.NONE) else 0)
            | (if (o.BEGIN == 1) @intFromEnum(INTERACTION_FLAGS.BEGIN) else 0)
            | (if (o.END == 1) @intFromEnum(INTERACTION_FLAGS.END) else 0)
            | (if (o.CANCEL == 1) @intFromEnum(INTERACTION_FLAGS.CANCEL) else 0)
            | (if (o.INERTIA == 1) @intFromEnum(INTERACTION_FLAGS.INERTIA) else 0)
            | (if (o.MAX == 1) @intFromEnum(INTERACTION_FLAGS.MAX) else 0)
        ));
    }
};
pub const INTERACTION_FLAG_NONE = INTERACTION_FLAGS.NONE;
pub const INTERACTION_FLAG_BEGIN = INTERACTION_FLAGS.BEGIN;
pub const INTERACTION_FLAG_END = INTERACTION_FLAGS.END;
pub const INTERACTION_FLAG_CANCEL = INTERACTION_FLAGS.CANCEL;
pub const INTERACTION_FLAG_INERTIA = INTERACTION_FLAGS.INERTIA;
pub const INTERACTION_FLAG_MAX = INTERACTION_FLAGS.MAX;

pub const INTERACTION_CONFIGURATION_FLAGS = enum(u32) {
    NONE = 0,
    MANIPULATION = 1,
    MANIPULATION_TRANSLATION_X = 2,
    MANIPULATION_TRANSLATION_Y = 4,
    MANIPULATION_ROTATION = 8,
    MANIPULATION_SCALING = 16,
    MANIPULATION_TRANSLATION_INERTIA = 32,
    MANIPULATION_ROTATION_INERTIA = 64,
    MANIPULATION_SCALING_INERTIA = 128,
    MANIPULATION_RAILS_X = 256,
    MANIPULATION_RAILS_Y = 512,
    MANIPULATION_EXACT = 1024,
    MANIPULATION_MULTIPLE_FINGER_PANNING = 2048,
    // CROSS_SLIDE = 1, this enum value conflicts with MANIPULATION
    // CROSS_SLIDE_HORIZONTAL = 2, this enum value conflicts with MANIPULATION_TRANSLATION_X
    // CROSS_SLIDE_SELECT = 4, this enum value conflicts with MANIPULATION_TRANSLATION_Y
    // CROSS_SLIDE_SPEED_BUMP = 8, this enum value conflicts with MANIPULATION_ROTATION
    // CROSS_SLIDE_REARRANGE = 16, this enum value conflicts with MANIPULATION_SCALING
    // CROSS_SLIDE_EXACT = 32, this enum value conflicts with MANIPULATION_TRANSLATION_INERTIA
    // TAP = 1, this enum value conflicts with MANIPULATION
    // TAP_DOUBLE = 2, this enum value conflicts with MANIPULATION_TRANSLATION_X
    // TAP_MULTIPLE_FINGER = 4, this enum value conflicts with MANIPULATION_TRANSLATION_Y
    // SECONDARY_TAP = 1, this enum value conflicts with MANIPULATION
    // HOLD = 1, this enum value conflicts with MANIPULATION
    // HOLD_MOUSE = 2, this enum value conflicts with MANIPULATION_TRANSLATION_X
    // HOLD_MULTIPLE_FINGER = 4, this enum value conflicts with MANIPULATION_TRANSLATION_Y
    // DRAG = 1, this enum value conflicts with MANIPULATION
    MAX = 4294967295,
    _,
    pub fn initFlags(o: struct {
        NONE: u1 = 0,
        MANIPULATION: u1 = 0,
        MANIPULATION_TRANSLATION_X: u1 = 0,
        MANIPULATION_TRANSLATION_Y: u1 = 0,
        MANIPULATION_ROTATION: u1 = 0,
        MANIPULATION_SCALING: u1 = 0,
        MANIPULATION_TRANSLATION_INERTIA: u1 = 0,
        MANIPULATION_ROTATION_INERTIA: u1 = 0,
        MANIPULATION_SCALING_INERTIA: u1 = 0,
        MANIPULATION_RAILS_X: u1 = 0,
        MANIPULATION_RAILS_Y: u1 = 0,
        MANIPULATION_EXACT: u1 = 0,
        MANIPULATION_MULTIPLE_FINGER_PANNING: u1 = 0,
        MAX: u1 = 0,
    }) INTERACTION_CONFIGURATION_FLAGS {
        return @as(INTERACTION_CONFIGURATION_FLAGS, @enumFromInt(
              (if (o.NONE == 1) @intFromEnum(INTERACTION_CONFIGURATION_FLAGS.NONE) else 0)
            | (if (o.MANIPULATION == 1) @intFromEnum(INTERACTION_CONFIGURATION_FLAGS.MANIPULATION) else 0)
            | (if (o.MANIPULATION_TRANSLATION_X == 1) @intFromEnum(INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_TRANSLATION_X) else 0)
            | (if (o.MANIPULATION_TRANSLATION_Y == 1) @intFromEnum(INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_TRANSLATION_Y) else 0)
            | (if (o.MANIPULATION_ROTATION == 1) @intFromEnum(INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_ROTATION) else 0)
            | (if (o.MANIPULATION_SCALING == 1) @intFromEnum(INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_SCALING) else 0)
            | (if (o.MANIPULATION_TRANSLATION_INERTIA == 1) @intFromEnum(INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_TRANSLATION_INERTIA) else 0)
            | (if (o.MANIPULATION_ROTATION_INERTIA == 1) @intFromEnum(INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_ROTATION_INERTIA) else 0)
            | (if (o.MANIPULATION_SCALING_INERTIA == 1) @intFromEnum(INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_SCALING_INERTIA) else 0)
            | (if (o.MANIPULATION_RAILS_X == 1) @intFromEnum(INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_RAILS_X) else 0)
            | (if (o.MANIPULATION_RAILS_Y == 1) @intFromEnum(INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_RAILS_Y) else 0)
            | (if (o.MANIPULATION_EXACT == 1) @intFromEnum(INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_EXACT) else 0)
            | (if (o.MANIPULATION_MULTIPLE_FINGER_PANNING == 1) @intFromEnum(INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_MULTIPLE_FINGER_PANNING) else 0)
            | (if (o.MAX == 1) @intFromEnum(INTERACTION_CONFIGURATION_FLAGS.MAX) else 0)
        ));
    }
};
pub const INTERACTION_CONFIGURATION_FLAG_NONE = INTERACTION_CONFIGURATION_FLAGS.NONE;
pub const INTERACTION_CONFIGURATION_FLAG_MANIPULATION = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION;
pub const INTERACTION_CONFIGURATION_FLAG_MANIPULATION_TRANSLATION_X = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_TRANSLATION_X;
pub const INTERACTION_CONFIGURATION_FLAG_MANIPULATION_TRANSLATION_Y = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_TRANSLATION_Y;
pub const INTERACTION_CONFIGURATION_FLAG_MANIPULATION_ROTATION = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_ROTATION;
pub const INTERACTION_CONFIGURATION_FLAG_MANIPULATION_SCALING = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_SCALING;
pub const INTERACTION_CONFIGURATION_FLAG_MANIPULATION_TRANSLATION_INERTIA = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_TRANSLATION_INERTIA;
pub const INTERACTION_CONFIGURATION_FLAG_MANIPULATION_ROTATION_INERTIA = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_ROTATION_INERTIA;
pub const INTERACTION_CONFIGURATION_FLAG_MANIPULATION_SCALING_INERTIA = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_SCALING_INERTIA;
pub const INTERACTION_CONFIGURATION_FLAG_MANIPULATION_RAILS_X = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_RAILS_X;
pub const INTERACTION_CONFIGURATION_FLAG_MANIPULATION_RAILS_Y = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_RAILS_Y;
pub const INTERACTION_CONFIGURATION_FLAG_MANIPULATION_EXACT = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_EXACT;
pub const INTERACTION_CONFIGURATION_FLAG_MANIPULATION_MULTIPLE_FINGER_PANNING = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_MULTIPLE_FINGER_PANNING;
pub const INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION;
pub const INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE_HORIZONTAL = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_TRANSLATION_X;
pub const INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE_SELECT = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_TRANSLATION_Y;
pub const INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE_SPEED_BUMP = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_ROTATION;
pub const INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE_REARRANGE = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_SCALING;
pub const INTERACTION_CONFIGURATION_FLAG_CROSS_SLIDE_EXACT = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_TRANSLATION_INERTIA;
pub const INTERACTION_CONFIGURATION_FLAG_TAP = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION;
pub const INTERACTION_CONFIGURATION_FLAG_TAP_DOUBLE = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_TRANSLATION_X;
pub const INTERACTION_CONFIGURATION_FLAG_TAP_MULTIPLE_FINGER = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_TRANSLATION_Y;
pub const INTERACTION_CONFIGURATION_FLAG_SECONDARY_TAP = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION;
pub const INTERACTION_CONFIGURATION_FLAG_HOLD = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION;
pub const INTERACTION_CONFIGURATION_FLAG_HOLD_MOUSE = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_TRANSLATION_X;
pub const INTERACTION_CONFIGURATION_FLAG_HOLD_MULTIPLE_FINGER = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION_TRANSLATION_Y;
pub const INTERACTION_CONFIGURATION_FLAG_DRAG = INTERACTION_CONFIGURATION_FLAGS.MANIPULATION;
pub const INTERACTION_CONFIGURATION_FLAG_MAX = INTERACTION_CONFIGURATION_FLAGS.MAX;

pub const INERTIA_PARAMETER = enum(i32) {
    TRANSLATION_DECELERATION = 1,
    TRANSLATION_DISPLACEMENT = 2,
    ROTATION_DECELERATION = 3,
    ROTATION_ANGLE = 4,
    EXPANSION_DECELERATION = 5,
    EXPANSION_EXPANSION = 6,
    MAX = -1,
};
pub const INERTIA_PARAMETER_TRANSLATION_DECELERATION = INERTIA_PARAMETER.TRANSLATION_DECELERATION;
pub const INERTIA_PARAMETER_TRANSLATION_DISPLACEMENT = INERTIA_PARAMETER.TRANSLATION_DISPLACEMENT;
pub const INERTIA_PARAMETER_ROTATION_DECELERATION = INERTIA_PARAMETER.ROTATION_DECELERATION;
pub const INERTIA_PARAMETER_ROTATION_ANGLE = INERTIA_PARAMETER.ROTATION_ANGLE;
pub const INERTIA_PARAMETER_EXPANSION_DECELERATION = INERTIA_PARAMETER.EXPANSION_DECELERATION;
pub const INERTIA_PARAMETER_EXPANSION_EXPANSION = INERTIA_PARAMETER.EXPANSION_EXPANSION;
pub const INERTIA_PARAMETER_MAX = INERTIA_PARAMETER.MAX;

pub const INTERACTION_STATE = enum(i32) {
    IDLE = 0,
    IN_INTERACTION = 1,
    POSSIBLE_DOUBLE_TAP = 2,
    MAX = -1,
};
pub const INTERACTION_STATE_IDLE = INTERACTION_STATE.IDLE;
pub const INTERACTION_STATE_IN_INTERACTION = INTERACTION_STATE.IN_INTERACTION;
pub const INTERACTION_STATE_POSSIBLE_DOUBLE_TAP = INTERACTION_STATE.POSSIBLE_DOUBLE_TAP;
pub const INTERACTION_STATE_MAX = INTERACTION_STATE.MAX;

pub const INTERACTION_CONTEXT_PROPERTY = enum(i32) {
    MEASUREMENT_UNITS = 1,
    INTERACTION_UI_FEEDBACK = 2,
    FILTER_POINTERS = 3,
    MAX = -1,
};
pub const INTERACTION_CONTEXT_PROPERTY_MEASUREMENT_UNITS = INTERACTION_CONTEXT_PROPERTY.MEASUREMENT_UNITS;
pub const INTERACTION_CONTEXT_PROPERTY_INTERACTION_UI_FEEDBACK = INTERACTION_CONTEXT_PROPERTY.INTERACTION_UI_FEEDBACK;
pub const INTERACTION_CONTEXT_PROPERTY_FILTER_POINTERS = INTERACTION_CONTEXT_PROPERTY.FILTER_POINTERS;
pub const INTERACTION_CONTEXT_PROPERTY_MAX = INTERACTION_CONTEXT_PROPERTY.MAX;

pub const CROSS_SLIDE_THRESHOLD = enum(i32) {
    SELECT_START = 0,
    SPEED_BUMP_START = 1,
    SPEED_BUMP_END = 2,
    REARRANGE_START = 3,
    COUNT = 4,
    MAX = -1,
};
pub const CROSS_SLIDE_THRESHOLD_SELECT_START = CROSS_SLIDE_THRESHOLD.SELECT_START;
pub const CROSS_SLIDE_THRESHOLD_SPEED_BUMP_START = CROSS_SLIDE_THRESHOLD.SPEED_BUMP_START;
pub const CROSS_SLIDE_THRESHOLD_SPEED_BUMP_END = CROSS_SLIDE_THRESHOLD.SPEED_BUMP_END;
pub const CROSS_SLIDE_THRESHOLD_REARRANGE_START = CROSS_SLIDE_THRESHOLD.REARRANGE_START;
pub const CROSS_SLIDE_THRESHOLD_COUNT = CROSS_SLIDE_THRESHOLD.COUNT;
pub const CROSS_SLIDE_THRESHOLD_MAX = CROSS_SLIDE_THRESHOLD.MAX;

pub const CROSS_SLIDE_FLAGS = enum(u32) {
    NONE = 0,
    SELECT = 1,
    SPEED_BUMP = 2,
    REARRANGE = 4,
    MAX = 4294967295,
    _,
    pub fn initFlags(o: struct {
        NONE: u1 = 0,
        SELECT: u1 = 0,
        SPEED_BUMP: u1 = 0,
        REARRANGE: u1 = 0,
        MAX: u1 = 0,
    }) CROSS_SLIDE_FLAGS {
        return @as(CROSS_SLIDE_FLAGS, @enumFromInt(
              (if (o.NONE == 1) @intFromEnum(CROSS_SLIDE_FLAGS.NONE) else 0)
            | (if (o.SELECT == 1) @intFromEnum(CROSS_SLIDE_FLAGS.SELECT) else 0)
            | (if (o.SPEED_BUMP == 1) @intFromEnum(CROSS_SLIDE_FLAGS.SPEED_BUMP) else 0)
            | (if (o.REARRANGE == 1) @intFromEnum(CROSS_SLIDE_FLAGS.REARRANGE) else 0)
            | (if (o.MAX == 1) @intFromEnum(CROSS_SLIDE_FLAGS.MAX) else 0)
        ));
    }
};
pub const CROSS_SLIDE_FLAGS_NONE = CROSS_SLIDE_FLAGS.NONE;
pub const CROSS_SLIDE_FLAGS_SELECT = CROSS_SLIDE_FLAGS.SELECT;
pub const CROSS_SLIDE_FLAGS_SPEED_BUMP = CROSS_SLIDE_FLAGS.SPEED_BUMP;
pub const CROSS_SLIDE_FLAGS_REARRANGE = CROSS_SLIDE_FLAGS.REARRANGE;
pub const CROSS_SLIDE_FLAGS_MAX = CROSS_SLIDE_FLAGS.MAX;

pub const MOUSE_WHEEL_PARAMETER = enum(i32) {
    CHAR_TRANSLATION_X = 1,
    CHAR_TRANSLATION_Y = 2,
    DELTA_SCALE = 3,
    DELTA_ROTATION = 4,
    PAGE_TRANSLATION_X = 5,
    PAGE_TRANSLATION_Y = 6,
    MAX = -1,
};
pub const MOUSE_WHEEL_PARAMETER_CHAR_TRANSLATION_X = MOUSE_WHEEL_PARAMETER.CHAR_TRANSLATION_X;
pub const MOUSE_WHEEL_PARAMETER_CHAR_TRANSLATION_Y = MOUSE_WHEEL_PARAMETER.CHAR_TRANSLATION_Y;
pub const MOUSE_WHEEL_PARAMETER_DELTA_SCALE = MOUSE_WHEEL_PARAMETER.DELTA_SCALE;
pub const MOUSE_WHEEL_PARAMETER_DELTA_ROTATION = MOUSE_WHEEL_PARAMETER.DELTA_ROTATION;
pub const MOUSE_WHEEL_PARAMETER_PAGE_TRANSLATION_X = MOUSE_WHEEL_PARAMETER.PAGE_TRANSLATION_X;
pub const MOUSE_WHEEL_PARAMETER_PAGE_TRANSLATION_Y = MOUSE_WHEEL_PARAMETER.PAGE_TRANSLATION_Y;
pub const MOUSE_WHEEL_PARAMETER_MAX = MOUSE_WHEEL_PARAMETER.MAX;

pub const TAP_PARAMETER = enum(i32) {
    IN_CONTACT_COUNT = 0,
    AX_CONTACT_COUNT = 1,
    AX = -1,
};
pub const TAP_PARAMETER_MIN_CONTACT_COUNT = TAP_PARAMETER.IN_CONTACT_COUNT;
pub const TAP_PARAMETER_MAX_CONTACT_COUNT = TAP_PARAMETER.AX_CONTACT_COUNT;
pub const TAP_PARAMETER_MAX = TAP_PARAMETER.AX;

pub const HOLD_PARAMETER = enum(i32) {
    MIN_CONTACT_COUNT = 0,
    MAX_CONTACT_COUNT = 1,
    THRESHOLD_RADIUS = 2,
    THRESHOLD_START_DELAY = 3,
    MAX = -1,
};
pub const HOLD_PARAMETER_MIN_CONTACT_COUNT = HOLD_PARAMETER.MIN_CONTACT_COUNT;
pub const HOLD_PARAMETER_MAX_CONTACT_COUNT = HOLD_PARAMETER.MAX_CONTACT_COUNT;
pub const HOLD_PARAMETER_THRESHOLD_RADIUS = HOLD_PARAMETER.THRESHOLD_RADIUS;
pub const HOLD_PARAMETER_THRESHOLD_START_DELAY = HOLD_PARAMETER.THRESHOLD_START_DELAY;
pub const HOLD_PARAMETER_MAX = HOLD_PARAMETER.MAX;

pub const TRANSLATION_PARAMETER = enum(i32) {
    IN_CONTACT_COUNT = 0,
    AX_CONTACT_COUNT = 1,
    AX = -1,
};
pub const TRANSLATION_PARAMETER_MIN_CONTACT_COUNT = TRANSLATION_PARAMETER.IN_CONTACT_COUNT;
pub const TRANSLATION_PARAMETER_MAX_CONTACT_COUNT = TRANSLATION_PARAMETER.AX_CONTACT_COUNT;
pub const TRANSLATION_PARAMETER_MAX = TRANSLATION_PARAMETER.AX;

pub const MANIPULATION_RAILS_STATE = enum(i32) {
    UNDECIDED = 0,
    FREE = 1,
    RAILED = 2,
    MAX = -1,
};
pub const MANIPULATION_RAILS_STATE_UNDECIDED = MANIPULATION_RAILS_STATE.UNDECIDED;
pub const MANIPULATION_RAILS_STATE_FREE = MANIPULATION_RAILS_STATE.FREE;
pub const MANIPULATION_RAILS_STATE_RAILED = MANIPULATION_RAILS_STATE.RAILED;
pub const MANIPULATION_RAILS_STATE_MAX = MANIPULATION_RAILS_STATE.MAX;

pub const MANIPULATION_TRANSFORM = extern struct {
    translationX: f32,
    translationY: f32,
    scale: f32,
    expansion: f32,
    rotation: f32,
};

pub const MANIPULATION_VELOCITY = extern struct {
    velocityX: f32,
    velocityY: f32,
    velocityExpansion: f32,
    velocityAngular: f32,
};

pub const INTERACTION_ARGUMENTS_MANIPULATION = extern struct {
    delta: MANIPULATION_TRANSFORM,
    cumulative: MANIPULATION_TRANSFORM,
    velocity: MANIPULATION_VELOCITY,
    railsState: MANIPULATION_RAILS_STATE,
};

pub const INTERACTION_ARGUMENTS_TAP = extern struct {
    count: u32,
};

pub const INTERACTION_ARGUMENTS_CROSS_SLIDE = extern struct {
    flags: CROSS_SLIDE_FLAGS,
};

pub const INTERACTION_CONTEXT_OUTPUT = extern struct {
    interactionId: INTERACTION_ID,
    interactionFlags: INTERACTION_FLAGS,
    inputType: POINTER_INPUT_TYPE,
    x: f32,
    y: f32,
    arguments: extern union {
        manipulation: INTERACTION_ARGUMENTS_MANIPULATION,
        tap: INTERACTION_ARGUMENTS_TAP,
        crossSlide: INTERACTION_ARGUMENTS_CROSS_SLIDE,
    },
};

pub const INTERACTION_CONTEXT_OUTPUT2 = extern struct {
    interactionId: INTERACTION_ID,
    interactionFlags: INTERACTION_FLAGS,
    inputType: POINTER_INPUT_TYPE,
    contactCount: u32,
    currentContactCount: u32,
    x: f32,
    y: f32,
    arguments: extern union {
        manipulation: INTERACTION_ARGUMENTS_MANIPULATION,
        tap: INTERACTION_ARGUMENTS_TAP,
        crossSlide: INTERACTION_ARGUMENTS_CROSS_SLIDE,
    },
};

pub const INTERACTION_CONTEXT_CONFIGURATION = extern struct {
    interactionId: INTERACTION_ID,
    enable: INTERACTION_CONFIGURATION_FLAGS,
};

pub const CROSS_SLIDE_PARAMETER = extern struct {
    threshold: CROSS_SLIDE_THRESHOLD,
    distance: f32,
};

pub const INTERACTION_CONTEXT_OUTPUT_CALLBACK = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        clientData: ?*anyopaque,
        output: ?*const INTERACTION_CONTEXT_OUTPUT,
    ) callconv(@import("std").os.windows.WINAPI) void,
    else => *const fn(
        clientData: ?*anyopaque,
        output: ?*const INTERACTION_CONTEXT_OUTPUT,
    ) callconv(@import("std").os.windows.WINAPI) void,
} ;

pub const INTERACTION_CONTEXT_OUTPUT_CALLBACK2 = switch (@import("builtin").zig_backend) {
    .stage1 => fn(
        clientData: ?*anyopaque,
        output: ?*const INTERACTION_CONTEXT_OUTPUT2,
    ) callconv(@import("std").os.windows.WINAPI) void,
    else => *const fn(
        clientData: ?*anyopaque,
        output: ?*const INTERACTION_CONTEXT_OUTPUT2,
    ) callconv(@import("std").os.windows.WINAPI) void,
} ;


//--------------------------------------------------------------------------------
// Section: Functions (30)
//--------------------------------------------------------------------------------
// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn CreateInteractionContext(
    interactionContext: ?*?HINTERACTIONCONTEXT,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn DestroyInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn RegisterOutputCallbackInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    outputCallback: ?INTERACTION_CONTEXT_OUTPUT_CALLBACK,
    clientData: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "ninput" fn RegisterOutputCallbackInteractionContext2(
    interactionContext: ?HINTERACTIONCONTEXT,
    outputCallback: ?INTERACTION_CONTEXT_OUTPUT_CALLBACK2,
    clientData: ?*anyopaque,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn SetInteractionConfigurationInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    configurationCount: u32,
    configuration: [*]const INTERACTION_CONTEXT_CONFIGURATION,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn GetInteractionConfigurationInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    configurationCount: u32,
    configuration: [*]INTERACTION_CONTEXT_CONFIGURATION,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn SetPropertyInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    contextProperty: INTERACTION_CONTEXT_PROPERTY,
    value: u32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn GetPropertyInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    contextProperty: INTERACTION_CONTEXT_PROPERTY,
    value: ?*u32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn SetInertiaParameterInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    inertiaParameter: INERTIA_PARAMETER,
    value: f32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn GetInertiaParameterInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    inertiaParameter: INERTIA_PARAMETER,
    value: ?*f32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn SetCrossSlideParametersInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    parameterCount: u32,
    crossSlideParameters: [*]CROSS_SLIDE_PARAMETER,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn GetCrossSlideParameterInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    threshold: CROSS_SLIDE_THRESHOLD,
    distance: ?*f32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "ninput" fn SetTapParameterInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    parameter: TAP_PARAMETER,
    value: f32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "ninput" fn GetTapParameterInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    parameter: TAP_PARAMETER,
    value: ?*f32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "ninput" fn SetHoldParameterInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    parameter: HOLD_PARAMETER,
    value: f32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "ninput" fn GetHoldParameterInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    parameter: HOLD_PARAMETER,
    value: ?*f32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "ninput" fn SetTranslationParameterInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    parameter: TRANSLATION_PARAMETER,
    value: f32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

pub extern "ninput" fn GetTranslationParameterInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    parameter: TRANSLATION_PARAMETER,
    value: ?*f32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn SetMouseWheelParameterInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    parameter: MOUSE_WHEEL_PARAMETER,
    value: f32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn GetMouseWheelParameterInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    parameter: MOUSE_WHEEL_PARAMETER,
    value: ?*f32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn ResetInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn GetStateInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    pointerInfo: ?*const POINTER_INFO,
    state: ?*INTERACTION_STATE,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn AddPointerInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    pointerId: u32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn RemovePointerInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    pointerId: u32,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn ProcessPointerFramesInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    entriesCount: u32,
    pointerCount: u32,
    pointerInfo: ?*const POINTER_INFO,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn BufferPointerPacketsInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    entriesCount: u32,
    pointerInfo: [*]const POINTER_INFO,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn ProcessBufferedPacketsInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn ProcessInertiaInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn StopInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
) callconv(@import("std").os.windows.WINAPI) HRESULT;

// TODO: this type is limited to platform 'windows8.0'
pub extern "ninput" fn SetPivotInteractionContext(
    interactionContext: ?HINTERACTIONCONTEXT,
    x: f32,
    y: f32,
    radius: f32,
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
const HRESULT = @import("../foundation.zig").HRESULT;
const POINTER_INFO = @import("../ui/input/pointer.zig").POINTER_INFO;
const POINTER_INPUT_TYPE = @import("../ui/windows_and_messaging.zig").POINTER_INPUT_TYPE;

test {
    // The following '_ = <FuncPtrType>' lines are a workaround for https://github.com/ziglang/zig/issues/4476
    if (@hasDecl(@This(), "INTERACTION_CONTEXT_OUTPUT_CALLBACK")) { _ = INTERACTION_CONTEXT_OUTPUT_CALLBACK; }
    if (@hasDecl(@This(), "INTERACTION_CONTEXT_OUTPUT_CALLBACK2")) { _ = INTERACTION_CONTEXT_OUTPUT_CALLBACK2; }

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
