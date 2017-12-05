class DigitSummer
  def self.sum_matching(digits)
    digits = digits + [digits[0]]
    sum = 0
    digits.each_cons(2) do |(a, b)|
      sum += a if a == b
    end
    sum
  end
end
