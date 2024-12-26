const std = @import("std");
const common = @import("common");
const gl = @import("opengl");
const platform = @import("platform");

const mem = std.mem;

// Exports
pub const geometry = common.geometry;
pub const cursor = common.cursor;

pub const keyboard = struct {
    pub const KeyCode = common.keyboard_mouse.KeyCode;
    pub const ScanCode = common.keyboard_mouse.ScanCode;
    pub const KeyState = common.keyboard_mouse.KeyState;
    pub const KeyModifiers = common.keyboard_mouse.KeyModifiers;
};

pub const mouse = struct {
    pub const MouseButton = common.keyboard_mouse.MouseButton;
    pub const MouseButtonState = common.keyboard_mouse.MouseButtonState;
};

pub const event = struct {
    pub const Event = common.event.Event;
    pub const EventType = common.event.EventType;
    pub const EventQueue = common.event.EventQueue;
};

pub const opengl = struct {
    /// platform specific function for fetching
    /// opengl functions after creating an opengl
    /// rendering context.
    pub const loaderFunc = platform.glLoaderFunc;
    pub const GLconfig = gl.GLConfig;
};

pub const VideoMode = common.video_mode.VideoMode;

// TODO: Document
pub const createWidowContext = platform.createWidowContext;
pub const destroyWidowContext = platform.destroyWidowContext;
pub const WindowBuilder = @import("window.zig").WindowBuilder;
