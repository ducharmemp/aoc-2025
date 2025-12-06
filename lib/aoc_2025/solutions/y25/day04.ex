defmodule Aoc2025.Solutions.Y25.Day04 do
  alias AoC.Input

  def parse(input, _part) do
    input
    |> Input.stream!()
    |> Enum.map(&String.graphemes/1)
  end

  def part_one(problem) do
    surrounding_counts(problem)
    |> Enum.filter(fn count -> count < 4 end)
    |> length()
  end

  def part_two(problem) do
    for row <- simulate_once(problem),
        col <- row do
      if col == "x", do: 1, else: 0
    end
    |> Enum.sum()
  end

  defp simulate_once(problem) do
    new_matrix =
      problem
      |> Enum.with_index()
      |> Enum.map(fn {row, row_index} ->
        row
        |> Enum.with_index()
        |> Enum.map(fn
          {"@", col_index} ->
            count =
              surrounding_positions(problem, row_index, col_index)
              |> Enum.frequencies()
              |> Map.get("@", 0)

            if count >= 4, do: "@", else: "x"

          {val, _} ->
            val
        end)
      end)

    if new_matrix == problem do
      new_matrix
    else
      simulate_once(new_matrix)
    end
  end

  defp surrounding_counts(problem) do
    for row <- 0..length(problem),
        col <- 0..length(Enum.at(problem, row, [])),
        get_value_at(problem, row, col) == "@" do
      surrounding_positions(problem, row, col) |> Enum.frequencies() |> Map.get("@", 0)
    end
  end

  defp surrounding_positions(matrix, row, col) do
    top_left = get_value_at(matrix, row - 1, col - 1)
    middle_left = get_value_at(matrix, row, col - 1)
    bottom_left = get_value_at(matrix, row + 1, col - 1)

    top = get_value_at(matrix, row - 1, col)
    bottom = get_value_at(matrix, row + 1, col)

    top_right = get_value_at(matrix, row - 1, col + 1)
    middle_right = get_value_at(matrix, row, col + 1)
    bottom_right = get_value_at(matrix, row + 1, col + 1)

    [top_left, middle_left, bottom_left, top, bottom, top_right, middle_right, bottom_right]
  end

  defp get_value_at(_matrix, -1, _), do: nil
  defp get_value_at(_matrix, _, -1), do: nil

  defp get_value_at(matrix, row, col) do
    Enum.at(matrix, row, []) |> Enum.at(col)
  end
end
