# frozen_string_literal: true

module Day07
  def self.parse_input(input)
    input.map do |g|
      cards, bid = g.split(' ')
      [bid.to_i, cards.split('')]
    end
  end

  def self.pairs(card_count)
    card_count.filter { |_k, v| v == 2 }.size
  end

  def self.five_kind(card_count, joker)
    return card_count.keys.size == 1 unless joker

    js = card_count['J'] || 0
    card_count.any? { |_k, v| v == 5 || v + js == 5 }
  end

  def self.four_kind(card_count, joker)
    return card_count.any? { |_k, v| v == 4 } unless joker

    js = card_count.delete('J') || 0
    card_count.any? { |_k, v| v + js == 4 }
  end

  def self.full_house(card_count, joker)
    return card_count.map { |_k, v| v }.uniq.sort == [2, 3] unless joker

    p = pairs(card_count)
    card_count.map { |_k, v| v }.uniq.sort == [2, 3] ||
      p == 2 && ((card_count['J'] || 0) >= 1)
  end

  def self.three_kind(card_count, joker)
    return card_count.any? { |_k, v| v == 3 } unless joker

    js = card_count.delete('J') || 0
    card_count.any? { |_k, v| v + js == 3 }
  end

  def self.two_pair(card_count, joker)
    p = pairs(card_count)
    return p == 2 unless joker

    p == 2 || p == 1 && (card_count['J'] || 0) == 1
  end

  def self.one_pair(card_count, joker)
    p = pairs(card_count)
    return p == 1 unless joker

    p == 1 || (card_count['J'] || 0) == 1
  end

  def self.high_card(_card_count, _joker)
    true
  end

  def self.count(cards)
    cards.each_with_object({}) do |card, acc|
      acc[card] = (acc[card] || 0) + 1
      acc
    end
  end

  def self.by_type(games, joker: false)
    game_types = %i[five_kind four_kind full_house three_kind two_pair one_pair high_card]

    sorted_types = {}

    games.sort_by do |game|
      cards = game[1]
      game_types.each do |type|
        next unless send(type, count(cards), joker)

        (sorted_types[type] ||= []) << game
        break
      end
    end

    sorted_types
  end

  def self.hand_value(cards, value_map)
    cards.inject(0) do |acc, card|
      (acc * 100) + (value_map[card] || card.to_i)
    end
  end

  def self.by_strength(games, value_map)
    return [] if games.nil?

    games.sort_by { |e| hand_value(e[1], value_map) }
  end

  def self.calc_earnings(games, value_map)
    game_types = %i[five_kind four_kind full_house three_kind two_pair one_pair high_card]

    rank = 0
    game_types.reverse.inject(0) do |earnings, type|
      earnings + by_strength(games[type], value_map).inject(0) do |earns, game|
        earns + (rank += 1) * game[0]
      end
    end
  end

  def self.part1(input)
    value_map = { 'A' => 14, 'K' => 13, 'Q' => 12, 'J' => 11, 'T' => 10 }

    games = parse_input(input)
    calc_earnings(by_type(games), value_map)
  end

  def self.part2(input)
    value_map = { 'A' => 13, 'K' => 12, 'Q' => 11, 'J' => 1, 'T' => 10 }

    games = Day07.parse_input(input)
    calc_earnings(by_type(games, joker: true), value_map)
  end
end
