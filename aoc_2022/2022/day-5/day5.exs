# Credit to u/seacucumber_kid for this solution, I got really stuck on part 1 and my solution was not panning out
# so I ended up looking at other Elixir solutions for some guidance and I modified my old solution to look more or
# less like his, It's not really my solution and while I did modify Part 1 to get Part 2 the modification was trivial.
# This taught me a lot and I struggled quite a bit with this one, because I overcomplicated it
#
# To be clear I don't think this is cheating as I have hundred of lines of code that parsed the inputs correctly, it
# was just that my internal algorithm was off in a non obvious way, so I sought out some guidance. I annotated the whole
# process to sort of prove to myself an others that I understand the solution

# Read the two distinct inputs
[raw_stacks, raw_instructions] =
  "day5.txt"
  |> File.read!()
  |> String.split("\n\n") ## The stacks and the instructinos are seperated by two new lines

# Get a representation of the maps
stacks =
  raw_stacks
  |> String.replace(["[", "]"], " ")  ## Replace the square brackets with spaces for easier parsing
  |> String.split("\n")               ## split up each row of the given input
  |> Enum.drop(-1)                    ## drop the stack labels
  |> Enum.map(&String.graphemes/1)    ## get a list of graphemes of each string
  |> Enum.zip_reduce([], &[&1 | &2])  ## this is basically a transpose operation to create the stacks (upside down)
  |> Enum.reverse()                   ## flip them right side up
  |> Enum.map(fn stack -> Enum.reject(stack, &(&1 == " "))end) ## get rid of all the whitespace characters
  |> Enum.reject(&Enum.empty?/1)      ## Get rid of the leftover empty list from the zip_reduce
  |> Enum.with_index(&{&2 + 1, &1})   ## assign each of the stacks their numerical label
  |> Map.new                          ## turn the list of tuples into a Map for ease of access

instructions =
  raw_instructions
  |> String.split("\n")   ## Get each instructino
  |> Enum.map(fn inst ->  ## Using Regex turn each tuple into a trio of values in a tuple
    [_, amount, from, to] = Regex.run(~r/move (\d+) from (\d) to (\d)/, inst)
    {
      String.to_integer(amount),
      String.to_integer(from),
      String.to_integer(to)
    }
  end)

  # Part 1
  instructions
  |> Enum.reduce(stacks, fn {amount, from, to}, stacks ->
    stacks
    |> Map.update!(from, &Enum.drop(&1, amount)) ## drop the amount of crates from the "from" stack
    |> Map.update!(to, &((stacks[from] |> Enum.take(amount) |> Enum.reverse()) ++ &1)) ## take the crates and put them in the "to" stack reversed
  end)
  |> Enum.reduce("", fn {_, xs}, acc -> acc <> hd(xs) end) ## get the first crate on every stack and put it in a string
  |> IO.inspect(label: "part 1")

  # Part 2
    instructions
  |> Enum.reduce(stacks, fn {amount, from, to}, stacks ->
    stacks
    |> Map.update!(from, &Enum.drop(&1, amount))
    |> Map.update!(to, &((stacks[from] |> Enum.take(amount)) ++ &1)) ## No reversing this time
  end)
  |> Enum.reduce("", fn {_, xs}, acc -> acc <> hd(xs) end)
  |> IO.inspect(label: "part 2")
