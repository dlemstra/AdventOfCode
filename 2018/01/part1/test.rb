require_relative "chronalCalibration"
require "test/unit"
 
class RunTests < Test::Unit::TestCase
 
  def test_case
    assert_equal(3, chronalCalibration([1, 1, 1]))
    assert_equal(0, chronalCalibration([1, 1, -2]))
    assert_equal(-6, chronalCalibration([-1, -2, -3]))
  end
 
end