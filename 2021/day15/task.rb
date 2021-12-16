#!/usr/bin/env ruby

require_relative 'queue'

class Node
  attr_reader :risk, :i, :j

  def initialize(risk, i, j)
    @risk = risk
    @i = i
    @j = j
    @connected = []
  end

  def connect(node)
    @connected << node unless @connected.include?(node)
  end

  def connections
    @connected
  end

  def to_s
    @risk
  end
end

def estimate(a, b)
  (a.i - b.i).abs + (a.j - b.j).abs
end

def connect(nodes, i, j)
  [[i, j-1], [i, j+1], [i-1, j], [i+1, j]].each do |coor|
    x, y = coor
    next if x < 0 || y < 0 || x >= nodes.size || y >= nodes[0].size
    nodes[i][j].connect(nodes[x][y])
  end
end

def cost(a)
  a.inject(0) do |sum, e|
    sum + e.risk
  end
end

def grow(grid)
  nodes = grid.dup
  rows = nodes.size
  cols = nodes[0].size

  (1..4).each do |it|
    for i in 0...rows
      for j in 0...cols
        y = (cols * it) - cols + j
        v = (nodes[i][y].risk + 1)
        nodes[i] << Node.new(v <= 9 ? v : 1, i, y)
      end
    end
  end

  cols = nodes[0].size
  (1...5).each do |it|
    for i in 0...rows
      new_nodes = []
      for j in 0...cols
        x = (rows * it) + i
        v = (nodes[x - rows][j].risk + 1)
        new_nodes << Node.new(v <= 9 ? v : 1, x, j)
      end
      nodes << new_nodes
    end
  end

  nodes
end

def connect_all(nodes)
  for i in 0...nodes.size
    for j in 0...nodes[0].size
      connect(nodes, i, j)
    end
  end
end

def a_star(nodes)
  root = nodes[0][0]
  goal = nodes[nodes.size-1][nodes[0].size-1]
  frontier = SimplePriorityQueue.new
  frontier << Element.new(root, 0)

  came_from = {}
  cost_so_far = {}
  came_from[root] = nil
  cost_so_far[root] = 0

  while frontier.any?
    current = frontier.pop

    current.node.connections.each do |node|
      new_cost = cost_so_far[current.node] + node.risk
      if cost_so_far[node].nil? || new_cost < cost_so_far[node]
        cost_so_far[node] = new_cost
        frontier << Element.new(node, estimate(goal, node))
        came_from[node] = current.node
      end
    end
  end
  cost_so_far[goal]
end

lines = []
input_file = File.open('input') do |f|
  lines = f.readlines.map(&:chomp)
end

nodes = []
lines.each_with_index do |l, i|
  risks = l.split('').map(&:to_i)
  ns = []
  risks.each_with_index do |r, j|
    ns << Node.new(r, i, j)
  end
  nodes << ns
end

connect_all(nodes)
puts a_star(nodes)

nodes = grow(nodes)
connect_all(nodes)

puts a_star(nodes)
