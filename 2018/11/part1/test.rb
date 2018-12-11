require_relative "chronalCharge"
require "test/unit"

class RunTests < Test::Unit::TestCase

  def test_case
    assert_equal("33,45", chronalCharge(18))
    assert_equal("21,61", chronalCharge(42))
  end
end