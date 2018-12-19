require_relative "goWithTheFlow"

def readInput()
    File.readlines("../input")
end

puts goWithTheFlow(readInput())