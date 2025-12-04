defmodule Aoc2025.Solutions.Y25.Day03 do
  alias AoC.Input

  def parse(input, _part) do
    Input.stream!(input, trim: true)
    |> Enum.map(&parse_bank/1)
  end

  def part_one(problem) do
    problem |> Enum.map(&max_joltage(&1, 2)) |> Enum.sum()
  end

  def part_two(problem) do
    problem |> Enum.map(&max_joltage(&1, 12)) |> Enum.sum()
  end

  defp parse_bank(line) do
    line |> String.to_integer() |> Integer.digits()
  end

  def max_joltage(bank, battery_count) do
    Enum.reduce(
      battery_count..1//-1,
      {bank, []},
      fn
        to_enable, {batteries, found} ->
          {search, rest} =
            Enum.split(batteries, -to_enable + 1) |> dbg()

          search = if search == [], do: bank, else: search
          largest = Enum.max(search)
          next_set = Enum.drop_while(search, &(&1 != largest)) |> tl()
          {next_set ++ rest, [largest | found]} |> dbg()
      end
    )
    |> elem(1)
    |> Enum.reverse()
    |> Integer.undigits()
  end
end
