require_relative "inventoryManagementSystem"

def readInput()
    File.readlines("../input")
end

puts inventoryManagementSystem(readInput())