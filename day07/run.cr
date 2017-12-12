require "./dependencies"

tree = Dependencies.parse("./input.txt")
root = tree.root
puts "Part 1 - What is the root of the tree?"
puts "\t#{root.name} (#{root.weight})"
puts "Part 2 - Imbalanced"
tree.imbalanced_nodes.each do |node|
  puts "Imbalanced #{node.name}"
  node.children.each do |child|
    puts "\t#{child.name} (#{child.weight} / #{child.total_weight})"
  end
end
