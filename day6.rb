input = File.read('inputs/day6.txt')
lines = input.split(/\n/)

# Part 1
times = lines[0].scan(/\d+/).map(&:to_i)
record_distances = lines[1].scan(/\d+/).map(&:to_i)

total = 1
times.each_with_index do |time, index|
  winning_times = []
  time.times do |i|
    calculated_distance = ((time-i) * i)
    winning_times << i if calculated_distance > record_distances[index]
  end
  min_max = winning_times.minmax
  diff = (min_max[1] - min_max[0]) + 1 # must be inclusive to the min
  total *= diff
end

p total

# Part 2
time = lines[0].scan(/\d+/).join('').to_i
record_distance = lines[1].scan(/\d+/).join('').to_i

winning_times = []
time.times do |i|
  calculated_distance = ((time-i) * i)
  if calculated_distance > record_distance
    winning_times << i
    break
  end
end

time.downto(1) do |i|
  calculated_distance = ((time-i) * i)
  if calculated_distance > record_distance
    winning_times << i
    break
  end
end

min_max = winning_times.minmax
diff = (min_max[1] - min_max[0]) + 1 # must be inclusive to the min

p diff