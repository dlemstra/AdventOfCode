require_relative "beverageBandits"

def readInput()
    File.readlines("input")
end

puts beverageBandits(readInput())