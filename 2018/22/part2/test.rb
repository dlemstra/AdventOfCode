require_relative "modeMaze"
require "test/unit"

class RunTests < Test::Unit::TestCase
    def test_case
        input = %{depth: 510
target: 10,10}
        assert_equal(45, modeMaze(input.split("\n")))
    end
end