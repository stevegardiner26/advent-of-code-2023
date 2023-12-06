input = File.read('inputs/day1.txt')

# Part 1
nums = []
lines = input.split(/\n/)

lines.each do |l|
  temp = l.scan(/\d/)
  nums << "#{temp[0]}#{temp[-1]}"
end

p nums.map!(&:to_i).sum

# Part 2
nums = []
lines = input.split(/\n/)

number_hash_translation = {one: 1, two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7, eight: 8, nine: 9}
lines.each do |l|
  first = l.match(/\d|one|two|three|four|five|six|seven|eight|nine/)[0]
  first = number_hash_translation[first.to_sym] if first.length > 1
  last = l.reverse.match(/\d|eno|owt|eerht|ruof|evif|xis|neves|thgie|enin/)[0]
  last = number_hash_translation[last.reverse.to_sym] if last.length > 1
  nums << "#{first}#{last}"
end

nums.map!(&:to_i)
puts nums.sum