const std = @import("std");

const DisplayProtocol = enum {
    Win32,
    Xorg,
    Wayland,
};

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    var display_target = b.option(
        DisplayProtocol,
        "widow_display_protocol",
        "Specify the display protocol to compile for.",
    );
    const log_platform_events = b.option(bool, "log_platform_events", "Print platform events messages.") orelse
        false;

    if (display_target) |t| {
        if (!isDisplayTargetValid(&target, t)) {
            @panic("The specified Os target and display_protocol combination isn't supported.");
        }
    } else {
        display_target = detectDispalyTarget(&target, b.allocator);
    }

    const options = b.addOptions();
    options.addOption(bool, "LOG_PLATFORM_EVENTS", log_platform_events);
    const config = options.createModule();

    const widow = prepareWidowModule(b, display_target.?, config);

    const example_step = b.step("example", "Compile example");
    const examples = [_][]const u8{
        // "simple_window",
        // "playing_with_inputs",
        // "cursor_and_icon",
        "xorg_basic",
    };
    for (examples) |example_name| {
        const example = b.addExecutable(.{
            .name = example_name,
            .root_source_file = .{ .path = b.fmt("examples/{s}.zig", .{example_name}) },
            .target = target,
            .optimize = optimize,
        });
        example.addOptions("widow_build_config", options);
        example.addModule("widow", widow);
        example.linkLibC();
        const install_step = b.addInstallArtifact(example, .{});
        example_step.dependOn(&example.step);
        example_step.dependOn(&install_step.step);
    }
}

fn isDisplayTargetValid(os_target: *const std.zig.CrossTarget, protocol_choise: DisplayProtocol) bool {
    return switch (os_target.getOs().tag) {
        .windows => protocol_choise == .Win32,
        .linux, .freebsd, .netbsd => (protocol_choise == .Xorg or protocol_choise == .Wayland),
        else => false,
    };
}

fn detectDispalyTarget(os_target: *const std.zig.CrossTarget, allocator: std.mem.Allocator) DisplayProtocol {
    const SESSION_X11: [*:0]const u8 = "x11";
    const SESSION_WAYLAND: [*:0]const u8 = "wayland";

    return switch (os_target.getOs().tag) {
        .windows => .Win32,
        .linux, .freebsd, .netbsd => unix: {
            // need to determine what display server is being used
            const display_session_type = std.process.getEnvVarOwned(allocator, "XDG_SESSION_TYPE") catch
                @panic("Couldn't determine display server type\n");
            defer allocator.free(display_session_type);
            if (display_session_type.len == 0) {
                @panic("XDG_SESSION_TYPE env variable not set");
            }

            if (std.mem.eql(u8, display_session_type, std.mem.span(SESSION_X11))) {
                break :unix .Xorg;
            } else if (std.mem.eql(u8, display_session_type, std.mem.span(SESSION_WAYLAND))) {
                break :unix .Wayland;
            } else {
                @panic("Unsupported unix display server");
            }
        },
        else => @panic("Unsupported Target"),
    };
}

fn prepareWidowModule(b: *std.Build, target: DisplayProtocol, config: *std.build.Module) *std.build.Module {
    const common_module = b.createModule(.{
        .source_file = .{ .path = "src/common/common.zig" },
        .dependencies = &.{
            std.build.ModuleDependency{ .name = "widow_build_config", .module = config },
        },
    });
    const common_dep = std.build.ModuleDependency{ .name = "common", .module = common_module };

    var platform_dep: *std.build.Module = switch (target) {
        .Win32 => win32: {
            var zigwin32 = b.createModule(.{
                .source_file = .{ .path = "libs/zigwin32/win32.zig" },
            });
            var deps: [2]std.build.ModuleDependency = undefined;
            deps[0] = common_dep;
            deps[1] = std.build.ModuleDependency{ .name = "zigwin32", .module = zigwin32 };
            break :win32 b.createModule(
                .{ .source_file = .{ .path = "src/platform/win32/platform.zig" }, .dependencies = &deps },
            );
        },
        .Xorg => xorg: {
            var deps: [1]std.build.ModuleDependency = .{common_dep};
            break :xorg b.createModule(
                .{ .source_file = .{ .path = "src/platform/linuxbsd/xorg/platform.zig" }, .dependencies = &deps },
            );
        },
        else => {
            @panic("Unsupported platform");
        },
    };

    const deps = [_]std.build.ModuleDependency{
        common_dep,
        std.build.ModuleDependency{ .name = "platform", .module = platform_dep },
    };

    const widow = b.addModule("widow", .{ .source_file = .{ .path = "src/main.zig" }, .dependencies = &deps });
    return widow;
}
