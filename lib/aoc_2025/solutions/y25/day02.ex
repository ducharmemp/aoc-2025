defmodule Aoc2025.Solutions.Y25.Day02 do
  alias AoC.Input

  def parse(input, _part) do
    Input.read!(input)
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.split(&1, "-"))
    |> Enum.map(fn [start_range, end_range] ->
      String.to_integer(start_range)..String.to_integer(end_range)
    end)
  end

  def part_one(problem) do
    repeated =
      for range <- problem,
          number <- range,
          number = Integer.digits(number),
          length(number) > 1,
          Integer.mod(length(number), 2) == 0,
          has_repeats?(number, div(length(number), 2)) do
        Integer.undigits(number)
      end

    repeated |> Enum.uniq() |> Enum.sum()
  end

  def part_two(problem) do
    repeated =
      for range <- problem,
          number <- range,
          number = Integer.digits(number),
          length(number) > 1,
          size <- 1..div(length(number), 2),
          has_repeats?(number, size) do
        Integer.undigits(number)
      end

    repeated |> Enum.uniq() |> Enum.sum()
  end

  defp has_repeats?(digits, slices) do
    elems =
      digits
      |> Enum.chunk_every(slices, slices)
      |> Enum.map(&to_string/1)

    length(elems) > 1 and MapSet.size(MapSet.new(elems)) == 1
  end
end
