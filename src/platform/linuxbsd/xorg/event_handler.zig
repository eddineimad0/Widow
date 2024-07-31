const std = @import("std");
const common = @import("common");
const libx11 = @import("x11/xlib.zig");
const x11ext = @import("x11/extensions/extensions.zig");
const utils = @import("utils.zig");
const keymaps = @import("keymaps.zig");
const opts = @import("build-options");
const kbd_mouse = common.keyboard_mouse;
const X11Driver = @import("driver.zig").X11Driver;
const Window = @import("window.zig").Window;

fn handleButtonRelease(e: *const libx11.XButtonEvent, window: *Window) void {
    if (opts.LOG_PLATFORM_EVENTS) {
        std.log.info("window: #{} recieved ButtonRelease\n", .{window.data.id});
    }

    const button = switch (e.button) {
        libx11.Button1 => kbd_mouse.MouseButton.Left,
        libx11.Button2 => kbd_mouse.MouseButton.Middle,
        libx11.Button3 => kbd_mouse.MouseButton.Right,
        libx11.Button4,
        libx11.Button5,
        libx11.Button6,
        libx11.Button7,
        => {
            return;
        },
        else => {
            std.debug.print("\nbutton:{d}\n", .{e.button});
            return;
        },
    };

    window.data.input.mouse_buttons[@intFromEnum(button)] = .Released;
    const ev = common.event.createMouseButtonEvent(
        window.data.id,
        button,
        kbd_mouse.MouseButtonState.Released,
        utils.decodeKeyMods(e.state),
    );
    window.sendEvent(&ev);
}

fn handleButtonPress(e: *const libx11.XButtonEvent, window: *Window) void {
    if (opts.LOG_PLATFORM_EVENTS) {
        std.log.info("window: #{} recieved ButtonPress\n", .{window.data.id});
    }

    const button_event = switch (e.button) {
        libx11.Button1 => ev: {
            window.data.input.mouse_buttons[@intFromEnum(kbd_mouse.MouseButton.Left)] = .Pressed;
            break :ev common.event.createMouseButtonEvent(
                window.data.id,
                kbd_mouse.MouseButton.Left,
                kbd_mouse.MouseButtonState.Pressed,
                utils.decodeKeyMods(e.state),
            );
        },
        libx11.Button2 => ev: {
            window.data.input.mouse_buttons[@intFromEnum(kbd_mouse.MouseButton.Middle)] = .Pressed;
            break :ev common.event.createMouseButtonEvent(
                window.data.id,
                kbd_mouse.MouseButton.Middle,
                kbd_mouse.MouseButtonState.Pressed,
                utils.decodeKeyMods(e.state),
            );
        },
        libx11.Button3 => ev: {
            window.data.input.mouse_buttons[@intFromEnum(kbd_mouse.MouseButton.Right)] = .Pressed;
            break :ev common.event.createMouseButtonEvent(
                window.data.id,
                kbd_mouse.MouseButton.Right,
                kbd_mouse.MouseButtonState.Pressed,
                utils.decodeKeyMods(e.state),
            );
        },
        // INFO:
        // [https://github.com/libsdl-org/SDL/blob/main/src/video/x11/SDL_x11events.c#L185C5-L187C80]
        // according to the xlib docs, no specific mouse wheel events exist.
        // However, the defacto standard is that the vertical wheel is X buttons
        // 4 (up) and 5 (down) and a horizontal wheel is 6 (left) and 7 (right).
        libx11.Button4 => common.event.createScrollEvent(
            window.data.id,
            0.0,
            1.0,
        ),
        libx11.Button5 => common.event.createScrollEvent(
            window.data.id,
            0.0,
            -1.0,
        ),
        libx11.Button6 => common.event.createScrollEvent(
            window.data.id,
            1.0,
            0.0,
        ),
        libx11.Button7 => common.event.createScrollEvent(
            window.data.id,
            -1.0,
            0.0,
        ),
        else => return,
    };
    window.sendEvent(&button_event);
}

