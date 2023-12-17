# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/day12/day12'

describe Day12 do
  before do
    @part1_input = File.readlines("#{__dir__}/part1.input", chomp: true)
    @puzzle_input = File.readlines("#{__dir__}/puzzle.input", chomp: true)
  end

  describe '#arrangements' do
    it 'return the possible arrangements' do
      # expect(Day12.arrangements(Day12.parse('???.### 1,1,3'))).to eq(1)
      # expect(Day12.arrangements(Day12.parse('.??..??...?##. 1,1,3')).size).to eq(4)
    end
  end

  describe '#part1' do
    it 'should return the right answer for the test input' do
      expect(Day12.new_part1(@part1_input)).to equal(21)
    end

    it 'should return the right answer for the puzzle input' do
      expect(Day12.new_part1(@puzzle_input)).to equal(7407)
    end
  end

  describe '#part2' do
    it 'should return the right answer for the test input' do
       expect(Day12.new_part2(@part1_input)).to equal(525152)
    end

    it 'should return the right answer for the puzzle input' do
      expect(Day12.new_part2(@puzzle_input)).to equal(30568243604962)
    end
  end

  describe '#find_blocks' do
    it 'returns the blocks' do
      line = %w[? ? ? . # # #]
              # 0 1 2 3 4 5 6
      expect(Day12.find_blocks(line, 1)).to eq(
        [[0, 1], [0, 2], [1, 3]]
      )
      expect(Day12.find_blocks(line, 3)).to eq(
        [[0, 3], [3, 6]]
      )
      line = %w[? . ? ? ? . ?]
      expect(Day12.find_blocks(line, 1)).to eq(
        [[0, 1], [1, 3], [2, 4], [3, 5], [5, 6]]
      )
      line = %w[. # ?]
      expect(Day12.find_blocks(line, 1)).to eq(
        [[0, 2]]
      )
      line = %w[# ? ? # ? ? #]
      expect(Day12.find_blocks(line, 1)).to eq(
        [[0, 1], [2, 4], [5, 6]]
      )
      line = %w[. ? ? ? ? ? #]
      expect(Day12.find_blocks(line, 3)).to eq(
        [[0, 4], [1, 5], [3, 6]]
      )
      line = %w[? ? ? ? . . #]
      expect(Day12.find_blocks(line, 3)).to eq(
        [[0, 3], [0, 4]]
      )
      line = %w[. ? ? . ? ? #]
      expect(Day12.find_blocks(line, 3)).to eq(
        [[3, 6]]
      )
      line = %w[. ? ? ? ? ? #]
      expect(Day12.find_blocks(line, 5)).to eq(
        [[1, 6]]
      )
    end
  end
end
