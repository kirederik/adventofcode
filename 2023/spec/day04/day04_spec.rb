# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/day04/day04'

describe Day04 do
  before do
    @part1_input = File.readlines("#{__dir__}/part1.input", chomp: true)
    @puzzle_input = File.readlines("#{__dir__}/puzzle.input", chomp: true)
  end

  describe '#parse_input' do
    it 'transforms the input' do
      lines = ['Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53']
      expect(Day04.parse_input(lines)).to eq([
                                               {
                                                 copies: 1,
                                                 card: 1,
                                                 winners: [41, 48, 83,
                                                           86, 17],
                                                 numbers: [83, 86, 6,
                                                           31, 17, 9, 48, 53]
                                               }
                                             ])
    end
  end
  describe '#part1' do
    it 'should return 4361 for the test input' do
      expect(Day04.part1(@part1_input)).to equal(13)
    end

    it 'should return 26346 for the puzzle input' do
      expect(Day04.part1(@puzzle_input)).to equal(26_346)
    end
  end

  describe '#part2' do
    it 'should return 30 for the test input' do
      expect(Day04.part2(@part1_input)).to equal(30)
    end

    it 'should return 8467762 for the puzzle input' do
      expect(Day04.part2(@puzzle_input)).to equal(8_467_762)
    end
  end
end
