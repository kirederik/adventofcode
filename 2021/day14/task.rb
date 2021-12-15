#!/usr/bin/env ruby

def split_groups(str, group_size)
  size = str.size - group_size
  g = []
  for i in 0..size
    g << str[i...i+group_size]
  end
  g
end

lines = []
input_file = File.open('input') do |f|
  lines = f.readlines.map(&:chomp)
end

template = lines.first

mapping = {}
lines = lines[2..-1]
lines.each do |line|
  pair, n = line.split('->').map(&:strip!)
  mapping[pair] = n
end

polymer = {}
chars = {}

template.split('').each do |c|
  chars[c] = chars[c].to_i + 1
end

split_groups(template,2).each do |p|
  polymer[p] = 1
end

for i in 1..40
  new_polymer = {}
  polymer.each do |key, v|
    unless mapping[key].nil?
      inserting = mapping[key]

      p1, p2 = [key[0] + inserting, inserting + key[1]]
      new_polymer[p1] = new_polymer[p1].to_i + v
      new_polymer[p2] = new_polymer[p2].to_i + v

      chars[inserting] = chars[inserting].to_i + v
    end
  end
  polymer = new_polymer
  if i == 10
    totals = chars.map { |k, v| v }
    puts totals.max - totals.min
  end
end


totals = chars.map { |k, v| v }
puts totals.max - totals.min

