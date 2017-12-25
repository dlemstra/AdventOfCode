package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestPermutationPromenade(t *testing.T) {
    input := ReadInput("../test_input")
    result := PermutationPromenade(input, 5, 2)
    assert.Equal(t, "ceadb", result)
}