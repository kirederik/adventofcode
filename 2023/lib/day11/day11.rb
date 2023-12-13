# frozen_string_literal: true

module Day11
  def self.expand(universe)
    cols = universe.first.size

    expanded = []
    universe.each do |row|
      expanded << row
      expanded << ('. ' * cols).split unless row.include?('#')
    end
    transposed = expanded.transpose

    rows = expanded.size
    expanded = []
    transposed.each do |col|
      expanded << col
      expanded << ('. ' * rows).split unless col.include?('#')
    end
    expanded.transpose
  end

  def self.manhattan(pt1, pt2)
    (pt1[0] - pt2[0]).abs + (pt1[1] - pt2[1]).abs
  end

  def self.find_galaxies(universe)
    points = []
    universe.each_with_index do |row, row_index|
      cols = row.size.times.select { |i| row[i] == '#' }
      cols.each do |c|
        points << [row_index, c]
      end
    end
    points
  end

  def self.part1(input)
    puts
    universe = input.map { |r| r.split('') }
    galaxies = find_galaxies(expand(universe))

    distances = []
    start = 1
    galaxies.each do |g|
      galaxies[start..].each do |o|
        d = manhattan(g, o)
        distances << d
      end
      start += 1
    end

    distances.reduce(&:+)
  end

  def self.find_empty(universe)
    empty_rows = []
    universe.each_with_index do |row, index|
      empty_rows << index unless row.include?('#')
    end
    empty_cols = []
    universe.transpose.each_with_index do |col, index|
      empty_cols << index unless col.include?('#')
    end
    [
      empty_rows,
      empty_cols
    ]
  end

  def self.empty_between(g1, g2, void)
    void_rows = void[0]
    void_cols = void[1]

    minx = [g1[0], g2[0]].min
    maxx = [g1[0], g2[0]].max
    miny = [g1[1], g2[1]].min
    maxy = [g1[1], g2[1]].max

    empty_rows = void_rows.select { |c| c.between?(minx, maxx) }.size
    empty_cols = void_cols.select { |c| c.between?(miny, maxy) }.size

    [
      empty_rows,
      empty_cols
    ]
  end

  def self.part2(input, space)
    space -= 1
    universe = input.map { |r| r.split('') }
    galaxies = find_galaxies(universe)
    void = find_empty(universe)

    distance = 0
    start = 1
    galaxies.each do |g|
      galaxies[start..].each do |o|
        d = manhattan(g, o)
        distance += d
        empty = empty_between(g, o, void)

        distance = distance + (space * empty[0]) + (space * empty[1])
      end
      start += 1
    end

    distance
  end
end
