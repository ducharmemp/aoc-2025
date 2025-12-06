defmodule Aoc2025.Solutions.Y25.Day05 do
  alias AoC.Input

  def parse(input, _part) do
    {ranges, ids} =
      Input.stream!(input)
      |> partition_input()

    ranges = convert_ranges(ranges)

    ids = convert_ids(ids)

    {ranges, ids}
  end

  def part_one({ranges, ids}) do
    ids |> Enum.filter(fn id -> Enum.any?(ranges, fn range -> id in range end) end) |> length()
  end

  def part_two({ranges, _}) do
    ranges
    |> Enum.sort_by(&Map.get(&1, :first))
    |> Enum.reduce([], &merge_ranges/2)
    |> Enum.map(fn {first, last} -> last - first + 1 end)
    |> Enum.sum()
  end

  defp partition_input(input) do
    input
    |> Enum.map(&String.trim/1)
    |> Enum.split_while(fn line -> line != "" end)
  end

  defp convert_ranges(ranges) do
    ranges
    |> Enum.map(&String.split(&1, "-"))
    |> Enum.map(fn
      [start_id, end_id] ->
        String.to_integer(start_id)..String.to_integer(end_id)
    end)
  end

  defp convert_ids(ids), do: ids |> Enum.reject(&(&1 == "")) |> Enum.map(&String.to_integer/1)

  defp merge_ranges(current_range, []), do: [{current_range.first, current_range.last}]

  defp merge_ranges(current_range, [{start_range, end_range} | rest]) do
    if Range.disjoint?(current_range, start_range..end_range) do
      [{current_range.first, current_range.last}, {start_range, end_range} | rest]
    else
      [{start_range, max(end_range, current_range.last)} | rest]
    end
  end
end
