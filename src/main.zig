const std = @import("std");
const deque = @import("deque.zig");
const print = std.debug.print;
const data = @embedFile("./test.de");

pub fn main() !void {
    var deq = try deque.Deque(u8).init();
    var lines = std.mem.tokenize(u8, data, "\n");
    while (lines.next()) |line| {
        var it = std.mem.split(u8, line, " ");
        while (it.next()) |x| {
            var tokens: []const u8 = undefined;
            var direction: deque.Direction = undefined;
            if (x[0] == 33) {
                tokens = x[1..];
                direction = deque.Direction.Left;
            } else if (x[x.len - 1] == 33) {
                tokens = x[0..x.len - 1];
                direction = deque.Direction.Right;
            } else {
                return;
            }
            try deq.processTokens(tokens, direction);
        }
    }
    deq.printData();
}