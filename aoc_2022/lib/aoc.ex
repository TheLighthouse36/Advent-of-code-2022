defmodule AOC do
  @moduledoc """
  Documentation for `AOC`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> AOC.hello()
      :world

  """
  def hello do
    :world
  end
end

defmodule AOC.Parsing do
  def __getInput(filePath) do
    :code.priv_dir(:aoc_2022)
    |> Path.join(filePath)
    |> File.read()
    |> elem(1)
  end
end
