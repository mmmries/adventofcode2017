ExUnit.start

Code.require_file("./pipes.exs")

defmodule Pipes.ParseTest do
  use ExUnit.Case, async: true
  @input "./test.input.txt"

  test "it parses the list of programs and pipes" do
    pipes = Pipes.parse(@input)
    assert pipes["0"] == ["2"]
    assert pipes["6"] == ["4", "5"]
  end

  test "it can build a list of all programs connected to one starting program" do
    group = @input |> Pipes.parse |> Pipes.cohort("0")
    assert group == MapSet.new(["0","2","3","4","5","6"])
  end

  test "it can count the cohorts in a set of pipes" do
    count = @input |> Pipes.parse |> Pipes.count_groups
    assert count == 2
  end
end
