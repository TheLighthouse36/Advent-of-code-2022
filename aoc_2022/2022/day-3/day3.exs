defmodule Util do
  def findCommonItem(string) do
    string
    |> String.split_at(div(String.length(string), 2))
    |> Tuple.to_list()
    |> Enum.map(fn x -> String.split(x, "") end)
    |> Enum.map(&Enum.frequencies/1)
    |> Enum.map(fn x -> Map.pop(x, "") end)
    |> Enum.map(fn x -> elem(x, 1) end)
    |> Enum.map(&Map.keys/1)
    |> List.flatten()
    |> Enum.frequencies()
    |> then(fn x -> :maps.filter(fn _, v -> v > 1 end, x) end)
    |> Map.keys()
    |> Enum.at(0)
  end

  def findCommonItem_part2(sacks) do
    sacks
    |> Enum.map(fn x -> String.split(x, "") end)
    |> Enum.map(&MapSet.new/1)
    |> Enum.map(fn x -> MapSet.delete(x, "") end)
    |> then(fn [s1, s2, s3] ->
      s1
      |> MapSet.intersection(s2)
      |> MapSet.intersection(s3)
    end)
    |> MapSet.to_list()
    |> List.first()
  end

  def getAscii(item) do
    item
    |> String.to_charlist()
    |> hd()
  end

  def getPriority(a) do
    if(a >= 97) do
      a - 96
    else
      a - 38
    end
  end
end

"day3.txt"
|> File.read!()
|> String.split("\n")
|> Enum.map(&Util.findCommonItem/1)
|> Enum.map(&Util.getAscii/1)
|> Enum.map(&Util.getPriority/1)
|> Enum.sum()
|> IO.inspect(label: "part1")

"day3.txt"
|> File.read!()
|> String.split("\n")
|> Enum.chunk_every(3)
|> Enum.map(&Util.findCommonItem_part2/1)
|> Enum.map(&Util.getAscii/1)
|> Enum.map(&Util.getPriority/1)
|> Enum.sum()
|> IO.inspect(label: "part 2")
