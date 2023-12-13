# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/day10/day10'

describe Day10 do
  before do
    @part1_input = File.readlines("#{__dir__}/part1.input", chomp: true)
    @part2_input = File.readlines("#{__dir__}/part2.input_2", chomp: true)
    @part2_input_3 = File.readlines("#{__dir__}/part2.input_3", chomp: true)
    @part1_input2 = File.readlines("#{__dir__}/part1.input_2", chomp: true)
    @puzzle_input = File.readlines("#{__dir__}/puzzle.input", chomp: true)
  end

  describe '#part1' do
    it 'should return the right answer for the test input' do
      expect(Day10.part1(@part1_input)).to equal(4)
      expect(Day10.part1(@part1_input2)).to equal(8)
    end

    it 'should return the right answer for the puzzle input' do
      expect(Day10.part1(@puzzle_input)).to equal(6923)
    end
  end

  describe '#part2' do
    it 'should return the right answer for the test input' do
      expect(Day10.part2(@part2_input)).to equal(4)
      expect(Day10.part2(@part2_input_3)).to equal(8)
    end

    it 'should return the right answer for the puzzle input' do
      expect(Day10.part2(@puzzle_input)).to equal(529)
    end
  end
end
