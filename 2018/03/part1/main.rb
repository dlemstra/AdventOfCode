require_relative "noMatterHowYouSliceIt"

def readInput()
    File.readlines("input")
end

puts noMatterHowYouSliceIt(readInput())