defmodule FileSystemRefined do

  def addFile(map, dir, file, value), do: {dir, Map.put(map, dir ++ [file], String.to_integer(value))}

  def addDir(map, dir, file), do: {dir, Map.put(map, dir ++ [file], 0)}

  def processLine(list, {dir, map}) do
    case list do
      ["$", "cd", "/"] -> {["/"], map}
      ["$", "cd", ".."] -> {Enum.drop(dir, -1), map}
      ["$", "cd", v] -> {dir ++ [v], map}
      ["$", "ls"] -> {dir, map}
      ["dir", v] -> addDir(map, dir, v)
      [v, n] -> addFile(map, dir, n, v)
      _ -> :not_parsed
    end
  end

  def getSizeOfDirs(fileSystem) do
     getSizeOfDirs(
       Enum.filter(fileSystem, fn {_k, v} -> v == 0 end),
       Enum.filter(fileSystem, fn {_k, v} -> v != 0 end)
     )
  end

  def getSizeOfDirs(mapAcc, files) do
    Enum.reduce(files, mapAcc, fn {fileName, fileSize}, acc ->
      Enum.map(acc, fn {dirName, dirSize} ->
       if (isFileInDir(fileName, dirName)) do
         {dirName, dirSize + fileSize}
       else
        {dirName, dirSize}
       end
      end)
    end)
  end

  def isFileInDir([fileHead | fileTail], []), do: true
  def isFileInDir([], _dir), do: false
  def isFileInDir([fileHead | fileTail], [dirHead | dirTail]) do
    if(fileHead == dirHead) do
      isFileInDir(fileTail, dirTail)
    else
      false
    end
  end
end

"day7.txt"
|> File.read!()
|> String.split("\n")
|> Enum.map(&String.split(&1, " "))
|> Enum.reduce({["/"], %{["/"] => 0}}, fn line, {dir, accMap} ->
  FileSystemRefined.processLine(line, {dir, accMap})
end)
|> elem(1)
|> FileSystemRefined.getSizeOfDirs()
|> Enum.filter(fn {_k, v} -> v <= 100_000 end)
|> Enum.reduce(0, fn {_k, v}, acc -> acc + v end)
|> IO.inspect(label: "part 1")

"day7.txt"
|> File.read!()
|> String.split("\n")
|> Enum.map(&String.split(&1, " "))
|> Enum.reduce({["/"], %{["/"] => 0}}, fn line, {dir, accMap} ->
  FileSystemRefined.processLine(line, {dir, accMap})
end)
|> elem(1)
|> FileSystemRefined.getSizeOfDirs()
|> Enum.sort_by(&elem(&1, 1))
|> then(fn x ->
  totalDiskSpaceAvailable = 70000000 - (Enum.take(x, -1) |> Enum.at(0) |> elem(1))
  Enum.reduce_while(x, :nil,
  fn {_name, val}, acc ->
    if (totalDiskSpaceAvailable + val  >= 30000000) do
      {:halt, val}
    else
      {:cont, :nil}
    end
  end)
end)
|> IO.inspect(label: "part 2")
