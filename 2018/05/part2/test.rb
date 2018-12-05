require_relative "alchemicalReduction"
require "test/unit"

class RunTests < Test::Unit::TestCase

  def test_case
    assert_equal(4, alchemicalReduction("dabAcCaCBAcCcaDA"))
  end
 
end