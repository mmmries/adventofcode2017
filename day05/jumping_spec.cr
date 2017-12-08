require "spec"
require "./jumping"

describe Jumping do
  it "counts the steps to exit a set of jump instructions" do
    instructions = [0,3,0,1,-3]
    Jumping.steps_to_exit(instructions).should eq 5
  end
end
