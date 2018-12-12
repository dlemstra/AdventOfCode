require_relative "subterraneanSustainability"
require "test/unit"

class RunTests < Test::Unit::TestCase

  def test_case
    input = %{initial state: #..#.#..##......###...###

...## => #
..#.. => #
.#... => #
.#.#. => #
.#.## => #
.##.. => #
.#### => #
#.#.# => #
#.### => #
##.#. => #
##.## => #
###.. => #
###.# => #
####. => #}
    assert_equal(325, subterraneanSustainability(input.split("\n")))
  end
end