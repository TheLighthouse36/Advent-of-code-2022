"day6.txt"
|> File.read!()
|> then(fn x ->
  Enum.reduce_while(4..String.length(x), 0, fn v, acc ->
    if MapSet.size(MapSet.new(String.graphemes(String.slice(x, (v - 4)..(v - 1))))) == 4 do
      {:halt, v}
    else
      {:cont, nil}
    end
  end)
end)
|> IO.inspect(label: "part 1")

"day6.txt"
|> File.read!()
|> then(fn x ->
  Enum.reduce_while(14..String.length(x), 0, fn v, acc ->
    if MapSet.size(MapSet.new(String.graphemes(String.slice(x, (v - 14)..(v - 1))))) == 14 do
      {:halt, v}
    else
      {:cont, nil}
    end
  end)
end)
|> IO.inspect(label: "part 2")
