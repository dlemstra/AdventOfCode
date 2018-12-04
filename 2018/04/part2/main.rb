require_relative "reposeRecord"

def readInput()
    File.readlines("input")
end

puts reposeRecord(readInput())