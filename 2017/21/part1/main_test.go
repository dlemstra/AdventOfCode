package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestFractalArt(t *testing.T) {
    input := ReadInput("../test_input")
    result := FractalArt(input, 2)
    assert.Equal(t, 12, result)
}