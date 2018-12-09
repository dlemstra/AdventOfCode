require_relative "marbleMania"

def readInput()
    File.readlines("input")[0]
end

puts marbleMania(readInput())