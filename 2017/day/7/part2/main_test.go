package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestRecursiveCircus(t *testing.T) {
    input := ReadInput("../test_input")
    result := RecursiveCircus(input)
    assert.Equal(t, 60, result)
}