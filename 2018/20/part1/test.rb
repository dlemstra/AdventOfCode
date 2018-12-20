require_relative "aRegularMap"
require "test/unit"

class RunTests < Test::Unit::TestCase
    def test_case0
        assert_equal(3, aRegularMap("^WNE$"))
    end

    def test_case1
        assert_equal(10, aRegularMap("^ENWWW(NEEE|SSE(EE|N))$"))
    end

    def test_case2
        assert_equal(18, aRegularMap("^ENNWSWW(NEWS|)SSSEEN(WNSE|)EE(SWEN|)NNN$"))
    end

    def test_case3
        assert_equal(23 , aRegularMap("^ESSWWN(E|NNENN(EESS(WNSE|)SSS|WWWSSSSE(SW|NNNE)))$"))
    end

    def test_case4
        assert_equal(31, aRegularMap("^WSSEESWWWNW(S|NENNEEEENN(ESSSSW(NWSW|SSEN)|WSWWN(E|WWS(E|SS))))$"))
    end
end