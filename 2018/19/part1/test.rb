require_relative "goWithTheFlow"
require "test/unit"

class RunTests < Test::Unit::TestCase
    def test_case
        input = %{#ip 0
seti 5 0 1
seti 6 0 2
addi 0 1 0
addr 1 2 3
setr 1 0 0
seti 8 0 4
seti 9 0 5}
        assert_equal(6, goWithTheFlow(input.split("\n")))
    end
end