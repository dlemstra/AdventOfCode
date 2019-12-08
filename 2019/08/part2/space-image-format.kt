package aoc

class Layer(width: Int, height: Int) {
   val width = width
   val height = height
   val pixels = Array(height, {IntArray(width)})

   fun setPixels(input: String) {
      var offset = 0
      for (y in 0..height-1)
         for (x in 0..width-1)
            pixels[y][x] = input[offset++].toInt() - 48
   }

   fun drawOnTop(layer: Layer) {
      for (y in 0..height-1)
         for (x in 0..width-1)
            if (layer.pixels[y][x] != 2)
               pixels[y][x] = layer.pixels[y][x]
   }

   fun print() {
      println()
      for (y in 0..height-1) {
         for (x in 0..width-1) {
            if (pixels[y][x] == 0)
               print(' ')
            else
               print('*')
         }
         println()
      }
      println()
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

fun spaceImageFormat(input: String) {
   var layers = readLayers(input, 25, 6).asReversed()
   var layer = layers[0]

   for (i in 0..layers.count()-1)
      layer.drawOnTop(layers[i])

   layer.print()
}
