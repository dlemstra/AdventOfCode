require_relative "noMatterHowYouSliceIt"
require "test/unit"
 
class RunTests < Test::Unit::TestCase
 
  def test_case
    assert_equal("#3", noMatterHowYouSliceIt(["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 5,5: 2x2"]))
    assert_equal(-1, noMatterHowYouSliceIt(["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 4,4: 2x2"]))
  end
 
end