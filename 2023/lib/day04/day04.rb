# frozen_string_literal: true

module Day04
  def self.parse_input(lines)
    lines.map do |line|
      game, numbers = line.split(': ')
      winners, pick = numbers.split(' | ')

      {
        copies: 1,
        card: game.sub('Card ', '').to_i,
        winners: winners.split(' ').map(&:to_i),
        numbers: pick.split(' ').map(&:to_i)
      }
    end
  end

  def self.card_points(card)
    card[:numbers].inject(-1) do |power, n|
      card[:winners].include?(n) ? power + 1 : power
    end
  end

  def self.part1(lines)
    input = parse_input(lines)
    input.inject(0) do |sum, card|
      power = card_points(card)
      power.negative? ? sum : sum + 2**power
    end
  end

  def self.part2(lines)
    input = parse_input(lines)
    input.each_with_index do |card, index|
      points = card_points(card)
      next if points.negative?

      (index + 1..index + points + 1).each do |cindex|
        input[cindex][:copies] += 1 * card[:copies]
      end
    end

    input.inject(0) do |total, card|
      total + card[:copies]
    end
  end
end
