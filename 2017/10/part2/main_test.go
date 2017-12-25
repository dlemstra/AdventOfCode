package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestKnotHash_1(t *testing.T) {
    result := KnotHash("")
    assert.Equal(t, "a2582a3a0e66e6e86e3812dcb672a272", result)
}

func TestKnotHash_2(t *testing.T) {
    result := KnotHash("AoC 2017")
    assert.Equal(t, "33efeb34ea91902bb2f59c9920caa6cd", result)
}

func TestKnotHash_3(t *testing.T) {
    result := KnotHash("1,2,3")
    assert.Equal(t, "3efbe78a8d82f29979031a4aa0b16a9d", result)
}

func TestKnotHash_4(t *testing.T) {
    result := KnotHash("1,2,4")
    assert.Equal(t, "63960835bcdc130f0b66d7ff4f6a5a8e", result)
}