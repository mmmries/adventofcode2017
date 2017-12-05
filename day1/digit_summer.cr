class DigitSummer
  def self.sum_matching_neighbors(digits)
    digits = digits + [digits[0]]
    sum = 0
    digits.each_cons(2) do |(a, b)|
      sum += a if a == b
    end
    sum
  end

  def self.sum_matching_opposites(digits)
    sum = 0
    half_way_round = digits.size / 2
    digits.each_with_index do |digit, index|
      opposite_index = (index + half_way_round) % digits.size
      sum += digit if digit == digits[opposite_index]
    end
    sum
  end
end
