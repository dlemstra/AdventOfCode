require_relative "inventoryManagementSystem"
require "test/unit"
 
class RunTests < Test::Unit::TestCase
 
  def test_case
    assert_equal(12, inventoryManagementSystem(["abcdef","bababc","abbcde","abcccd","aabcdd","abcdee","ababab"]))
  end
 
end