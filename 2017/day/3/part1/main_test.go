package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestSpiralMemory_1(t *testing.T) {
    result := SpiralMemory("1")
    assert.Equal(t, 0, result)
}

func TestSpiralMemory_12(t *testing.T) {
    result := SpiralMemory("12")
    assert.Equal(t, 3, result)
}

func TestSpiralMemory_13(t *testing.T) {
    result := SpiralMemory("12")
    assert.Equal(t, 4, result)
}

func TestSpiralMemory_23(t *testing.T) {
    result := SpiralMemory("23")
    assert.Equal(t, 2, result)
}

func TestSpiralMemory_50(t *testing.T) {
    result := SpiralMemory("50")
    assert.Equal(t, 7, result)
}

func TestSpiralMemory_53(t *testing.T) {
    result := SpiralMemory("53")
    assert.Equal(t, 4, result)
}

func TestSpiralMemory_1024(t *testing.T) {
    result := SpiralMemory("1024")
    assert.Equal(t, 31, result)
}