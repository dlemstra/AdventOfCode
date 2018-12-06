require_relative "chronalCoordinates"
require "test/unit"

class RunTests < Test::Unit::TestCase

  def test_case
    assert_equal(17, chronalCoordinates(["1, 1", "1, 6", "8, 3", "3, 4", "5, 5", "8, 9"]))
  end
 
end