const std = @import("std");
const Allocator = std.mem.Allocator;
const print = std.debug.print;

pub const Direction = enum {
    Left,
    Right,
};

pub fn Deque(comptime T: type) type {
    return struct {
        const Self = @This();

        left: usize,
        right: usize,
        data: []T,
        allocator: Allocator,

        pub fn init() Allocator.Error!Self {
            const allocator = std.heap.page_allocator;
            var res = Self{ .data = try allocator.alloc(T, 3), .left = 0, .right = 0, .allocator = allocator };
            res.zero();
            return res;
        }

        pub fn deinit(self: Self) void {
            self.allocator.free(self.data);
        }

        pub fn append(self: *Self, elem: T, direction: Direction) !void {
            if (!self.capEnough()) {
                try self.growDeque();
            }
            self.right += 1;
            switch (direction) {
                Direction.Left => {
                    var i: usize = self.data.len - 1;
                    while (i > 0) : (i -= 1) {
                        self.data[i] = self.data[i - 1];
                    }
                    self.data[0] = elem;
                },
                Direction.Right => {
                    self.data[self.right] = elem;
                },
            }
        }

        pub fn printData(self: *Self) void {
            for (self.data) |elem| {
                print("{} ", .{elem});
            }
            print("\n", .{});
        }

        pub fn processTokens(self: *Self, tokens: []const T, direction: Direction) !void {
            for (tokens) |v| {
                try self.append(try std.fmt.charToDigit(v, 10), direction);
            }
        }

        fn capEnough(self: *Self) bool {
            return self.data.len - self.right > 1;
        }

        fn growDeque(self: *Self) Allocator.Error!void {
            self.data = try self.allocator.realloc(self.data, self.right * 2);
        }

        fn zero(self: *Self) void {
            for (self.data) |*elem| {
                elem.* = 0;
            }
        }
    };
}
