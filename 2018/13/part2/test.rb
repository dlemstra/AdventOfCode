require_relative "mineCartMadness"
require "test/unit"

class RunTests < Test::Unit::TestCase

  def test_case
    input = %{/>-<\\
|   |  
| /<+-\\
| | | v
\\>+</ |
  |   ^
  \\<->/}
    assert_equal("6,4", mineCartMadness(input.split("\n")))
  end
end