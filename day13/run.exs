Code.require_file("./firewall.exs")

IO.puts "Part 1 - Severity of going right away"
severity = "./input.txt" |> Firewall.parse |> Firewall.severity_of_traversal
IO.puts "\tseverity = #{severity}"

IO.puts "Part 2 - How long to delay to avoid getting caught?"
delay = "./input.txt" |> Firewall.parse |> Firewall.minimum_delay_to_traverse
IO.puts "\tdelay = #{delay}"
