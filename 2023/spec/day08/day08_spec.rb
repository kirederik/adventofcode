# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/day08/day08'

describe Day08 do
  before do
    @part1_input = File.readlines("#{__dir__}/part1.input", chomp: true)
    @part1_input_2 = File.readlines("#{__dir__}/part1_2.input", chomp: true)
    @part2_input = File.readlines("#{__dir__}/part2.input", chomp: true)
    @puzzle_input = File.readlines("#{__dir__}/puzzle.input", chomp: true)
  end

  describe '#part1' do
    it 'should return the right answer for the test input' do
      expect(Day08.part1(@part1_input)).to equal(2)
      expect(Day08.part1(@part1_input_2)).to equal(6)
    end

    it 'should return the right answer for the puzzle input' do
      expect(Day08.part1(@puzzle_input)).to equal(18_157)
    end
  end
  describe '#part2' do
    it 'should return the right answer for the test input' do
      expect(Day08.part2(@part2_input)).to equal(6)
    end

    it 'should return the right answer for the puzzle input' do
      expect(Day08.part2(@puzzle_input)).to equal(14_299_763_833_181)
    end
  end
end
