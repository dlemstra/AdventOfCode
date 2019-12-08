package aoc

class Layer(width: Int, height: Int) {
   val width = width
   val height = height
   val pixels = Array(height, {IntArray(width)})

   fun setPixels(input: String) {
      var offset = 0
      for (y in 0..height-1)
         for (x in 0..width-1)
            pixels[y][x] = input[offset++].toString().toInt()
   }

   fun findPixelsByValue(value: Int): Int {
      var result = 0
      for (y in 0..height-1)
         for (x in 0..width-1)
            if (pixels[y][x] == value)
               result++

      return result
   }
}

fun readLayers(input: String, width: Int, height: Int): List<Layer> {
   var layers = mutableListOf<Layer>()

   var offset = 0
   while (offset < input.count()) {
      var layer = Layer(width, height)
      layers.add(layer)
      layer.setPixels(input.substring(offset))
      offset += width * height
   }

   return layers
}

fun spaceImageFormat(input: String): Number {
   var layers = readLayers(input, 25, 6)
   var layer = layers.minBy { it.findPixelsByValue(0) } !!

   return layer.findPixelsByValue(1) * layer.findPixelsByValue(2)
}
