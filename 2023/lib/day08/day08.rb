# frozen_string_literal: true

module Day08
  def self.parse_input(input)
    instructions = input[0].split('')
    coordinates = input[2..].each_with_object({}) do |s, acc|
      splits = s.split(' = ')
      acc[splits[0]] = splits[1][1..-2].split(', ')
    end
    [instructions, coordinates]
  end

  def self.count(instructions, coordinates, start, target)
    pos = start
    steps = 0
    i = 0

    until pos.end_with?(target)
      steps += 1

      dir = instructions[i] == 'L' ? 0 : 1
      pos = coordinates[pos][dir]

      i = steps % instructions.size
    end
    steps
  end

  def self.part1(input)
    instructions, coordinates = parse_input(input)
    count(instructions, coordinates, 'AAA', 'ZZZ')
  end

  def self.part2(input)
    instructions, coordinates = parse_input(input)
    starts = coordinates.filter { |k, _v| k.end_with?('A') }.map { |k, _v| k }

    starts.map do |start|
      count(instructions, coordinates, start, 'Z')
    end.reduce(1, :lcm)
  end
end
