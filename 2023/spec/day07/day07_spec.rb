# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/day07/day07'

describe Day07 do
  before do
    @part1_input = File.readlines("#{__dir__}/part1.input", chomp: true)
    @puzzle_input = File.readlines("#{__dir__}/puzzle.input", chomp: true)
  end

  describe '#parse_input' do
    it 'transforms the input' do
      expect(Day07.parse_input(@part1_input)[0]).to eq([765, %w[3 2 T 3 K]])
    end
  end

  describe '#part1' do
    it 'should return the right answer for the test input' do
      expect(Day07.part1(@part1_input)).to equal(6440)
    end

    it 'should return the right answer for the puzzle input' do
      expect(Day07.part1(@puzzle_input)).to equal(249_726_565)
    end
  end

  describe '#part2' do
    it 'should return the right answer for the test input' do
      expect(Day07.part2(@part1_input)).to equal(5905)
    end

    it 'should return the right answer for the puzzle input' do
      expect(Day07.part2(@puzzle_input)).to equal(251_135_960)
    end
  end
end
