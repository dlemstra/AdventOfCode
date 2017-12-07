package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestMemoryReallocation(t *testing.T) {
    input := ReadInput("../test_input")
    result := RecursiveCircus(input)
    assert.Equal(t, "tknk", result)
}