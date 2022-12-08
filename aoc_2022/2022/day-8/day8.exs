defmodule Util do
  @changeVectors [{0, -1}, {0, 1}, {-1, 0}, {1, 0}]

  def getNestedEntry(listOfLists, {x, y}), do: Enum.at(listOfLists, x) |> Enum.at(y)

  def isVisible(listOflists, {x, y}) do
    if (isEdge(listOflists, {x, y}) == true) do
      1
    else
      Enum.reduce(@changeVectors, 0, fn changeVector, acc ->
        if (detectVisibility(listOflists, {x, y}, changeVector)), do: 1, else: acc
      end)
    end
  end

  def detectVisibility(listOflists, {x, y}, interval), do: detectVisibility(listOflists, {x, y}, interval, {x, y})
  def detectVisibility(listOflists, {x, y}, {dx, dy}, {ax, ay}) do
    if (isEdge(listOflists, {ax + dx, ay + dy}) == true) do
      getNestedEntry(listOflists, {x, y}) > getNestedEntry(listOflists, {ax + dx, ay + dy})
    else
      if(getNestedEntry(listOflists, {x, y}) > getNestedEntry(listOflists, {ax + dx, ay + dy})) do
        detectVisibility(listOflists, {x, y}, {dx, dy}, {ax + dx, ay + dy})
      else
        false
      end
    end
  end

  def isEdge(listOflists, {x, y}) do
    sideLength = length(listOflists) - 1
    case {x, y} do
      {0, _} -> true
      {_, 0} -> true
      {^sideLength, _} -> true
      {_, ^sideLength} -> true
      _ -> false
    end
  end

  # Part 2
  def getScenicScore(listOflists, {x, y}) do
    @changeVectors
    |> Enum.reduce(1, fn changeVector, acc ->
      acc * getScenicRow(listOflists, {x, y}, changeVector)
    end)
  end

  def getScenicRow(listOflists, {x, y}, {dx, dy}) do
    sideLength = length(listOflists) - 1
    case {x, y, dx, dy} do
    {0, _, -1, 0} -> 0
    {_, 0, _, -1} -> 0
    {^sideLength, _, 1, _} -> 0
    {_, ^sideLength, _, 1} -> 0
    _ -> getScenicRow(listOflists, {x, y}, {dx, dy}, {x, y}, 0)
    end
  end

  def getScenicRow(listOflists, {x, y}, {dx, dy}, {ax, ay}, acc) do
    if (isEdge(listOflists, {ax + dx, ay + dy}) == true) do
      acc + 1
    else
      if(getNestedEntry(listOflists, {x, y}) > getNestedEntry(listOflists, {ax + dx, ay + dy})) do
        getScenicRow(listOflists, {x, y}, {dx, dy}, {ax + dx, ay + dy}, acc + 1)
      else
        acc + 1
      end
    end
  end
end

# Parsing
listOfLists = "day8.txt"
|> File.read!()
|> String.split("\n")
|> Enum.map(&String.graphemes/1)
|> Enum.map(&Enum.map(&1, fn x -> String.to_integer(x) end))

#Part 1
for x <- 0..length(Enum.at(listOfLists, 0)) - 1 , y <- 0..length(listOfLists) - 1 do
  {x, y}
end
|> Enum.map(fn coord -> Util.isVisible(listOfLists, coord) end)
|> Enum.sum()
|> IO.inspect(label: "Part 1")

# Part 2
for x <- 0..length(Enum.at(listOfLists, 0)) - 1 , y <- 0..length(listOfLists) - 1 do
  {x, y}
end
|> Enum.map(fn coord -> Util.getScenicScore(listOfLists, coord) end)
|> Enum.max()
|> IO.inspect(label: "Part 2")
