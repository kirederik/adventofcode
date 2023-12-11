# frozen_string_literal: true

module Day10
  class Point
    attr_accessor :x, :y, :value

    def initialize(x, y, max_x, max_y)
      @x = x.to_i
      @y = y.to_i
      @max_x = max_x
      @max_y = max_y
    end

    def to_s
      "(#{x}, #{y})"
    end

    def north
      return nil if (@x - 1).negative?

      Point.new(@x - 1, @y, @max_x, @max_y)
    end

    def south
      return nil if @x + 1 >= @max_x

      Point.new(@x + 1, @y, @max_x, @max_y)
    end

    def east
      return nil if @y + 1 >= @max_y

      Point.new(@x, @y + 1, @max_x, @max_y)
    end

    def west
      return nil if (@y - 1).negative?

      Point.new(@x, @y - 1, @max_x, @max_y)
    end

    def eq(x, y)
      x == @x && y == @y
    end
  end

  def self.connected(point, other, connections)
    return '.' if other.nil?

    pv = connections[point.to_s]
    ov = connections[other.to_s]

    return '.' if ov.nil?

    return '#' if pv + 1 == ov || ov + 1 == pv

    '.'
  end

  def self.find_animal(map)
    map.each_with_index do |line, i|
      j = line.index('S')
      return Point.new(i, j, map.size, line.size) unless j.nil?
    end
  end

  def self.lookup(map, point)
    return nil if point.nil?

    [map[point.x][point.y], point]
  end

  def self.get_neighbours(map, point)
    [
      lookup(map, point.north),
      lookup(map, point.south),
      lookup(map, point.west),
      lookup(map, point.east)
    ]
  end

  def self.find_loop(m)
    map = m.map { |l| l.split('') }

    animal = find_animal(map)

    # x, y are the coordinates for the Animal
    visited = {}

    to_visit = [animal]

    points = []
    it = 0
    loop do
      connections = []
      while to_visit.size.positive?
        val, point = lookup(map, to_visit.pop)
        visited[point.to_s] = it

        n, s, w, e = get_neighbours(map, point)

        if val == 'S'
          connections << n[1] if !n.nil? && ['|', '7', 'F'].include?(n[0])
          connections << s[1] if !s.nil? && ['|', 'L', 'J'].include?(s[0])
          connections << w[1] if !w.nil? && ['-', 'L', 'F'].include?(w[0])
          connections << e[1] if !e.nil? && ['-', 'J', '7'].include?(e[0])
          next
        end

        connected = case val
                    when '|'
                      [n, s]
                    when '-'
                      [e, w]
                    when 'L'
                      [n, e]
                    when 'J'
                      [n, w]
                    when '7'
                      [s, w]
                    when 'F'
                      [s, e]
                    else
                      [nil, nil]
                    end

        connected.each do |c|
          next if c.nil? || !visited[c[1].to_s].nil?

          connections << c[1]
        end
      end
      to_visit = connections

      break if to_visit.empty?

      it += 1
      points += connections
    end
    [visited, it, points]
  end

  def self.debug(connections)
    p connections.map(&:to_s).join(', ')
  end

  def self.part1(input)
    find_loop(input)[1]
  end

  def self.expand(map, visited)
    expanded = []
    map.each_with_index do |rv, row|
      rows = [[], [], []]
      rv.each_with_index do |_cv, col|
        curr = Point.new(row, col, map.size, map[0].size)
        if visited[curr.to_s].nil?
          rows[0] += %w[. . .]
          rows[1] += %w[. . .]
          rows[2] += %w[. . .]
        else
          rows[0] += ['.', connected(curr, curr.north, visited), '.']
          rows[1] += [connected(curr, curr.west, visited), '#', connected(curr, curr.east, visited)]
          rows[2] += ['.', connected(curr, curr.south, visited), '.']
        end
      end
      expanded += rows
    end
    expanded
  end

  def self.reacheable_from_edge(map)
    max_x = map.size
    max_y = map[0].size
    to_visit = [Point.new(0, 0, max_x, max_y)]
    outside_points = {
      '(0, 0)' => true
    }
    it = 0
    loop do
      break if to_visit.empty?

      curr = to_visit.pop
      next if curr.nil?

      n, s, w, e = get_neighbours(map, curr)

      [n, s, w, e].each do |neighbour|
        next if neighbour.nil?

        p = neighbour[1]
        next if neighbour[0].nil? || outside_points[p.to_s] == true

        map_value = map[p.x][p.y]
        outside_points[p.to_s] = true
        to_visit << neighbour[1] unless map_value == '#'
      end
    end

    outside_points
  end

  def self.part2(input)
    map_loop = find_loop(input)

    map = input.map { |l| l.split('') }

    visited = map_loop[0]
    expanded_map = expand(map, visited)

    outside_loop = reacheable_from_edge(expanded_map)

    count = 0
    i = 1
    expanded_map.each_slice(3) do |rows|
      j = 1
      rows[1].each_slice(3) do |cols|
        count += 1 unless cols[1] == '#' || outside_loop["(#{i}, #{j})"]
        j += 3
      end
      i += 3
    end
    count
  end
end
