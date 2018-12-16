require_relative "memoryManeuver"

def readInput()
    File.readlines("../input")[0].split
end

puts memoryManeuver(readInput())