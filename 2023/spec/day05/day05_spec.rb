# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/day05/day05'

describe Day05 do
  before do
    @part1_input = File.read("#{__dir__}/part1.input")
    @puzzle_input = File.read("#{__dir__}/puzzle.input")
  end

  describe '#part1' do
    it 'should return 4361 for the test input' do
      expect(Day05.part1(@part1_input)).to equal(35)
    end

    it 'should return 26346 for the puzzle input' do
      expect(Day05.part1(@puzzle_input)).to equal(178_159_714)
    end
  end
end

describe Day052 do
  describe '#part2' do
    it 'should return 30 for the test input' do
      @part1_input = File.read("#{__dir__}/part1.input")
      expect(Day052.part2(@part1_input)).to equal(46)
    end

    it 'should return 8467762 for the puzzle input' do
      @puzzle_input = File.read("#{__dir__}/puzzle.input")
      expect(Day052.part2(@puzzle_input)).to equal(100_165_128)
    end
  end
end
