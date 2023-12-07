# frozen_string_literal: true

module Day06
  def self.parse_input(lines)
    [
      lines.first.split(':').last.split.map(&:to_i),
      lines.last.split(':').last.split.map(&:to_i)
    ]
  end

  def self.part1(input)
    time, record = parse_input(input)

    (0...time.size).inject(1) do |acc, j|
      winners = (0..time[j]).inject(0) do |w, i|
        (time[j] - i) * i > record[j] ? w + 1 : w
      end
      winners.positive? ? acc * winners : acc
    end
  end

  def self.find_delta(time, record)
    (0...time).inject(0) do |d, i|
      return d unless (time - i) * i < record

      d + 1
    end
  end

  def self.part2(input)
    time, record = parse_input(input)
    time = time.join.to_i
    record = record.join.to_i

    delta = find_delta(time, record)

    return 0 if delta == time

    1 + time - delta * 2
  end
end
