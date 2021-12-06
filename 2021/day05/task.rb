def fill(grid, x, y)
  if grid[y].nil?
    grid[y] = Hash.new
  end

  grid[y][x] ||= 0
  grid[y][x] += 1
  if grid[y][x] == 2
    return 1
  end

  return 0
end

def build_grid(lines, include_diagonal=false)
  grid = Hash.new
  inter = 0
  lines.each do |line|
    points = line.split("->").map(&:chomp)

    start_p = points[0].split(",").map(&:to_i)
    x1, y1 = start_p

    end_p = points[1].split(",").map(&:to_i)
    x2, y2 = end_p

    min_y = [y1,y2].min
    max_y = [y1,y2].max

    min_x = [x1,x2].min
    max_x = [x1,x2].max

    if x1 == x2
      (min_y..max_y).each do |y|
        inter += fill(grid, x1, y)
      end
    elsif y1 == y2
      (min_x..max_x).each do |x|
        inter += fill(grid, x, y1)
      end
    elsif include_diagonal
      y = min_y
      incr = -1
      x = (y == y1) ? x1 : x2
      if x == x1 && x1 < x2 || x == x2 && x2 < x1
        incr = 1
      end

      while y <= max_y
        inter += fill(grid, x, y)
        y += 1
        x += incr
      end
    end
  end

  inter
end

def task_a(lines)
  puts build_grid(lines, false)
end

def task_b(lines)
  puts build_grid(lines, true)
end

input_file = File.open("input")
lines = input_file.readlines.map(&:chomp)
task_a(lines)
task_b(lines)
