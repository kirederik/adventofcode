#!/usr/bin/env ruby

input_file = File.open("input")
lines = input_file.readlines.map(&:chomp)

rows = lines.size
cols = lines.first.size

def pos(i, j, dir)
  case dir
  when :above
    i = i-1
  when :right
    j = j + 1
  when :left
    j = j - 1
  when :below
    i = i + 1
  end

  return i, j
end

def print_grid(grid)
  rows = grid.size
  cols = grid.first.size
  for i in 0...rows
    for j in 0...cols
      if grid[i][j][:c]
        print "."
      else
        print " "
      end
    end
    puts ""
  end
end

def element(m, i, j, dir)
  i, j = pos(i, j, dir)
  return nil if i < 0 || j < 0 || m[i].nil?

  m[i][j]
end

def adj(grid, i, j, cluster_size)
  for d in %i[above right left below]
    ni, nj = pos(i, j, d)
    next if ni < 0 || ni >= grid.size || nj < 0 || nj >= grid.first.size
    nb = grid[ni][nj]
    next unless nb[:c]
    grid[ni][nj][:c] = false
    cluster_size = adj(grid, ni, nj, cluster_size+1)
  end
  cluster_size
end

grid = []
for i in 0...rows
  grid << []
  for j in 0...cols
    n = lines[i][j].to_i
    grid[i] << { v: n, c: false }
  end
end

for i in 0...rows
  for j in 0...cols
    n = grid[i][j][:v]
    next if n == 9
    for d in %i[above right left below]
      ni, nj = pos(i, j, d)
      next if ni < 0 || ni >= cols || nj < 0 || nj >= rows
      nb = grid[ni][nj]
      if n > nb[:v] || nb[:v] > n && nb[:v] != 9
        grid[i][j][:c] = true
        break
      end
    end
  end
end

group=0
total=[]
for i in 0...rows
  for j in 0...cols
    if grid[i][j][:c]
      grid[i][j][:c] = false
      group = adj(grid, i, j, 1)
    else
      total << group if group != 0
      group = 0
    end
  end
end
puts total.sort[-3...].reduce(:*)