/// handles ICCCM messages.
fn handleClientMessage(e: *const libx11.XClientMessageEvent, w: *Window) void {
    const drvr = X11Driver.singleton();
    if (e.message_type == drvr.ewmh.WM_PROTOCOLS) {
        if (@as(libx11.Atom, @intCast(e.data.l[0])) == drvr.ewmh.WM_DELETE_WINDOW) {
            if (opts.LOG_PLATFORM_EVENTS) {
                std.log.info(
                    "window: #{} recieved ClientMessage:WM_DELETE_WINDOW\n",
                    .{w.handle},
                );
            }
            const event = common.event.createCloseEvent(w.data.id);
            w.sendEvent(&event);
        }
        if (@as(libx11.Atom, @intCast(e.data.l[0])) == drvr.ewmh._NET_WM_PING) {
            if (opts.LOG_PLATFORM_EVENTS) {
                std.log.info(
                    "window: #{} recieved ClientMessage:_NET_WM_PING\n",
                    .{w.handle},
                );
            }
            // ping from the wm to ensure application responsivity.
            // we just need to keep sending ping until the communication
            // is over.
            var reply = libx11.XEvent{ .xclient = e.* };
            reply.xclient.window = drvr.windowManagerId();
            drvr.sendXEvent(&reply, drvr.windowManagerId());
        }
    } else if (e.message_type == drvr.ewmh.XdndEnter) {
        w.x11.xdnd_req.src = e.data.l[0];
        w.x11.xdnd_req.ver = e.data.l[1] >> 24;
        w.x11.xdnd_req.format = 0;

        var extra_formats_count: u32 = 0;
        var extra_formats: [*]const libx11.Atom = undefined;
        const extra_types = e.data.l[0] & 1;
        if (extra_types != 0) {
            extra_formats_count = utils.x11WindowProperty(
                drvr.handles.xdisplay,
                @bitCast(w.x11.xdnd_req.src),
                drvr.ewmh.XdndTypeList,
                libx11.XA_ATOM,
                @ptrCast(&extra_formats),
            ) catch err: {
                extra_formats = @ptrCast(&e.data.l[2]);
                break :err 3;
            };
            std.debug.assert(extra_formats_count != 0);
        } else {
            extra_formats_count = 3;
            extra_formats = @ptrCast(&e.data.l[2]);
        }

        for (0..extra_formats_count) |i| {
            if (extra_formats[i] == drvr.ewmh.text_uri_list) {
                w.x11.xdnd_req.format = @intCast(drvr.ewmh.text_uri_list);
                break;
            }
        }

        if (extra_types != 0 and @intFromPtr(extra_formats) != @intFromPtr(&e.data.l[2])) {
            _ = libx11.XFree(@constCast(extra_formats));
        }
    } else if (e.message_type == drvr.ewmh.XdndDrop) {
        // TODO:
    }
}

