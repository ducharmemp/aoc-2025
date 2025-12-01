defmodule Aoc2025.Solutions.Y25.Day01 do
  alias AoC.Input

  @dial_ticks 100

  def parse(input, _part) do
    input
    |> Input.stream!(trim: true)
  end

  def part_one(problem) do
    problem
    |> Enum.map(&dial_rotation/1)
    |> Enum.map_reduce(50, fn rotation, dial ->
      new_dial = Integer.mod(dial + rotation, @dial_ticks)
      {new_dial, new_dial}
    end)
    |> elem(0)
    |> Enum.count(fn item -> item == 0 end)
  end

  def part_two(problem) do
    problem
    |> Enum.map(&dial_rotation/1)
    |> Enum.map_reduce(50, fn rotation, dial ->
      new_dial = Integer.mod(dial + rotation, @dial_ticks)

      dial_range =
        if rotation > 0,
          do: (dial + 1)..(dial + rotation),
          else: (dial - 1)..(dial + rotation)//-1

      switches = Enum.count(dial_range, fn num -> rem(num, @dial_ticks) == 0 end)
      {switches, new_dial}
    end)
    |> elem(0)
    |> Enum.sum()
  end

  defp dial_rotation("L" <> count) do
    -1 * String.to_integer(count)
  end

  defp dial_rotation("R" <> count) do
    String.to_integer(count)
  end
end
