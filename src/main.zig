const std = @import("std");
const deque = @import("deque.zig");
const print = std.debug.print;

pub fn main() !void {
    var a = try deque.Deque(u8).init();
    try a.append(10, deque.Direction.Right);
    try a.append(20, deque.Direction.Right);
    try a.append(30, deque.Direction.Right);
    try a.append(40, deque.Direction.Left);
    try a.append(50, deque.Direction.Left);
    try a.append(60, deque.Direction.Left);
    try a.append(70, deque.Direction.Right);
    a.printData();
}
