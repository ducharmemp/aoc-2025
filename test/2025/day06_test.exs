defmodule Aoc2025.Solutions.Y25.Day06Test do
  alias AoC.Input, warn: false
  alias Aoc2025.Solutions.Y25.Day06, as: Solution, warn: false
  use ExUnit.Case, async: true

  # To run the test, run one of the following commands:
  #
  #     mix AoC.test --year 2025 --day 6
  #
  #     mix test test/2025/day06_test.exs
  #
  # To run the solution
  #
  #     mix AoC.run --year 2025 --day 6 --part 1
  #
  # Use sample input file:
  #
  #     # returns {:ok, "priv/input/2025/day-06-mysuffix.inp"}
  #     {:ok, path} = Input.resolve(2025, 6, "mysuffix")
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
    123 328  51 64 
     45 64  387 23 
      6 98  215 314
    *   +   *   +  
    """

    assert 4_277_556 == solve(input, :part_one)
  end

  # Once your part one was successfully sumbitted, you may uncomment this test
  # to ensure your implementation was not altered when you implement part two.

  @part_one_solution 5_784_380_717_354

  test "part one solution" do
    assert {:ok, @part_one_solution} == AoC.run(2025, 6, :part_one)
  end

  test "part two example" do
    input = ~S"""
    123 328  51 64 
     45 64  387 23 
      6 98  215 314
    *   +   *   +  
    """

    assert 3_263_827 == solve(input, :part_two)
  end

  # You may also implement a test to validate the part two to ensure that you
  # did not broke your shared modules when implementing another problem.

  # @part_two_solution CHANGE_ME
  #
  # test "part two solution" do
  #   assert {:ok, @part_two_solution} == AoC.run(2025, 6, :part_two)
  # end
end
