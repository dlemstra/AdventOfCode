require_relative "theSumOfItsParts"
require "test/unit"

class RunTests < Test::Unit::TestCase

  def test_case
    input = %{Step C must be finished before step A can begin.
Step C must be finished before step F can begin.
Step A must be finished before step B can begin.
Step A must be finished before step D can begin.
Step B must be finished before step E can begin.
Step D must be finished before step E can begin.
Step F must be finished before step E can begin.}
    assert_equal(15, theSumOfItsParts(input.split("\n"), 2, 0))
  end
 
end