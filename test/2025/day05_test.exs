defmodule Aoc2025.Solutions.Y25.Day05Test do
  alias AoC.Input, warn: false
  alias Aoc2025.Solutions.Y25.Day05, as: Solution, warn: false
  use ExUnit.Case, async: true

  # To run the test, run one of the following commands:
  #
  #     mix AoC.test --year 2025 --day 5
  #
  #     mix test test/2025/day05_test.exs
  #
  # To run the solution
  #
  #     mix AoC.run --year 2025 --day 5 --part 1
  #
  # Use sample input file:
  #
  #     # returns {:ok, "priv/input/2025/day-05-mysuffix.inp"}
  #     {:ok, path} = Input.resolve(2025, 5, "mysuffix")
  #
  # Good luck!

  defp solve(input, part) do
    problem =
      input
      |> Input.as_file()
      |> Solution.parse(part)

    apply(Solution, part, [problem])
  end

  test "part one example" do
    input = ~S"""
    3-5
    10-14
    16-20
    12-18

    1
    5
    8
    11
    17
    32
    """

    assert 3 == solve(input, :part_one)
  end

  # Once your part one was successfully sumbitted, you may uncomment this test
  # to ensure your implementation was not altered when you implement part two.

  @part_one_solution 773
  #
  test "part one solution" do
    assert {:ok, @part_one_solution} == AoC.run(2025, 5, :part_one)
  end

  test "part two example" do
    input = ~S"""
    3-5
    10-14
    16-20
    12-18

    1
    5
    8
    11
    17
    32
    """

    assert 14 == solve(input, :part_two)
  end

  # You may also implement a test to validate the part two to ensure that you
  # did not broke your shared modules when implementing another problem.

  # @part_two_solution CHANGE_ME
  #
  # test "part two solution" do
  #   assert {:ok, @part_two_solution} == AoC.run(2025, 5, :part_two)
  # end
end
