defmodule RPS do
  def get_score(opp, me) do
    cond do
      get_win_move(opp) == me -> 6 + me
      opp == me -> 3 + me
      true -> me
    end
  end
# part 2
  def get_lose_move(x) do
    case x do
     1 -> 3
     2 -> 1
     3 -> 2
    end
  end

  def get_win_move(x) do
    case x do
     1 -> 2
     2 -> 3
     3 -> 1
    end
  end

  def get_move([v, "X"]) do get_score(v, get_lose_move(v)) end # lose
  def get_move([v, "Y"]) do get_score(v, v) end # draw
  def get_move([v, "Z"]) do get_score(v, get_win_move(v)) end # win
end



"day2_actual.txt"
|> File.read!()
|> String.replace("A", "1")
|> String.replace("X", "1")
|> String.replace("B", "2")
|> String.replace("Y", "2")
|> String.replace("C", "3")
|> String.replace("Z", "3")
|> String.split("\n")
|> Enum.map(fn x -> String.split(x, " ") end)
|> Enum.map(fn x -> Enum.map(x, fn y -> Integer.parse(y) |> elem(0) end)  end)
|> Enum.map(fn [a, b] -> RPS.get_score(a, b) end)
|> Enum.sum()
|> IO.inspect(label: "part 1")

"day2_actual.txt"
|> File.read!()
|> String.replace("A", "1")
|> String.replace("B", "2")
|> String.replace("C", "3")
|> String.split("\n")
|> Enum.map(fn x -> String.split(x, " ") end)
|> Enum.map(fn [x, y] -> [Integer.parse(x) |> elem(0), y] end)
|> Enum.map(fn x-> RPS.get_move(x) end)
|> Enum.sum()
|> IO.inspect(label: "part 2")
