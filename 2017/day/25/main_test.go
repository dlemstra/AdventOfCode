package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestHaltingProblem(t *testing.T) {
    input := ReadInput("test_input")
    result := HaltingProblem(input)
    assert.Equal(t, 3, result)
}