fn handleKeyPress(ev: *const libx11.XKeyEvent, window: *Window) void {
    const km = keymaps.KeyMaps.singleton();
    switch (ev.type) {
        libx11.KeyPress => {
            if (opts.LOG_PLATFORM_EVENTS) {
                std.log.info(
                    "window: #{} recieved KeyPress:code {}\n",
                    .{ window.data.id, ev.keycode },
                );
            }
            const keycode = km.lookupKeyCode(@intCast(ev.keycode));
            const scancode = keymaps.keycodeToScancode(@intCast(ev.keycode));
            var mods = utils.decodeKeyMods(ev.state);
            utils.fixKeyMods(&mods, keycode, kbd_mouse.KeyState.Pressed);
            var event = common.event.createKeyboardEvent(
                window.data.id,
                keycode,
                scancode,
                kbd_mouse.KeyState.Pressed,
                mods,
            );
            window.sendEvent(&event);
            var keysym: libx11.KeySym = 0;
            _ = libx11.XLookupString(@constCast(ev), null, 0, &keysym, null);
            if (km.lookupKeyCharacter(keysym)) |codepoint| {
                if (opts.LOG_PLATFORM_EVENTS) {
                    std.log.info(
                        "window: #{} recieved Character:codepoint {}\n",
                        .{ window.data.id, codepoint },
                    );
                }
                event = common.event.createCharEvent(window.data.id, codepoint, mods);
                window.sendEvent(&event);
            }
        },

        libx11.KeyRelease => {
            // used when we can't set auto repeat through xkb.
            const KEY_EVENT_REPEAT_THRESHOLD = 25;
            if (opts.LOG_PLATFORM_EVENTS) {
                std.log.info("window: #{} recieved KeyPress:code {}\n", .{ window.data.id, ev.keycode });
            }
            const x11driver = X11Driver.singleton();
            if (!x11driver.extensions.xkb.is_auto_repeat_detectable) {
                // INFO:
                // hack from glfw
                // if if we couldn't enable key autorepeat through Xkeyboard
                // extension we can simulate it by reading ahead in the event queue
                // and setting an autorepeat threshold for wich we can ignore key release
                // events.
                if (libx11.XEventsQueued(
                    x11driver.handles.xdisplay,
                    libx11.QueuedAfterReading,
                ) != 0) {
                    var next_xevent: libx11.XEvent = undefined;
                    _ = libx11.XPeekEvent(x11driver.handles.xdisplay, &next_xevent);
                    if (next_xevent.type == libx11.KeyPress and
                        next_xevent.xkey.window == ev.window and
                        next_xevent.xkey.keycode == ev.keycode and
                        (next_xevent.xkey.time - ev.time) < KEY_EVENT_REPEAT_THRESHOLD)
                    {
                        // ignore the current event
                        return;
                    }
                }
            }
            const keycode = km.lookupKeyCode(@intCast(ev.keycode));
            const scancode = keymaps.keycodeToScancode(@intCast(ev.keycode));
            var mods = utils.decodeKeyMods(ev.state);
            utils.fixKeyMods(&mods, .Up, kbd_mouse.KeyState.Released);
            var event = common.event.createKeyboardEvent(
                window.data.id,
                keycode,
                scancode,
                kbd_mouse.KeyState.Released,
                mods,
            );
            window.sendEvent(&event);
        },
        else => unreachable,
    }
}

// fn handleXkbEvent(ev: *const x11ext.XkbEvent, helper_data: *HelperData) void {
//     _ = helper_data;
//     if (opts.LOG_PLATFORM_EVENTS) {
//         std.log.info("window: #hidden recieved XkbEvent\n", .{});
//     }
//     switch (ev.any.xkb_type) {
//         x11ext.XkbStateNotify => {
//             std.debug.print("New group:{}\n", .{ev.state.group});
//         },
//         else => {},
//     }
// }

// fn handleXrandrScreenChange(ev: *const libx11.XEvent, helper_data: *HelperData) void {
//     _ = helper_data;
//     if (opts.LOG_PLATFORM_EVENTS) {
//         std.log.info("window: #hidden recieved RRScreenChangeNotify\n", .{});
//     }
//     const x11driver = X11Driver.singleton();
//     _ = x11driver.extensions.xrandr.XRRUpdateConfiguration(@constCast(ev));
// }

// pub fn handleHelperEvent(ev: *const libx11.XEvent, helper_window: libx11.Window) void {
//     const x11driver = X11Driver.singleton();
//     const context_ptr = x11driver.findInXContext(helper_window);
//     if (context_ptr == null) {
//         std.log.err("helper window has no corresponding data in Xcontext, this shouldn't happen.\n", .{});
//         @panic("Unexpected null pointer.");
//     }
//     const helper_data: *HelperData = @ptrCast(@alignCast(context_ptr.?));
//     if (ev.type == x11driver.extensions.xrandr.event_code + x11ext.RRScreenChangeNotify) {
//         handleXrandrScreenChange(ev, helper_data);
//     } else if (x11driver.extensions.xkb.is_available and ev.type == x11driver.extensions.xkb.event_code) {
//         handleXkbEvent(@ptrCast(ev), helper_data);
//     }
// }

