require_relative "memoryManeuver"
require "test/unit"

class RunTests < Test::Unit::TestCase

  def test_case
    assert_equal(66, memoryManeuver("2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2".split))
  end
 
end