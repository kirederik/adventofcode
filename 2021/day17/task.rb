#!/usr/bin/env ruby

def between(x, arr)
  x >= arr[0] && x <= arr[1]
end

def out_limits(n, arr)
  n > arr[1]
end

def out_limits_y(n, arr)
  n < arr[0]
end

def max_height(xs, ys, target_x, target_y)
  x = xs
  y = ys
  max_height = 0
  loop do
    xs = xs == 0 ? xs : xs - 1
    ys -= 1
    max_height = y if y > max_height
    if between(x, target_x) && between(y, target_y)
      return max_height
    end
    if out_limits_y(y, target_y) || out_limits(x, target_x)
      return -1
    end

    x += xs
    y += ys
  end
  -1
end


# Inputs:
#   Test data: target area: x=20..30, y=-10..-5
#   Real data: target area: x=85..145, y=-163..-108
x_start = 85
x_end = 145
y_start=-163
y_end=-108

possible_ys = (-(y_start.abs)..y_start.abs).to_a
possible_xs = (0..x_end).to_a

heights = []
pairs = []
possible_xs.each do |x|
  possible_ys.each do |y|
    h = max_height(x, y, [x_start, x_end], [y_start, y_end])
    if h >= 0
      pairs << [x,y]
      heights << h
    end
  end
end

puts heights.max
p pairs.size
