require "./digit_summer"
if ARGV.size != 1
  puts "Error: please provide a string of digits"
  exit(1)
end

str = ARGV.first
digits = str.split("").map{|s| s.to_i}
p digits
