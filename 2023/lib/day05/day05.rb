# frozen_string_literal: true

module Day05
  def self.parse_map(map_str)
    map_str.split("\n").map { |line| line.split.map(&:to_i) }
           .to_h do |dest_start, src_start, length|
             [src_start...(src_start + length), dest_start]
           end
  end

  def self.find_in_map(maps, value)
    maps.reduce(value) do |val, map|
      range = map.keys.find { |r| r.include?(val) }
      range ? map[range] + (val - range.begin) : val
    end
  end

  def self.part1(input)
    sections = input.split("\n\n").reject(&:empty?)

    seeds = sections[0].split(':')[1].split.map(&:to_i)

    maps = sections[1..].map { |section| parse_map(section.split(":\n")[1]) }
    seeds.map { |seed| find_in_map(maps, seed) }.min
  end
end

module Day052
  def self.parse_input(input)
    input.split("\n\n").map do |section|
      section.lines.drop(1).map { |line| line.split.map(&:to_i) }
             .sort { |a, b| a[1] <=> b[1] }
    end
  end

  def self.diff(a, b)
    [
      a.begin < b.begin ? (a.begin...a.begin + (b.begin - a.begin)) : nil,
      a.end > b.end ? (b.end...b.end + (a.end - b.end)) : nil
    ].compact
  end

  def self.intersect(a, b)
    ([a.begin, b.begin].max...[a.end, b.end].min)
  end

  def self.ranges(dst_range_start, src_range_start, range_len)
    [
      (src_range_start...src_range_start + range_len),
      (dst_range_start...dst_range_start + range_len)
    ]
  end

  def self.map_ranges(map, unmapped_ranges)
    mapped_ranges = []

    map.each do |m|
      src_range, dst_range = ranges(*m)

      rest = []
      unmapped_ranges.each do |unmapped_range|
        intersection = intersect(unmapped_range, src_range)

        rest << unmapped_range && next unless intersection.size.positive?

        start = intersection.begin - src_range.begin + dst_range.begin
        mapped_ranges << (start...start + intersection.size)
        rest += diff(unmapped_range, src_range)
      end
      unmapped_ranges = rest
    end

    mapped_ranges + unmapped_ranges
  end

  def self.part2(lines)
    stages = parse_input(lines)

    seed_line = lines.split("\n").first.split(': ').last.split
    seeds = seed_line.map(&:to_i).each_slice(2).map { |v| (v[0]...v[0] + v[1]) }

    result = stages[1..].inject(seeds) do |acc, r|
      map_ranges(r, acc)
    end
    result.map(&:begin).min
  end
end
