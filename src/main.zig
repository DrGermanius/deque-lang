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
            if (x[0] == 33) {
                try deq.append(try std.fmt.charToDigit(x[1], 10), .Left);
            } else if (x[x.len - 1] == 33) {
                try deq.append(try std.fmt.charToDigit(x[0], 10), .Right);
            } else {
                return;
            }
        }
    }
    deq.printData();
}
