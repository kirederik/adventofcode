# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/day09/day09'

describe Day09 do
  before do
    @part1_input = File.readlines("#{__dir__}/part1.input", chomp: true)
    @puzzle_input = File.readlines("#{__dir__}/puzzle.input", chomp: true)
  end

  describe '#part1' do
    it 'should return the right answer for the test input' do
      expect(Day09.part1(@part1_input)).to equal(114)
    end

    it 'should return the right answer for the puzzle input' do
      expect(Day09.part1(@puzzle_input)).to equal(1_581_679_977)
    end
  end

  describe '#part2' do
    it 'should return the right answer for the test input' do
      expect(Day09.part2(@part1_input)).to equal(2)
    end

    it 'should return the right answer for the puzzle input' do
      expect(Day09.part2(@puzzle_input)).to equal(889)
    end
  end
end
