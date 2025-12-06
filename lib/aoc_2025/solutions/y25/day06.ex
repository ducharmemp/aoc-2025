defmodule Aoc2025.Solutions.Y25.Day06 do
  alias AoC.Input

  def parse(input, :part_one) do
    Input.stream!(input, trim: true)
    |> Stream.map(&String.split/1)
    |> Enum.reverse()
    |> then(&map_operands/1)
    |> then(&transpose/1)
  end

  def parse(input, :part_two) do
    sizes =
      Input.stream!(input, trim: true)
      |> Enum.map(&String.split/1)
      |> column_sizes()

    Input.read!(input)
    |> String.split("\n", trim: true)
    |> Enum.map(fn row ->
      Enum.reduce(sizes, {[], 0}, fn size, {acc, start} ->
        {[String.slice(row, start, size) | acc], start + size + 1}
      end)
      |> elem(0)
      |> Enum.reverse()
    end)
    |> Enum.reverse()
    |> then(&transpose/1)
    |> then(&transpose_numbers/1)
  end

  def part_one(columns) do
    columns |> Enum.map(&apply_operator/1) |> Enum.sum()
  end

  def part_two(columns) do
    columns |> Enum.map(&apply_operator/1) |> Enum.sum()
  end

  defp transpose_numbers(matrix) do
    Enum.map(matrix, fn [operator | row] ->
      row
      |> Enum.reverse()
      |> Enum.map(&String.graphemes/1)
      |> zip_longest()
      |> Enum.map(&Enum.join/1)
      |> Enum.map(&String.trim/1)
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(&String.to_integer/1)
      |> then(fn row -> [String.trim(operator) | row] end)
    end)
  end

  defp transpose(matrix) do
    matrix
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  defp map_operands([operators | operands]) do
    mapper = fn row -> Enum.map(row, &String.to_integer/1) end
    [operators | Enum.map(operands, mapper)]
  end

  defp apply_operator(["+" | numbers]), do: Enum.sum(numbers)
  defp apply_operator(["*" | numbers]), do: Enum.reduce(numbers, 1, &(&1 * &2))

  defp zip_longest(lists) do
    max_len = lists |> Enum.map(&length(&1)) |> Enum.max()

    lists
    |> Enum.map(&(&1 ++ List.duplicate(nil, max_len - length(&1))))
    |> Enum.zip()
    |> Enum.map(&(&1 |> Tuple.to_list() |> Enum.reject(fn x -> x == nil end)))
  end

  defp column_sizes(input) do
    input
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(fn column -> Enum.max_by(column, &String.length/1) end)
    |> Enum.map(&String.length/1)
  end
end