pub fn handleWindowEvent(ev: *const libx11.XEvent, window: *Window) void {
    switch (ev.type) {
        libx11.ButtonPress => handleButtonPress(&ev.xbutton, window),
        libx11.ButtonRelease => handleButtonRelease(&ev.xbutton, window),
        libx11.KeyPress, libx11.KeyRelease => handleKeyPress(&ev.xkey, window),

        libx11.EnterNotify => {
            if (opts.LOG_PLATFORM_EVENTS) {
                std.log.info(
                    "window: #{} recieved EnterNotify\n",
                    .{window.data.id},
                );
            }
            const x, const y = .{ ev.xcrossing.x, ev.xcrossing.y };
            window.x11.cursor.pos = .{ .x = x, .y = y };
            // TODO: update cursor image.
            const enter_event = common.event.createMouseEnterEvent(window.data.id);
            window.sendEvent(&enter_event);
            window.data.flags.cursor_in_client = true;
            const pos_event = common.event.createMoveEvent(window.data.id, x, y, true);
            window.sendEvent(&pos_event);
        },

        libx11.LeaveNotify => {
            if (opts.LOG_PLATFORM_EVENTS) {
                std.log.info(
                    "window: #{} recieved LeaveNotify\n",
                    .{window.data.id},
                );
            }
            window.data.flags.cursor_in_client = false;
            const event = common.event.createMouseExitEvent(window.data.id);
            window.sendEvent(&event);
        },

        libx11.ClientMessage => handleClientMessage(&ev.xclient, window),

        libx11.FocusIn => {
            if (opts.LOG_PLATFORM_EVENTS) {
                std.log.info(
                    "window: #{} recieved FocusIn\n",
                    .{window.data.id},
                );
            }
            // TODO: update cursor image.
            const event = common.event.createFocusEvent(window.data.id, true);
            window.sendEvent(&event);
        },

        libx11.FocusOut => {
            if (opts.LOG_PLATFORM_EVENTS) {
                std.log.info(
                    "window: #{} recieved FocusOut\n",
                    .{window.data.id},
                );
            }
            // TODO: update cursor image.
            const event = common.event.createFocusEvent(window.data.id, false);
            window.sendEvent(&event);
        },

        libx11.MotionNotify => {
            if (opts.LOG_PLATFORM_EVENTS) {
                std.log.info(
                    "window: #{} recieved MotionNotify\n",
                    .{window.data.id},
                );
            }
            const x, const y = .{ ev.xmotion.x, ev.xmotion.y };
            if (x != window.x11.cursor.pos.x or y != window.x11.cursor.pos.y) {
                window.x11.cursor.pos = .{ .x = x, .y = y };
                const event = common.event.createMoveEvent(window.data.id, x, y, true);
                window.sendEvent(&event);
            }
        },

        libx11.ConfigureNotify => {
            if (opts.LOG_PLATFORM_EVENTS) {
                std.log.info(
                    "window: #{} recieved ConfigureNotify\n",
                    .{window.data.id},
                );
            }

            if (ev.xconfigure.width != window.data.client_area.size.width or
                ev.xconfigure.height != window.data.client_area.size.height)
            {
                window.data.client_area.size.width = ev.xconfigure.width;
                window.data.client_area.size.height = ev.xconfigure.height;

                const event = common.event.createResizeEvent(
                    window.data.id,
                    ev.xconfigure.width,
                    ev.xconfigure.height,
                );
                window.sendEvent(&event);
            }

            const wndw_pos_x, const wndw_pos_y = .{ ev.xconfigure.x, ev.xconfigure.y };

            if (wndw_pos_x != window.data.client_area.top_left.x or
                wndw_pos_y != window.data.client_area.top_left.y)
            {
                window.data.client_area.top_left.x = wndw_pos_x;
                window.data.client_area.top_left.y = wndw_pos_y;

                const event = common.event.createMoveEvent(
                    window.data.id,
                    wndw_pos_x,
                    wndw_pos_y,
                    false,
                );
                window.sendEvent(&event);
            }
        },

        libx11.Expose => {
            if (opts.LOG_PLATFORM_EVENTS) {
                std.log.info(
                    "window: #{} recieved Expose\n",
                    .{window.data.id},
                );
            }
            const event = common.event.createRedrawEvent(window.data.id);
            window.sendEvent(&event);
        },

        else => {},
    }
}
