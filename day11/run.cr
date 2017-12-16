require "./grid"

puts "Part 1 - Follow a Path, Find Shortest Distance"
directions = File.read("./input.txt").strip.split(",")
node = Node.follow(directions)
puts "\tended on #{node.a},#{node.b},#{node.c} => #{node.distance_from_origin}"

puts "Part 2 - how far away do you get along the path?"
furthest = 0
directions.reduce(Node.new(0,0,0)) do |node, direction|
  node = node.move(direction)
  distance = node.distance_from_origin
  furthest = distance if distance > furthest
  node
end
puts "\tfurthest we got was #{furthest} steps"
