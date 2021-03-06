require_relative "experimentalEmergencyTeleportation"
require "test/unit"

class RunTests < Test::Unit::TestCase

    def test_case
        input = %{pos=<10,12,12\>, r=2
pos=<12,14,12\>, r=2
pos=<16,12,12\>, r=4
pos=<14,14,14\>, r=6
pos=<50,50,50\>, r=200
pos=<10,10,10\>, r=5}
        assert_equal(36, experimentalEmergencyTeleportation(input.split("\n")))
    end
end