require "spec"
require "./wacko_jumping"

describe WackoJumping do
  it "counts the steps to exit a set of jump instructions" do
    instructions = [0,3,0,1,-3]
    wacko = WackoJumping.new(instructions)
    wacko.steps_to_exit.should eq 10
    wacko.instructions.should eq [2, 3, 2, 3, -1]
  end
end
