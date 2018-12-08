class Node
    def read(data)

        @children = Array.new(data[0])
        @metadata = Array.new(data[1])

        offset = 2
        for i in 0..@children.length - 1 do
            child = Node.new
            @children[i] = child

            child.read(data[offset..-1])
            offset += child.size
        end

        for i in 0..@metadata.length - 1 do
            @metadata[i] = data[offset + i]
        end
    end

    def size
        return 2 + @metadata.length + @children.sum(&:size)
    end

    def metadataSum
        return @metadata.sum + @children.sum(&:metadataSum)
    end
end

def memoryManeuver(input)
    data = input.map(&:to_i)

    node = Node.new
    node.read(data)

    return node.metadataSum
end