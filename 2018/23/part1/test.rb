require_relative "experimentalEmergencyTeleportation"
require "test/unit"

class RunTests < Test::Unit::TestCase

    def test_case
        input = %{pos=<0,0,0\>, r=4
pos=<1,0,0\>, r=1
pos=<4,0,0\>, r=3
pos=<0,2,0\>, r=1
pos=<0,5,0\>, r=3
pos=<0,0,3\>, r=1
pos=<1,1,1\>, r=1
pos=<1,1,2\>, r=1
pos=<1,3,1\>, r=1}
        assert_equal(7, experimentalEmergencyTeleportation(input.split("\n")))
    end
end