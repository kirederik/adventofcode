# frozen_string_literal: true

module Day12
  def self.unfold(line, m)
    springs, conditions = line.split(' ')
    springs = ("#{springs}?" * m)[0...-1].split('')
    conditions = ("#{conditions}," * m)[0...-1].split(',').map(&:to_i)
    [
      springs,
      conditions
    ]
  end

  def self.parse(line)
    springs, conditions = line.split(' ')
    springs = springs.split('')
    conditions = conditions.split(',').map(&:to_i)

    [springs, conditions]
  end

  def self.find_blocks(line, size)
    blocks = []

    b = line[0..size]
    if b.last != '#'
      blocks << [0, size] unless line[0..size-1].include?('.')
    end

    line.each_cons(size + 2).each_with_index do |block, index|
      first = block.first
      last = block.last
      between = block[1..size]
      next if between.include?('.')
      blocks << [index, index+size+1] unless [first, last].include?('#')
    end

    last = line[line.size-size-1..]
    block = line[line.size-size..]
    if last.first != '#'
      blocks << [line.size-size-1, line.size-1] unless block.include?('.')
    end

    blocks
  end

  @cache = {}
  def self.search_from(line, blocks, li, bi, comb)
    if bi >= blocks.size
      return 1
    end

    if @cache.dig(bi, li)
      return @cache.dig(bi, li)
    end

    curr_block = blocks[bi]
    last_block = bi == blocks.size-1

    hash_found = nil
    valid = 0
    comb[curr_block].each_with_index do |c, ci|
      i, j = c
      next if i < li

      prev = line[li..i]
      target = line[i..j]
      remaining = line[j+1..]

      unless hash_found.nil? || hash_found.between?(i, j)
        break
      end

      if prev.include?('#') && li != i
        break
      end

      target_hash_index = target.index('#')
      remaining_target_index = remaining.index('#')

      unless target_hash_index.nil?
        hash_found = i + target_hash_index
      end

      if last_block && target_hash_index && remaining_target_index
        next_comb = comb[curr_block][ci+1]
        break unless next_comb || remaining_target_index < j
        next
      end

      next if last_block && remaining_target_index
      v = search_from(line, blocks, j, bi+1, comb)
      valid += v
    end

    @cache[bi] ||= {}
    @cache[bi][li] = valid

    return valid
  end

  def self.arrangements(line, blocks)
    comb = {}
    blocks.each do |b|
      next unless comb[b].nil?
      comb[b] = find_blocks(line, b)
    end

    search_from(line, blocks, 0, 0, comb)
  end

  def self.calculate(input, folds)
    input.inject(0) do |sum, line|
      s, c = unfold(line, folds)
      @cache = {}
      sum + arrangements(s, c)
    end
  end

  def self.new_part2(input)
    calculate(input, 5)
  end

  def self.new_part1(input)
    calculate(input, 1)
  end
end
