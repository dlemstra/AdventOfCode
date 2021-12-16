class BitReader:
    def __init__(self, data, buffer = []):
        self.data = data
        self.buffer = buffer.copy()

    def done(self):
        return (len(self.data) * 4) + len(self.buffer) < 8

    def readBits(self, count):
        value = 0
        read = 0
        while count != read:
            value = value << 1
            self.fillBuffer()
            bit = self.buffer.pop(0)
            value = value | bit
            read += 1

        return value

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
        group = reader.readBits(5)
        while group >> 4 != 0:
            group = reader.readBits(5)

        return part1
    else:
        if reader.readBits(1):
            count = reader.readBits(11)
            for _ in range(0, count):
                part1 += parseBuffer(reader)
        else:
            length = reader.readBits(15)
            data = reader.readBuffer(length)
            subReader = BitReader([], data)
            while not subReader.done():
                part1 += parseBuffer(subReader)

        return part1

def packetDecoder(input):
    reader = BitReader(list(input[0]))
    part1 = parseBuffer(reader)

    return (part1, None)
