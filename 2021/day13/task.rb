#!/usr/bin/env ruby
def print_paper(paper)
  paper.each do |p|
    puts p.join('')
  end
end

def merge(a, b)
  return '#' if a == '#' || b == '#'
  '.'
end

def count(paper, target)
  paper.inject(0) do |total, rows|
    total + rows.inject(0) do |sum, v|
      v == '#' ? sum + 1 : sum
    end
  end
end

def fold(paper, fold)
  coor, pivot = fold.split(' ').last.split('=')

  pivot = pivot.to_i
  if coor == 'x'
    # vertical fold
    cols = paper[0].size
    rows = paper.size
    left = pivot - 1
    right = pivot + 1
    while left >= 0 && right <= cols
      for r in 0...rows
        paper[r][left] = merge(paper[r][left], paper[r][right])
        paper[r][right] = '.'
      end
      left -= 1
      right += 1
    end
    new_paper = []
    for i in 0...rows
      new_paper << []
      for j in 0..pivot
        new_paper[i][j] = paper[i][j]
      end
    end
    new_paper
  else
    # horizontal fold
    limit = paper.size
    above = pivot - 1
    below = pivot + 1
    while above >= 0 && below <= limit
      paper[above].each_with_index do |v, i|
        paper[above][i] = merge(paper[below][i], paper[above][i])
      end
      above -= 1
      below += 1
    end
    paper[0...pivot]
  end
end

lines = []
input_file = File.open('input') do |f|
  lines = f.readlines.map(&:chomp)
end

points = []
folds = []
max_x, max_y = [-1, -1]
folding = false
lines.each do |line|
  folding = true if line.empty?
  if folding
    folds << line unless line.empty?
  else
    x,y = line.split(',').map(&:to_i)
    max_x = x if x > max_x
    max_y = y if y > max_y
    points << [x,y]
  end
end

paper = []
for y in 0..max_y
  paper[y] ||= []
  for x in 0..max_x
    paper[y][x] = '.'
  end
end

points.each do |p|
  x,y = p
  paper[y][x]= '#'
end

paper_2 = fold(paper, folds.first)
puts count(paper_2, '#')

folds.each do |fold|
  paper = fold(paper, fold)
end

print_paper(paper)
