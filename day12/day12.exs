Code.require_file "./pipes.exs"

IO.puts "Part 1 - How many programs are in the same group as program 0"
size = "./input.txt" |> Pipes.parse |> Pipes.cohort("0") |> MapSet.size
IO.puts "\tthere are #{size} programs in the group with program 0"

IO.puts "Par 2 - Count the groups"
group_count = "./input.txt" |> Pipes.parse |> Pipes.count_groups
IO.puts "\tthere are #{group_count} groups"
