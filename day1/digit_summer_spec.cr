require "spec"
require "./digit_summer"

describe DigitSummer do
  it "filters to only consider matching digits" do
    DigitSummer.sum_matching([1,1,2,2]).should eq 3
    DigitSummer.sum_matching([1,1,1,1]).should eq 4
    DigitSummer.sum_matching([1,2,3,4]).should eq 0
    DigitSummer.sum_matching([9,1,2,1,2,1,2,9]).should eq 9
  end
end
