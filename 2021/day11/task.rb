#!/usr/bin/env ruby
class Counter
  attr_accessor :c
  def initialize()
    @c = 0
  end

  def incr
    @c += 1
  end

  def total
    @c
  end

  def reset
    @c = 0
  end
end

class Octopus
  attr_accessor :energy

  def initialize(energy)
    @energy = energy.to_i
  end
end

def print_grid(octopuses)
  octopuses.each do |a|
    a.each do |o|
      print o.energy
    end
    puts ""
  end
  puts ""
end

def flash_neighbours(octs, flashed, i, j)
  neighbours = [
    [i-1, j-1],
    [i-1, j],
    [i-1, j+1],
    [i, j-1],
    [i, j+1],
    [i+1, j-1],
    [i+1, j],
    [i+1, j+1],
  ]

  neighbours.each do |coor|
    x, y = coor
    next if x < 0 || y < 0 || octs[x].nil? || octs[x][y].nil?
    next if flashed[[i,j]].include?(coor)
    o = octs[x][y]
    next if o.energy == 0

    o.energy += 1
    flashed[coor] ||= []
    flashed[coor] << [i,j]
    flashed[[i,j]] << coor
    if o.energy > 9
      flashed = flash_neighbours(octs, flashed, x, y)
      o.energy = 0
    end
  end

  return flashed
end

input_file = File.open('input')
lines = input_file.readlines.map(&:chomp)

octopuses = []
lines.each do |line|
  octopuses << line.split('').map do |c|
    Octopus.new(c)
  end
end
rows = octopuses.size
cols = octopuses.first.size

total = 0
for steps in 1...101
  octopuses.each do |octs|
    octs.each do |o|
      o.energy += 1
    end
  end

  flashed = {}
  octopuses.each_with_index do |octs, i|
    octs.each_with_index do |o, j|
      if o.energy > 9
        flashed[[i,j]] ||= []
        flashed = flash_neighbours(octopuses, flashed, i, j)
        o.energy = 0
      end
    end
  end

  total += octopuses.flatten.filter { |x| x.energy == 0 }.size
end

puts total


octopuses = []
lines.each do |line|
  octopuses << line.split('').map do |c|
    Octopus.new(c)
  end
end
rows = octopuses.size
cols = octopuses.first.size

puts "----"

it=0
loop do
  it+=1
  octopuses.each do |octs|
    octs.each do |o|
      o.energy += 1
    end
  end

  flashed = {}
  octopuses.each_with_index do |octs, i|
    octs.each_with_index do |o, j|
      if o.energy > 9
        flashed[[i,j]] ||= []
        flashed = flash_neighbours(octopuses, flashed, i, j)
        o.energy = 0
      end
    end
  end

  if rows * cols == octopuses.flatten.filter { |x| x.energy == 0 }.size
    print_grid(octopuses)
    puts it
    break
  end
end
