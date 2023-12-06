input = File.read('inputs/day4.txt')
lines = input.split(/\n/)

# Part 1
grand_sum = 0
lines.each do |line|
  pot, mine = line.split(/\|/)
  pot_numbers = pot.scan(/\d+/).map(&:to_i).slice(1..-1)
  my_numbers =  mine.scan(/\d+/).map(&:to_i)
  matches = 0
  line_total = 0
  my_numbers.each do |my_num|
    if pot_numbers.include?(my_num)
      matches += 1
    end
  end
  if matches == 1
    line_total = 1
  elsif matches == 0
    line_total = 0
  else
    line_total = 2 ** (matches - 1)
  end
  grand_sum += line_total
end

p grand_sum

# Part 2
