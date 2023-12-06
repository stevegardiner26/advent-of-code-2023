input = File.read('inputs/day3.txt')
lines = input.split(/\n/)

# Part 1

part_num_sum = 0
lines.each_with_index do |line, index|
  post_sym_loc = []
  prev_sym_loc = []
  unless index == 0
    prev_sym_loc = []
    lines[index - 1].split("").each_with_index do |i, idx|
      prev_sym_loc << idx if i.match(/[^.\d]/)
    end
  end
  unless index == lines.length - 1

    post_sym_loc = []
    lines[index + 1].split("").each_with_index do |i, idx|
      post_sym_loc << idx if i.match(/[^.\d]/)
    end
  end

  nums = []
  line.enum_for(:scan, /\d+/).map do |match|
    match_data = Regexp.last_match
    start_index = match_data.begin(0)
    end_index = match_data.end(0) - 1 # Subtract 1 because end(0) returns the index after the end of the match
    nums << [start_index, end_index]
  end

  nums.each do |n|
    before_idx = n[0] == 0 ? n[0] : n[0] - 1
    after_idx = line.length - 1 == n[1] ? n[1] : n[1] + 1
    before = line[before_idx].match(/[^.\d]/)
    after = line[after_idx].match(/[^.\d]/)
    prev_match = prev_sym_loc.any? { |item| (before_idx..after_idx).include?(item) }
    post_match = post_sym_loc.any? { |item| (before_idx..after_idx).include?(item) }

    part_num_sum += line[n[0]..n[1]].to_i if after || before || post_match || prev_match
  end
end

puts part_num_sum

# Part 2

# Reverse the search to look for * instead of digits and then search for digits in prev and post to confirm. Then take proper gear calculations. *BUT WE NEED THE DIGIT INDEXES TO GET THE NUM*