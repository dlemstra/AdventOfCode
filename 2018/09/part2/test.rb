require_relative "marbleMania"
require "test/unit"

class RunTests < Test::Unit::TestCase

  def test_case32
    assert_equal(32, marbleMania("9 players; last marble is worth 25 points"))
  end
  
  def test_case8317
    assert_equal(8317, marbleMania("10 players; last marble is worth 1618 points"))
  end

  def test_case146373
    assert_equal(146373, marbleMania("13 players; last marble is worth 7999 points"))
  end

  def test_case2764
     assert_equal(2764, marbleMania("17 players; last marble is worth 1104 points"))
  end

  def test_case54718
    assert_equal(54718, marbleMania("21 players; last marble is worth 6111 points"))
  end

  def test_case37305
    assert_equal(37305, marbleMania("30 players; last marble is worth 5807 points"))
  end
 
end