# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/day06/day06'

describe Day06 do
  before do
    @part1_input = File.readlines("#{__dir__}/part1.input", chomp: true)
    @puzzle_input = File.readlines("#{__dir__}/puzzle.input", chomp: true)
  end

  describe '#parse_input' do
    it 'transforms the input' do
      expect(Day06.parse_input(@part1_input)).to eq([[7, 15, 30], [9, 40, 200]])
    end
  end

  describe '#part1' do
    it 'should return 288 for the test input' do
      expect(Day06.part1(@part1_input)).to equal(288)
    end

    it 'should return 1660968 for the puzzle input' do
      expect(Day06.part1(@puzzle_input)).to equal(1_660_968)
    end
  end
  describe '#part1' do
    it 'should return 71503 for the test input' do
      expect(Day06.part2(@part1_input)).to equal(71_503)
    end

    it 'should return 26499773 for the puzzle input' do
      expect(Day06.part2(@puzzle_input)).to equal(26_499_773)
    end
  end
end
