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
        assert_equal(27730, beverageBandits(input.split("\n")))
    end

    def test_case2
        input = %{#######
#G..#E#
#E#E.E#
#G.##.#
#...#E#
#...E.#
#######}
        assert_equal(36334, beverageBandits(input.split("\n")))
    end

    def test_case3
        input = %{#######
#E..EG#
#.#G.E#
#E.##E#
#G..#.#
#..E#.#
#######}
        assert_equal(39514, beverageBandits(input.split("\n")))
    end

    def test_case4
        input = %{#######
#E.G#.#
#.#G..#
#G.#.G#
#G..#.#
#...E.#
#######}
        assert_equal(27755, beverageBandits(input.split("\n")))
    end

    def test_case5
        input = %{#######
#.E...#
#.#..G#
#.###.#
#E#G#G#
#...#G#
#######}
        assert_equal(28944, beverageBandits(input.split("\n")))
    end

    def test_case6
        input = %{#########
#G......#
#.E.#...#
#..##..G#
#...##..#
#...#...#
#.G...G.#
#.....G.#
#########}
        assert_equal(18740, beverageBandits(input.split("\n")))
    end
end