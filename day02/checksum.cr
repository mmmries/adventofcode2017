class Checksum
  def self.sum_of_differences(str)
    spreadsheet = parse_spreadsheet(str)
    spreadsheet.map do |row|
      row.max - row.min
    end.sum
  end

  def self.sum_of_even_divides(str)
    spreadsheet = parse_spreadsheet(str)
    sum = 0
    spreadsheet.each do |row|
      row.each_combination(2) do |(a, b)|
        if a % b == 0
          sum += a / b
        elsif b % a == 0
          sum += b / a
        end
      end
    end
    sum
  end

  def self.parse_spreadsheet(str)
    str.split("\n").reject{|s| s == "" }.map do |row|
      row.split(/\s+/).map{|s| s.to_i }
    end
  end
end
