require "./jumping"
require "./wacko_jumping"

instructions = File.read("input.txt").split("\n").reject{|s| s == ""}.map{|s| s.to_i }
puts "Part 1 - Steps to Jump Out"
puts "\t#{Jumping.steps_to_exit(instructions)}"

instructions = File.read("input.txt").split("\n").reject{|s| s == ""}.map{|s| s.to_i }
puts "Part 2 - Steps to Jump Out with Wacko Jumping Rules"
puts "\t#{WackoJumping.steps_to_exit(instructions)}"
