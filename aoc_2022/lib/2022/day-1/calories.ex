defmodule AOC.Day1 do
  import AOC.Parsing

  def part1(input) do
    input
    |> String.trim_trailing("\n")
    |> String.split("\r\n\r")
    |> Enum.map(fn x -> String.trim(x, "\n") end)
    |> Enum.map(fn x -> String.split(x, "\r\n") end)
    |> Enum.map(fn x ->
      Enum.reduce(x, 0, fn y, acc ->
        {cal_elem, _} = Integer.parse(y)
        acc = cal_elem + acc
      end)
    end)
    |> Enum.max()
  end

  def part2(input) do
    input
    |> String.trim_trailing("\n")
    |> String.split("\r\n\r")
    |> Enum.map(fn x -> String.trim(x, "\n") end)
    |> Enum.map(fn x -> String.split(x, "\r\n") end)
    |> Enum.map(fn x ->
      Enum.reduce(x, 0, fn y, acc ->
        {cal_elem, _} = Integer.parse(y)
        acc = cal_elem + acc
      end)
    end)
    |> Enum.sort_by(& &1, :desc)
    |> Enum.slice(0..2)
    |> Enum.reduce(&+/2)
  end
end
