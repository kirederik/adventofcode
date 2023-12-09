# frozen_string_literal: true

module Day09
  def self.find_diffs(values)
    diffs = [values]

    loop do
      all_zeros = true
      diff = []
      i = 0

      while i + 1 < diffs.last.size
        d = diffs.last[i + 1] - diffs.last[i]

        all_zeros = false unless d.zero?

        diff << d
        i += 1
      end

      diffs << diff

      break if all_zeros
    end

    diffs
  end

  def self.predict_start(values)
    predicted = []
    i = 0
    last_predicted = 0
    while i + 1 < values.size
      y = values[i + 1]

      current_predicted = -1 * (last_predicted - y)
      predicted << current_predicted
      last_predicted = current_predicted

      i += 1
    end

    predicted
  end

  def self.part1(input)
    input.reduce(0) do |acc, val|
      parsed_input = val.split(' ').map(&:to_i)
      acc + find_diffs(parsed_input).reverse.map(&:last).reduce(&:+)
    end
  end

  def self.part2(input)
    input.reduce(0) do |acc, val|
      parsed_input = val.split(' ').map(&:to_i)
      first = find_diffs(parsed_input).reverse.map(&:first)

      acc + predict_start(first).last
    end
  end
end
