require_relative "settlersOfTheNorthPole"
require "test/unit"

class RunTests < Test::Unit::TestCase
    def test_case
        input = %{.#.#...|#.
.....#|##|
.|..|...#.
..|#.....#
#.#|||#|#|
...#.||...
.|....|...
||...#|.#|
|.||||..|.
...#.|..|.}
        assert_equal(1147, settlersOfTheNorthPole(input.split("\n")))
    end
end