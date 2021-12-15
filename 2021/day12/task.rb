#!/usr/bin/env ruby
class Cave
  attr_reader :name
  def initialize(name)
    @name = name
    @connected = []
  end

  def connect(cave)
    @connected << cave unless @connected.include?(cave)
    cave.connect(self) unless cave.connections.include?(self)
  end

  def connections
    @connected
  end

  def size
    @name.upcase == @name ? :big : :small
  end

  def start?
    @name == 'start'
  end

  def end?
    @name == 'end'
  end
end


class CaveSystem
  attr_reader :caves
  def initialize()
    @caves={}
  end

  def connect(a, b)
    @caves[a] ||= Cave.new(a)
    @caves[b] ||= Cave.new(b)

    @caves[a].connect(@caves[b])
  end
end

def can_visit?(system, path, c)
  return false if c.end? || c.start?
  return true if c.size == :big

  r = nil
  count = {}
  path.map{|p| system.caves[p] }.filter { |ca| ca.size == :small }.each do |ca|
    count[ca.name] ||= 0
    count[ca.name] += 1
    r = ca.name if count[ca.name] > 1
  end

  r.nil? || (system.caves[r].name != c.name && count[c.name].nil?)
end

input_file = File.open('input')
lines = input_file.readlines.map(&:chomp)

system = CaveSystem.new

lines.each do |line|
  a, b = line.split('-')
  system.connect(a,b)
end

paths = []
paths_to_explore = [['start']]

while paths_to_explore.any?
  new_paths = []
  paths_to_explore.each do |path|
    last_visited = path.last

    system.caves[last_visited].connections.each do |c|
      paths << [path, c.name].flatten if c.end?
      new_paths << [path, c.name].flatten unless c.start? || c.end? || (c.size == :small && path.include?(c.name))
    end
  end
  paths_to_explore = new_paths
end

p paths.size

paths = []
paths_to_explore = [['start']]

while paths_to_explore.any?
  new_paths = []
  paths_to_explore.each do |path|
    last_visited = path.last

    system.caves[last_visited].connections.each do |c|
      paths << [path, c.name].flatten if c.end?
      new_paths << [path, c.name].flatten if can_visit?(system,path,c)
    end
  end
  paths_to_explore = new_paths
end

p paths.size
