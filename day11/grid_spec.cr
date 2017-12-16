require "spec"
require "./grid"

describe Node do
  {
    "n" => {a: 1, b: -1, c: 0},
    "ne" => {a: 1, b: 0, c: -1},
    "se" => {a: 0, b: 1, c: -1},
    "s" => {a: -1, b: 1, c: 0},
    "sw" => {a: -1, b: 0, c: 1},
    "nw" => {a: 0, b: -1, c: 1},
  }.each do |direction, diff|
    it "can move #{direction}" do
      node = Node.new(0, 0, 0)
      node = node.move(direction)
      node.a.should eq diff[:a]
      node.b.should eq diff[:b]
      node.c.should eq diff[:c]
    end
  end

  it "can follow a path" do
    node = Node.new(0,0,0).move("n").move("n").move("se").move("s")
    node.should eq Node.new(1, 0, -1)
  end

  it "can follow an arbitrary path" do
    node = Node.follow(["ne","ne","ne"])
    node.distance_from_origin.should eq 3
    node = Node.follow(["ne","ne","sw","sw"])
    node.distance_from_origin.should eq 0
    node = Node.follow(["ne","ne","s","s"])
    node.distance_from_origin.should eq 2
    node = Node.follow(["se","sw","se","sw","sw"])
    node.distance_from_origin.should eq 3
  end

  it "knows the distance to any node" do
    node = Node.new(3,-2,-1)
    node.distance_from_origin.should eq 3
    node = Node.new(2,2,-4)
    node.distance_from_origin.should eq 4
  end
end
