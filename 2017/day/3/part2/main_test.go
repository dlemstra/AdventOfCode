package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestSpiralMemory_1(t *testing.T) {
    result := SpiralMemory(1)
    assert.Equal(t, 1, result)
}

func TestSpiralMemory_3(t *testing.T) {
    result := SpiralMemory(3)
    assert.Equal(t, 4, result)
}

func TestSpiralMemory_7(t *testing.T) {
    result := SpiralMemory(7)
    assert.Equal(t, 10, result)
}

func TestSpiralMemory_58(t *testing.T) {
    result := SpiralMemory(58)
    assert.Equal(t, 59, result)
}

func TestSpiralMemory_200(t *testing.T) {
    result := SpiralMemory(304)
    assert.Equal(t, 7, result)
}

func TestSpiralMemory_305(t *testing.T) {
    result := SpiralMemory(305)
    assert.Equal(t, 330, result)
}

func TestSpiralMemory_747(t *testing.T) {
    result := SpiralMemory(747)
    assert.Equal(t, 806, result)
}