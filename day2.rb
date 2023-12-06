input = File.read('inputs/day2.txt')
lines = input.split(/\n/)

# Part 1
possible_games_sum = 0
limits = {red: 12, green: 13, blue: 14}
lines.each_with_index do |line, index|
  line_failed = false
  sets = line.split(/;/)
  sets.each do |s|
    colors = s.scan(/(\d+) (\w+)/)
    colors.each do |c|
      if limits[c[1].to_sym] < c[0].to_i
        line_failed = true
      end
    end
  end
  possible_games_sum += (index + 1) unless line_failed
end

puts possible_games_sum

# Part 2
game_power_sum = 0
lines.each_with_index do |line, index|
  limits = {red: 0, green: 0, blue: 0}
  sets = line.split(/;/)
  sets.each do |s|
    colors = s.scan(/(\d+) (\w+)/)
    colors.each do |c|
      if limits[c[1].to_sym] < c[0].to_i
        limits[c[1].to_sym] = c[0].to_i
      end
    end
  end
  game_power_sum += limits[:red] * limits[:green] * limits[:blue]
end

puts game_power_sum
