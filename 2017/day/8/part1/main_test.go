package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestLikeRegisters(t *testing.T) {
    input := ReadInput("../test_input")
    result := LikeRegisters(input)
    assert.Equal(t, 1, result)
}