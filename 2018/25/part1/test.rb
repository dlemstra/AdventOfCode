require_relative "fourDimensionalAdventure"
require "test/unit"

class RunTests < Test::Unit::TestCase
    def test_case0
        input = %{ 0,0,0,0
 3,0,0,0
 0,3,0,0
 0,0,3,0
 0,0,0,3
 0,0,0,6
 9,0,0,0
12,0,0,0}
        assert_equal(2, fourDimensionalAdventure(input.split("\n")))
    end

    def test_case1
        input = %{-1,2,2,0
0,0,2,-2
0,0,0,-2
-1,2,0,0
-2,-2,-2,2
3,0,2,-1
-1,3,2,2
-1,0,-1,0
0,2,1,-2
3,0,0,0}
        assert_equal(4, fourDimensionalAdventure(input.split("\n")))
    end

    def test_case2
        input = %{1,-1,0,1
2,0,-1,0
3,2,-1,0
0,0,3,1
0,0,-1,-1
2,3,-2,0
-2,2,0,0
2,-2,0,-1
1,-1,0,-1
3,2,0,2}
        assert_equal(3, fourDimensionalAdventure(input.split("\n")))
    end

    def test_case3
        input = %{1,-1,-1,-2
-2,-2,0,1
0,2,1,3
-2,3,-2,1
0,2,3,-2
-1,-1,1,-2
0,-2,-1,0
-2,2,3,-1
1,2,2,0
-1,-2,0,-2}
        assert_equal(8, fourDimensionalAdventure(input.split("\n")))
    end
end