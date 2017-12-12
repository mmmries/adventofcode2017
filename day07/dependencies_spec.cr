require "spec"
require "./dependencies"

describe Dependencies do
  it "organizes the programs into a dependency tree" do
    tree = Dependencies.parse("test_input.txt")
    root = tree.root
    raise "no root node" if root.nil?
    root.name.should eq "tknk"
    root.weight.should eq 41
    root.children.size.should eq 3

    root.children[0].name.should eq "ugml"
    root.children[0].weight.should eq 68
    root.children[0].children.size.should eq 3
  end
end
