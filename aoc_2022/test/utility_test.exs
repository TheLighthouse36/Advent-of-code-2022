defmodule AOCTest.Utility do
  use ExUnit.Case
  @tag utility: true

  test "input parsing" do
    input = AOC.Parsing.__getInput("sample_input.txt")
    assert "FACEF00D" == input
  end
end
