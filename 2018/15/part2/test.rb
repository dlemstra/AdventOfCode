require_relative "beverageBandits"
require "test/unit"

class RunTests < Test::Unit::TestCase

    def test_case1
        input = %{#######
#.G...#
#...EG#
#.#.#G#
#..G#E#
#.....#
#######}
        assert_equal(4988, beverageBandits(input.split("\n")))
    end

    def test_case2
        input = %{#######
#E..EG#
#.#G.E#
#E.##E#
#G..#.#
#..E#.#
#######}
        assert_equal(31284, beverageBandits(input.split("\n")))
    end

def test_case3
      input = %{#######
#E.G#.#
#.#G..#
#G.#.G#
#G..#.#
#...E.#
#######}
        assert_equal(3478, beverageBandits(input.split("\n")))
    end

    def test_case4
        input = %{#######
#.E...#
#.#..G#
#.###.#
#E#G#G#
#...#G#
#######}
        assert_equal(6474, beverageBandits(input.split("\n")))
  end

    def test_case5
        input = %{#########
#G......#
#.E.#...#
#..##..G#
#...##..#
#...#...#
#.G...G.#
#.....G.#
#########}
        assert_equal(1140, beverageBandits(input.split("\n")))
    end
end