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

lines = input.split(/\n/)
total_sum = 0
lines.each_with_index do |line, index|
  next unless line.match(/\*/)

  indexes = (0 ... line.length).find_all { |i| line[i,1] == '*' }

  indexes.each do |index_of|
    matches = []
    line.enum_for(:scan, /\d+/).each do |match|
      start_i = Regexp.last_match.begin(0)
      end_i = Regexp.last_match.end(0) - 1
      matches << match.to_i if start_i - 1 == index_of || end_i + 1 == index_of
    end

    unless index == 0
      prev_line = lines[index - 1]
      prev_line.enum_for(:scan, /\d+/).each do |match|
        start_i = Regexp.last_match.begin(0)
        end_i = Regexp.last_match.end(0) - 1
        index_range = (index_of == 0 ? index_of : index_of - 1)..(index_of == prev_line.length ? index_of : index_of + 1)
        matches << match.to_i if index_range.include?(start_i) || index_range.include?(end_i)
      end
    end

    unless index == lines.length
      post_line = lines[index + 1]
      post_line.enum_for(:scan, /\d+/).each do |match|
        start_i = Regexp.last_match.begin(0)
        end_i = Regexp.last_match.end(0) - 1
        index_range = (index_of == 0 ? index_of : index_of - 1)..(index_of == prev_line.length ? index_of : index_of + 1)
        matches << match.to_i if index_range.include?(start_i) || index_range.include?(end_i)
      end
    end

    if matches.count == 2
      # Is a gear
      total_sum += matches[0] * matches[1]
    end
  end
end

p total_sum