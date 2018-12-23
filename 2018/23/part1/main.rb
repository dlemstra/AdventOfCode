require_relative "experimentalEmergencyTeleportation"

def readInput()
    File.readlines("../input")
end

puts experimentalEmergencyTeleportation(readInput())