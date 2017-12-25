package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestPacketScanners(t *testing.T) {
    input := ReadInput("../test_input")
    result := PacketScanners(input)
    assert.Equal(t, 24, result)
}