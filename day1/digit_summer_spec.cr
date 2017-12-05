require "spec"
require "./digit_summer"

describe DigitSummer do
  it "sums matching neighbor digits" do
    DigitSummer.sum_matching_neighbors([1,1,2,2]).should eq 3
    DigitSummer.sum_matching_neighbors([1,1,1,1]).should eq 4
    DigitSummer.sum_matching_neighbors([1,2,3,4]).should eq 0
    DigitSummer.sum_matching_neighbors([9,1,2,1,2,1,2,9]).should eq 9
  end

  it "sums matching opposites" do
    DigitSummer.sum_matching_opposites([1,2,1,2]).should eq 6
    DigitSummer.sum_matching_opposites([1,2,2,1]).should eq 0
    DigitSummer.sum_matching_opposites([1,2,3,4,2,5]).should eq 4
    DigitSummer.sum_matching_opposites([1,2,3,1,2,3]).should eq 12
    DigitSummer.sum_matching_opposites([1,2,1,3,1,4,1,5]).should eq 4
  end
end
