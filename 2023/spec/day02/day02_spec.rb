# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/day02/day02'

describe Day02 do
  describe '#parseInput' do
    it 'returns the input correctly parsed' do
      fake_line = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green\nGame 2: 1 blue".split("\n")
      parsed_input = Day02.parse_input(fake_line)
      expect(parsed_input).to eq([{
                                   id: 1,
                                   grabs: [
                                     { blue: 3, red: 4 },
                                     { blue: 6, red: 1, green: 2 },
                                     { green: 2 }
                                   ]
                                 }, {
                                   id: 2,
                                   grabs: [
                                     { blue: 1 }
                                   ]
                                 }])
    end
  end

  describe '#is_valid?' do
    before do
      @max = { red: 12, green: 13, blue: 14 }
    end

    it 'returns true if the game is valid' do
      game = { id: 1, grabs: [{ red: 4, green: 4 }, { blue: 14, green: 13, red: 12 }] }

      expect(Day02.valid?(game, @max)).to be_truthy
    end

    fit 'returns false if the game is not valid' do
      game = { id: 1, grabs: [{ red: 4, green: 4 }, { blue: 15, green: 13, red: 12 }] }

      expect(Day02.valid?(game, @max)).to be_falsey
    end
  end

  describe '#min_cubes' do
    it 'returns the min number of cubes to make the game valid' do
      game = { id: 1, grabs: [{ red: 12, green: 4 }, { blue: 14, green: 13, red: 2 }] }
      expect(Day02.min_cubes(game)).to eq({ red: 12, green: 13, blue: 14 })
    end
  end

  describe '#power' do
    it 'returns the multiplication of the values' do
      v = { red: 4, green: 2, blue: 6 }
      expect(Day02.power(v)).to eq(48)
    end

    it 'treats 0 values correctly' do
      v = { red: 4, green: 2, blue: 0 }
      expect(Day02.power(v)).to eq(8)
    end

    it 'returns 0 for an empty basked' do
      v = { red: 0, green: 0, blue: 0 }
      expect(Day02.power(v)).to eq(0)
    end
  end

  describe 'puzzle parts' do
    before do
      @part1_input = File.readlines("#{__dir__}/part1.input", chomp: true)
      @puzzle_input = File.readlines("#{__dir__}/puzzle.input", chomp: true)
    end

    describe '#part1' do
      it 'should return 8 for the test input' do
        expect(Day02.part1(@part1_input)).to equal(8)
      end

      it 'should return 2276 for the puzzle input' do
        expect(Day02.part1(@puzzle_input)).to equal(2776)
      end
    end

    describe '#part2' do
      it 'should return 2286 for the test input' do
        expect(Day02.part2(@part1_input)).to equal(2286)
      end

      it 'should return 2286 for the puzzle input' do
        expect(Day02.part2(@puzzle_input)).to equal(68_638)
      end
    end
  end
end
