require_relative "chocolateCharts"
require "test/unit"

class RunTests < Test::Unit::TestCase

  def test_case
    assert_equal(9, chocolateCharts([5,1,5,8,9]))
    assert_equal(5, chocolateCharts([0,1,2,4,5]))
    assert_equal(18, chocolateCharts([9,2,5,1,0]))
    assert_equal(2018, chocolateCharts([5,9,4,1,4]))
  end
end