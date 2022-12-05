"day4.txt"
|> File.read!()
|> String.split("\n")
|> Enum.map(fn x -> String.split(x, ",") end)
|> Enum.reduce(0, fn x, acc ->
  [set1, set2] =
    Enum.map(x, fn y ->
      [left, right] = String.split(y, "-")
      {n, _} = Integer.parse(left)
      {m, _} = Integer.parse(right)
      MapSet.new(n..m)
    end)

  if MapSet.subset?(set1, set2) || MapSet.subset?(set2, set1), do: acc + 1, else: acc
end)
|> IO.inspect(label: "part 1")

"day4.txt"
|> File.read!()
|> String.split("\n")
|> Enum.map(fn x -> String.split(x, ",") end)
|> Enum.reduce(0, fn x, acc ->
  [set1, set2] =
    Enum.map(x, fn y ->
      [left, right] = String.split(y, "-")
      {n, _} = Integer.parse(left)
      {m, _} = Integer.parse(right)
      MapSet.new(n..m)
    end)

  if MapSet.size(MapSet.intersection(set1, set2)) != 0, do: acc + 1, else: acc
end)
|> IO.inspect(label: "part 2")
