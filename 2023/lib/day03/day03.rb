# frozen_string_literal: true

class String
  def integer?
    to_i.to_s == self
  end
end

module Day03
  def self.next_number(line, start_position)
    (start_position...line.size).each_with_object({ start: nil, end: nil }) do |i, index|
      c = line[i]
      unless c.integer?
        next if index[:start].nil?

        return index
      end

      index[:start] = i if index[:start].nil?
      index[:end] = i
    end
  end

  def self.symbol?(line, index)
    return false if line.nil?

    !(line[index].integer? || line[index] == '.')
  end

  def self.symbol_in_col?(index, bef, curr, aft)
    return false if index.negative? || index >= curr.size

    symbol?(bef, index) || symbol?(aft, index) || symbol?(curr, index)
  end

  def self.part_number?(current, bef, aft, coord)
    i = coord[:start]
    j = coord[:end]

    return true if symbol_in_col?(i - 1, bef, current, aft) || symbol_in_col?(j + 1, bef, current, aft)

    while i <= j
      return true if symbol?(aft, i) || symbol?(bef, i)

      i += 1
    end

    false
  end

  def self.gear?(line, index)
    return false if line.nil?

    line[index] == '*'
  end

  def self.gear_in_col?(index, line, line_index)
    return [] if line.nil? || index.negative? || index >= line.size

    [line_index, index] if gear?(line, index)
  end

  def self.near_gears(cur, bef, aft, line_indexes, coord)
    gears = []

    bef_index = line_indexes[0]
    cur_index = line_indexes[1]
    aft_index = line_indexes[2]

    i = coord[:start]
    j = coord[:end]

    gears <<
      gear_in_col?(i - 1, bef, bef_index) <<
      gear_in_col?(i - 1, cur, cur_index) <<
      gear_in_col?(i - 1, aft, aft_index)
    gears <<
      gear_in_col?(j + 1, bef, bef_index) <<
      gear_in_col?(j + 1, cur, cur_index) <<
      gear_in_col?(j + 1, aft, aft_index)

    gears.compact!

    while i <= j
      gears << [bef_index, i] if gear?(bef, i)
      gears << [aft_index, i] if gear?(aft, i)

      i += 1
    end

    gears
  end

  def self.ratio(gears_coord)
    gears_coord.each_value.inject(0) do |acc, val|
      val.size == 2 ? acc + val[0] * val[1] : acc
    end
  end

  def self.number_at(line, coor)
    line[coor[:start]..coor[:end]].to_i
  end

  def self.part1(lines)
    nlines = lines.size

    i = 0
    j = 0

    part_numbers = []
    while i < nlines
      line = lines[i]
      n = next_number(line, j)

      if n[:start].nil?
        i += 1
        j = 0
        next
      end

      bef = i.positive? ? lines[i - 1] : nil
      aft = i < lines.size - 1 ? lines[i + 1] : nil
      part_numbers << number_at(line, n) if part_number?(line, bef, aft, n)
      j = n[:end] + 1
    end

    part_numbers.reduce(:+)
  end

  def self.part2(lines)
    nlines = lines.size
    i = 0
    j = 0

    gears_coord = {}

    while i < nlines
      line = lines[i]
      n = next_number(line, j)

      if n[:start].nil?
        i += 1
        j = 0
        next
      end

      bef = i.positive? ? lines[i - 1] : nil
      aft = i < lines.size - 1 ? lines[i + 1] : nil

      coords = near_gears(line, bef, aft, [i - 1, i, i + 1], n)

      coords.each do |g|
        gears_coord["#{g[0]},#{g[1]}"] ||= []
        gears_coord["#{g[0]},#{g[1]}"] << number_at(line, n)
      end

      j = n[:end] + 1
    end

    ratio(gears_coord)
  end
end
