defmodule Pipes do
  def cohort(pipes, start) do
    cohort(pipes, start, MapSet.new)
  end

  def cohort(pipes, start, set) do
    set = MapSet.put(set, start)
    Enum.reduce(pipes[start], set, fn(program, set) ->
      if MapSet.member?(set, program) do
        set
      else
        cohort(pipes, program, set)
      end
    end)
  end

  def count_groups(pipes) do
    programs = pipes |> Map.keys |> MapSet.new
    count_groups(pipes, programs, 0)
  end

  def count_groups(pipes, programs, how_many_groups) do
    if MapSet.size(programs) == 0 do
      how_many_groups
    else
      seed = programs |> MapSet.to_list |> List.first
      group = cohort(pipes, seed)
      remaining = MapSet.difference(programs, group)
      count_groups(pipes, remaining, how_many_groups + 1)
    end
  end

  def parse(filepath) do
    filepath
    |> File.read!
    |> String.trim
    |> String.split("\n")
    |> Enum.reduce(%{}, fn(line, map) ->
      [program, rest] = String.split(line, " <-> ")
      connected_to = String.split(rest, ", ")
      Map.put(map, program, connected_to)
    end)
  end
end
