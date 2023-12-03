#!/usr/bin/env ruby

class String
  def integer?
    to_i.to_s == self
  end
end

module Day01
  def self.first_number(input, string: false)
    digits = %w[one two three four five six seven eight nine]
    input.split('').each_with_index do |char, i|
      return char.to_i if char.integer?

      next unless string

      digits.each_with_index do |digit, j|
        return j + 1 if input[i...i + digit.size] == digit
      end
    end
  end

  def self.last_number(input, string: false)
    digits = %w[one two three four five six seven eight nine]
    (1..input.size).each do |offset|
      curr = input.size - offset
      return input[curr].to_i if input[curr].integer?

      next unless string

      digits.each_with_index do |digit, j|
        return j + 1 if input[curr - digit.size + 1..curr] == digit
      end
    end
  end

  def self.part1(input_lines)
    input_lines.inject(0) do |acc, str|
      acc + (first_number(str) * 10) + last_number(str)
    end
  end

  def self.part2(input_lines)
    input_lines.inject(0) do |acc, str|
      acc + (first_number(str, string: true) * 10) + last_number(str, string: true)
    end
  end
end
