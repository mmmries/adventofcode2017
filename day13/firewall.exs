defmodule Layer do
  @enforce_keys [:depth, :direction, :range, :position]
  defstruct [:depth, :direction, :range, :position]
end

defmodule Firewall do
  def parse(filepath) do
    filepath
    |> File.read!
    |> String.trim
    |> String.split("\n")
    |> Enum.reduce(%{}, fn(line, map) ->
      [depth, range] = String.split(line, ": ") |> Enum.map(&String.to_integer/1)
      layer = %Layer{depth: depth,
                     range: range,
                     position: 0,
                     direction: 1}
      Map.put(map, depth, layer)
    end)
  end

  def advance(firewall) do
    firewall |> Enum.map(fn({depth, layer}) ->
      {depth, advance_layer(layer)}
    end) |> Enum.into(%{})
  end

  defp advance_layer(%{position: 0, direction: -1}=layer) do
    %{layer| position: 1, direction: 1}
  end
  defp advance_layer(%{position: p, range: r, direction: 1}=layer) when p == r - 1 do
    %{layer| position: r - 2, direction: -1}
  end
  defp advance_layer(%{position: p, direction: d}=layer) do
    Map.put(layer, :position, p + d)
  end

  def severity_of_traversal(firewall) do
    catches = catches_during_traversal(firewall)
    Enum.reduce(catches, 0, fn(%{range: r, depth: d}, sum) -> sum + (d * r) end)
  end

  def catches_during_traversal(firewall) do
    total_depth = firewall |> Map.keys |> Enum.max
    state = %{position: 0, firewall: firewall, catches: []}
    final = (0..total_depth) |> Enum.reduce(state, fn(_tick, state) ->
      traverse_a_layer(state)
    end)
    final.catches
  end

  defp traverse_a_layer(%{position: p, firewall: f, catches: c}) do
    case caught?(f[p]) do
      false -> %{position: p + 1, firewall: advance(f), catches: c}
      %Layer{}=l -> %{position: p + 1, firewall: advance(f), catches: [l | c]}
    end
  end
  defp caught?(%Layer{position: 0}=layer), do: layer
  defp caught?(_), do: false

  def minimum_delay_to_traverse(firewall, delay \\ 0) do
    if catches_during_traversal(firewall) == [] do
      delay
    else
      firewall |> advance |> minimum_delay_to_traverse(delay + 1)
    end
  end
end
