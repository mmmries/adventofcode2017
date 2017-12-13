require "spec"
require "./garbage"

describe Parser do
  it "can parse basic garbage" do
    entries = Parser.parse_groups_and_garbage("<>")
    garbage = entries.first
    garbage.should be_a(Garbage)
    garbage.content.should eq ""
    garbage.garbage_size.should eq 0

    entries = Parser.parse_groups_and_garbage("<random characters>")
    garbage = entries.first
    garbage.should be_a(Garbage)
    garbage.content.should eq "random characters"
    garbage.garbage_size.should eq 17

    entries = Parser.parse_groups_and_garbage("<<<<>")
    garbage = entries.first
    garbage.should be_a(Garbage)
    garbage.content.should eq "<<<"

    entries = Parser.parse_groups_and_garbage("<{!>}>")
    garbage = entries.first
    garbage.should be_a(Garbage)
    garbage.content.should eq "{!>}"

    entries = Parser.parse_groups_and_garbage("<!!>")
    garbage = entries.first
    garbage.should be_a(Garbage)
    garbage.content.should eq "!!"

    entries = Parser.parse_groups_and_garbage("<!!!>>")
    garbage = entries.first
    garbage.should be_a(Garbage)
    garbage.content.should eq "!!!>"

    entries = Parser.parse_groups_and_garbage("<{o\"i!a,<{i<a>")
    garbage = entries.first
    garbage.should be_a(Garbage)
    garbage.content.should eq "{o\"i!a,<{i<a"
    garbage.garbage_size.should eq 10
  end

  it "can parse basic groups" do
    entries = Parser.parse_groups_and_garbage("{}")
    group = entries.first
    group.should be_a(Group)
    group.entries.size.should eq 0

    entries = Parser.parse_groups_and_garbage("{{{}}}")
    group = entries.first
    group.should be_a(Group)
    group.entries.size.should eq 1
    group.garbage_size.should eq 0
    group.entries.first.should be_a(Group)
    group.entries.first.entries.first.should be_a(Group)

    entries = Parser.parse_groups_and_garbage("{{},{}}")
    group = entries.first
    group.should be_a(Group)
    group.entries.size.should eq 2
  end

  it "can parse a stream of groups" do
    entries = Parser.parse_groups_and_garbage("{{},{}}{}{<abc>}")
    entries.size.should eq 3
  end

  it "can tally the score for groups and garbage" do
    entries = Parser.parse_groups_and_garbage("{{},{}}")
    entries.first.score.should eq 5

    entries = Parser.parse_groups_and_garbage("{{{},{},{{}}}}")
    entries.first.score.should eq 16

    entries = Parser.parse_groups_and_garbage("{<a>,<a>,<a>,<a>}")
    entries.first.score.should eq 1

    entries = Parser.parse_groups_and_garbage("{{<ab>},{<ab>},{<ab>},{<ab>}}")
    entries.first.score.should eq 9

    entries = Parser.parse_groups_and_garbage("{{<!!>},{<!!>},{<!!>},{<!!>}}")
    entries.first.score.should eq 9

    entries = Parser.parse_groups_and_garbage("{{<a!>},{<a!>},{<a!>},{<ab>}}")
    entries.first.score.should eq 3
  end
end
