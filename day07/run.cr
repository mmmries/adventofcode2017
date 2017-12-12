require "./dependencies"

tree = Dependencies.parse("./input.txt")
root = tree.root
raise "no root found" if root.nil?
puts "Part 1 - What is the root of the tree?"
puts "\t#{root.name} (#{root.weight})"
