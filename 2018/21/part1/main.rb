require_relative "chronalConversion"

def readInput()
    File.readlines("../input")
end

puts chronalConversion(readInput())