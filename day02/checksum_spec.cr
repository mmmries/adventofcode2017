require "spec"
require "./checksum"

describe Checksum do
  it "computes the checksum based on the sum of differences" do
    spreadsheet = "5 1 9 5\n7 5 3\n2 4 6 8\n"
    Checksum.sum_of_differences(spreadsheet).should eq 18
  end

  it "handles extra whitespace" do
    spreadsheet = "5 1 9 5\n7    5 3\n2 4\t6 8\n"
    Checksum.sum_of_differences(spreadsheet).should eq 18
  end

  it "computes the checksum based on evenly divisible pairs" do
    spreadsheet = <<-SHEET
                  5 9 2 8
                  9 4 7 3
                  3 8 6 5
                  SHEET
    Checksum.sum_of_even_divides(spreadsheet).should eq 9
  end
end
