pub fn hello() []const u8 {
    return "Hello, World!";
}

pub fn main() void {
    @import("std").debug.print("{s}", .{hello()});
}
