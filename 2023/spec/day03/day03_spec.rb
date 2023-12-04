# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/day03/day03'

describe Day03 do
  describe '#next_number' do
    it 'returns the next number position in a line' do
      n = '123..34...'
      expect(Day03.next_number(n, 0)).to eq({ start: 0, end: 2 })
      expect(Day03.next_number(n, 3)).to eq({ start: 5, end: 6 })
      expect(Day03.next_number('..3', 2)).to eq({ start: 2, end: 2 })
      expect(Day03.next_number('....', 0)).to eq({ start: nil, end: nil })
    end
  end

  describe '#part_number?' do
    it 'returns whether the number is a part number' do
      l1 = '............'
      l2 = '123..34...#3'
      l3 = '.#...3......'

      expect(Day03.part_number?(l2, l1, l3, { start: 0, end: 2 })).to be_truthy
      expect(Day03.part_number?(l2, l1, l3, { start: 5, end: 6 })).to be_falsey
      expect(Day03.part_number?(l2, l1, l3, { start: 11, end: 11 })).to be_truthy
    end
  end

  describe '#near_gears' do
    it 'returns the gear position' do
      l1 = '.*.'
      l2 = '*3*'
      l3 = '.*.'

      expect(Day03.near_gears(l2, l1, l3, [1, 2, 3],
                              { start: 1, end: 1 })).to match_array([[1, 1], [2, 0], [2, 2], [3, 1]])
    end
  end

  describe 'puzzle parts' do
    before do
      @part1_input = File.readlines("#{__dir__}/part1.input", chomp: true)
      @puzzle_input = File.readlines("#{__dir__}/puzzle.input", chomp: true)
    end

    describe '#part1' do
      it 'should return 4361 for the test input' do
        expect(Day03.part1(@part1_input)).to equal(4361)
      end

      it 'should return 532445 for the puzzle input' do
        expect(Day03.part1(@puzzle_input)).to equal(532_445)
      end
    end

    describe '#part2' do
      it 'should return 467835 for the test input' do
        expect(Day03.part2(@part1_input)).to equal(467_835)
      end

      it 'should return 532445 for the puzzle input' do
        expect(Day03.part2(@puzzle_input)).to equal(79_842_967)
      end
    end
  end
end
