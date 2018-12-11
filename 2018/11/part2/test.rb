require_relative "chronalCharge"
require "test/unit"

class RunTests < Test::Unit::TestCase

  def test_case
    assert_equal("90,269,16", chronalCharge(18))
    assert_equal("232,251,12", chronalCharge(42))
  end
end