require_relative "chronalCalibration"
require "test/unit"
 
class RunTests < Test::Unit::TestCase
 
  def test_case
    assert_equal(0, chronalCalibration([1, -1]))
    assert_equal(10, chronalCalibration([3, 3, 4, -2, -4]))
    assert_equal(5, chronalCalibration([-6, 3, 8, 5, -6]))
    assert_equal(14, chronalCalibration([7, 7, -2, -7, -4]))
  end
 
end