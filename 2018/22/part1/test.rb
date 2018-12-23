require_relative "modeMaze"
require "test/unit"

class RunTests < Test::Unit::TestCase
    def test_setErosionLevel
        erosion = {}
        assert_equal(510, setErosionLevel(erosion, 510, 0, 0))
        assert_equal(17317, setErosionLevel(erosion, 510, 1, 0))
        assert_equal(8415, setErosionLevel(erosion, 510, 0, 1))
        assert_equal(1805, setErosionLevel(erosion, 510, 1, 1))
    end

    def test_case
        input = %{depth: 510
target: 10,10}
        assert_equal(114, modeMaze(input.split("\n")))
    end
end