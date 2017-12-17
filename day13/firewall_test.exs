ExUnit.start()

Code.require_file("./firewall.exs")

defmodule FirewallTest do
  use ExUnit.Case, async: true

  @config_file "./test.input.txt"

  test "it can parse a firewall config" do
    firewall = Firewall.parse(@config_file)
    assert firewall[0] == %Layer{depth: 0, range: 3, position: 0, direction: 1}
    assert firewall[2] == nil
  end

  test "it can advance the state of the firewall" do
    firewall = Firewall.parse(@config_file) |> Firewall.advance
    assert firewall[0] == %Layer{depth: 0, range: 3, position: 1, direction: 1}
    assert firewall[1] == %Layer{depth: 1, range: 2, position: 1, direction: 1}
    firewall = firewall |> Firewall.advance
    assert firewall[0] == %Layer{depth: 0, range: 3, position: 2, direction: 1}
    assert firewall[1] == %Layer{depth: 1, range: 2, position: 0, direction: -1}
    firewall = firewall |> Firewall.advance
    assert firewall[0] == %Layer{depth: 0, range: 3, position: 1, direction: -1}
    assert firewall[1] == %Layer{depth: 1, range: 2, position: 1, direction: 1}
  end

  test "it can measure the severity of getting caught through the firewall" do
    firewall = Firewall.parse(@config_file)
    assert Firewall.severity_of_traversal(firewall) == 24
  end

  test "it finds the minimum delay to traverse without getting caught" do
    firewall = Firewall.parse(@config_file)
    assert Firewall.minimum_delay_to_traverse(firewall) == 10
  end
end
