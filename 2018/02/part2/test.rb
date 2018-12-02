require_relative "inventoryManagementSystem"
require "test/unit"
 
class RunTests < Test::Unit::TestCase
 
  def test_case
    assert_equal("fgij", inventoryManagementSystem(["abcde", "fghij", "klmno", "pqrst", "fguij", "axcye", "wvxyz"]))
  end
 
end