require "spec"
require "./dependencies"

describe Dependencies do
  it "organizes the programs into a dependency tree" do
    tree = Dependencies.parse("test_input.txt")
    root = tree.root
    root.name.should eq "tknk"
    root.weight.should eq 41
    root.children.size.should eq 3

    root.children[0].name.should eq "ugml"
    root.children[0].weight.should eq 68
    root.children[0].children.size.should eq 3
  end

  it "knows the total_weight of each node" do
    tree = Dependencies.parse("test_input.txt")
    tree.root.weight.should eq 41
    tree.root.total_weight.should eq 778

    tree.root.children[0].weight.should eq 68
    tree.root.children[0].total_weight.should eq 251
  end

  it "knows the total_weight of each node" do
    tree = Dependencies.parse("test_input.txt")
    tree.root.imbalanced?.should eq true
    tree.root.children[0].imbalanced?.should eq false
    tree.root.children[1].imbalanced?.should eq false
    tree.root.children[2].imbalanced?.should eq false
  end

  it "knows how to find imbalanced nodes" do
    tree = Dependencies.parse("test_input.txt")
    imbalanced = tree.imbalanced_nodes
    imbalanced.size.should eq 1
    imbalanced[0].should eq tree.root
  end
end
