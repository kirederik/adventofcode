# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/day11/day11'

describe Day11 do
  before do
    @part1_input = File.readlines("#{__dir__}/part1.input", chomp: true)
    @puzzle_input = File.readlines("#{__dir__}/puzzle.input", chomp: true)
  end

  describe '#part1' do
    it 'should return the right answer for the test input' do
      expect(Day11.part1(@part1_input)).to equal(374)
    end

    it 'should return the right answer for the puzzle input' do
      expect(Day11.part1(@puzzle_input)).to equal(9_543_156)
    end
  end

  describe '#part2' do
    it 'should return the right answer for the test input' do
      expect(Day11.part2(@part1_input, 2)).to equal(374)
      expect(Day11.part2(@part1_input, 10)).to equal(1030)
      expect(Day11.part2(@part1_input, 100)).to equal(8410)
    end

    it 'should return the right answer for the puzzle input' do
      expect(Day11.part2(@puzzle_input, 2)).to equal(9_543_156)
      expect(Day11.part2(@puzzle_input, 1_000_000)).to equal(625_243_292_686)
    end
  end
end
