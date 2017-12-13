require "./garbage"

puts "Part 1 - Total Score of Groups"
str = File.read("input.txt").strip
entries = Parser.parse_groups_and_garbage(str)
puts "\tparsed a total of #{entries.size} root groups"
puts "\ttotal_score = #{entries.reduce(0){|sum, entry| sum + entry.score }}"

puts "Part 2 - Total Garbage Size Cleaned Up"
puts "\ttotal_garbage_size = #{entries.reduce(0){|sum, entry| sum + entry.garbage_size }}"
