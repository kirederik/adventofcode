# frozen_string_literal: true

module Day02
  def self.parse_input(input_str)
    input_str.map do |line|
      game, raw_grabs = line.split(': ')
      id = game.sub('Game ', '')

      rounds = raw_grabs.split('; ').map do |grabs|
        grabs.split(', ').each_with_object({}) do |grab, acc|
          value, color = grab.split(' ')
          acc[color.to_sym] = value.to_i
        end
      end

      { id: id.to_i, grabs: rounds }
    end
  end

  def self.valid?(game, max)
    game[:grabs].filter do |grab|
      grab.keys.filter do |color|
        grab[color] > max[color]
      end.size.positive?
    end.empty?
  end

  def self.min_cubes(game)
    game[:grabs].each_with_object({ red: 0, green: 0, blue: 0 }) do |grab, min|
      grab.each do |color, value|
        min[color] = value if value > min[color]
      end
    end
  end

  def self.power(cubes)
    cubes.map { |_, v| v }.filter(&:positive?).reduce(:*) || 0
  end

  def self.part1(plain_input)
    max = { red: 12, green: 13, blue: 14 }
    games = parse_input(plain_input)

    games.inject(0) do |acc, game|
      valid?(game, max) ? acc + game[:id] : acc
    end
  end

  def self.part2(plain_input)
    games = parse_input(plain_input)
    games.inject(0) do |acc, game|
      acc + power(min_cubes(game))
    end
  end
end
