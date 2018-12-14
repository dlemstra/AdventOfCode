require_relative "chocolateCharts"
require "test/unit"

class RunTests < Test::Unit::TestCase

  def test_case
    assert_equal("5158916779", chocolateCharts(9))
    assert_equal("0124515891", chocolateCharts(5))
    assert_equal("9251071085", chocolateCharts(18))
    assert_equal("5941429882", chocolateCharts(2018))
  end
end