require_relative "immuneSystemSimulator20XX"

def readInput()
    File.readlines("../input")
end

puts immuneSystemSimulator20XX(readInput())