defmodule AOCTest.Day1 do
  use ExUnit.Case
  @tag day1: true

  test "day 1 part 1 example" do
    input = AOC.Parsing.__getInput("day1_example.txt")
    assert 24000 == AOC.Day1.part1(input)
  end

  test "day 1 part 1 actual" do
    input = AOC.Parsing.__getInput("day1_actual.txt")
    assert 67016 == AOC.Day1.part1(input)
  end

  test "day 1 part 2 example" do
    input = AOC.Parsing.__getInput("day1_example.txt")
    assert 45000 == AOC.Day1.part2(input)
  end

  test "day 1 part 2 actual" do
    input = AOC.Parsing.__getInput("day1_actual.txt")
    assert 200116 == AOC.Day1.part2(input)
  end
end
