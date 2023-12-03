# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/day01/day01'

describe Day01 do
  describe '#first_number' do
    it 'returns the first number on the string', focus: true do
      expect(Day01.first_number('1asdfghjjl')).to eq(1)
      expect(Day01.first_number('asdfg21jjl')).to eq(2)
      expect(Day01.first_number('asdfgjjll3')).to eq(3)
      expect(Day01.first_number('bbboneight32oneightbbb', string: false)).to eq(3)
      expect(Day01.first_number('bbboneigh32oneightbbb', string: true)).to eq(1)
    end
  end

  describe '#last_number' do
    it 'returns the last number on the string' do
      expect(Day01.last_number('1asdfghjjl')).to eq(1)
      expect(Day01.last_number('asdfg21jjl')).to eq(1)
      expect(Day01.last_number('asdfgjjll3')).to eq(3)
      expect(Day01.last_number('bbboneight32oneightbbb', string: false)).to eq(2)
      expect(Day01.last_number('bbboneight2oneightbbb', string: true)).to eq(8)
      expect(Day01.last_number('two1nine', string: true)).to eq(9)
    end
  end

  describe 'puzzle parts' do
    before do
      @part1_input = File.readlines("#{__dir__}/part1.input", chomp: true)
      @part2_input = File.readlines("#{__dir__}/part2.input", chomp: true)
      @puzzle_input = File.readlines("#{__dir__}/puzzle.input", chomp: true)
    end

    describe '#part1' do
      it 'should return 142 for the test input' do
        expect(Day01.part1(@part1_input)).to equal(142)
      end

      it 'should return 55447 for the puzzle input' do
        expect(Day01.part1(@puzzle_input)).to equal(55_447)
      end
    end

    describe '#part2' do
      it 'should return 281 for the test input' do
        expect(Day01.part2(@part2_input)).to equal(281)
      end

      it 'should return 54706 for the puzzle input' do
        expect(Day01.part2(@puzzle_input)).to equal(54_706)
      end
    end
  end
end
