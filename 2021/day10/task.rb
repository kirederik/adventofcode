#!/usr/bin/env ruby

input_file = File.open("input")
lines = input_file.readlines.map(&:chomp)

def compute(s)
  return 3 if s == ")"
  return 57 if s == "]"
  return 1197 if s == "}"
  return 25137 if s == ">"
end

def b_compute(s)
  return 1 if s == "("
  return 2 if s == "["
  return 3 if s == "{"
  return 4 if s == "<"
end

def match?(o, c)
  (o == "(" && c == ")" ) || ( c.ord - o.ord == 2 )
end

total = 0

corrupted=[]
lines.each do |line|
  s=[]
  line.split("").each do |token|
    if %w[ ( { \[ < ].include? token
      s << token
    else
      op = s.pop
      if !match?(op, token)
        total += compute(token)
        corrupted << line
      end
    end
  end
end
puts total

scores=[]
lines.filter {|l| ! corrupted.include? l }.each do |line|
  s=[]
  line.split("").each do |token|
    if %w[ ( { \[ < ].include? token
      s << token
    else
      s.pop
    end
  end

  sum = 0
  for i in 0...s.size do
    sum = 5 * sum + b_compute(s.pop)
  end

  scores << sum
end

puts scores.sort[scores.size/2]
