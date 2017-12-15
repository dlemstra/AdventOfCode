package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestDigitalPlumber(t *testing.T) {
    input := ReadInput("../test_input")
    result := PacketScanners(input)
    assert.Equal(t, 10, result)
}