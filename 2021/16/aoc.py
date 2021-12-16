def parseInt(buffer):
    value = 0
    for bit in buffer:
        value <<= 1
        value |= bit

    return value

class BitReader:
    def __init__(self, data, buffer = []):
        self.data = data
        self.buffer = buffer.copy()

    def done(self):
        return (len(self.data) * 4) + len(self.buffer) < 8

    def readBits(self, count):
        buffer = self.readBuffer(count)
        return parseInt(buffer)

    def readBuffer(self, count):
        buffer = []
        while len(buffer) != count:
            self.fillBuffer()
            buffer.append(self.buffer.pop(0))

        return buffer

    def fillBuffer(self):
        if len(self.buffer) > 0:
            return

        if len(self.data) == 0:
            return

        c = int(self.data.pop(0), 16)
        self.buffer.append(1 if c & 8 else 0)
        self.buffer.append(1 if c & 4 else 0)
        self.buffer.append(1 if c & 2 else 0)
        self.buffer.append(1 if c & 1 else 0)

def parseBuffer(reader):
    version = reader.readBits(3)
    type = reader.readBits(3)

    part1 = version

    if type == 4:
        buffer = []
        bit = 1
        while bit != 0:
            group = reader.readBuffer(5)
            bit = group.pop(0)
            buffer.extend(group)
        return (part1, parseInt(buffer))
    else:
        values = []
        if reader.readBits(1):
            count = reader.readBits(11)
            for _ in range(0, count):
                (sub_part1, sub_part2) = parseBuffer(reader)
                part1 += sub_part1
                values.append(sub_part2)
        else:
            length = reader.readBits(15)
            data = reader.readBuffer(length)
            subReader = BitReader([], data)
            while not subReader.done():
                (sub_part1, sub_part2) = parseBuffer(subReader)
                part1 += sub_part1
                values.append(sub_part2)

        match type:
            case 0:
                part2 = sum(values)
            case 1:
                part2 = 1
                for value in values:
                    part2 *= value
            case 2:
                part2 = min(values)
            case 3:
                part2 = max(values)
            case 4:
                part2 = 0
            case 5:
                part2 = 1 if values[0] > values[1] else 0
            case 6:
                part2 = 1 if values[0] < values[1] else 0
            case 7:
                part2 = 1 if values[0] == values[1] else 0

        return (part1, part2)

def packetDecoder(input):
    reader = BitReader(list(input[0]))
    return parseBuffer(reader)
