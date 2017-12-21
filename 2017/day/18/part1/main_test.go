package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestDuet(t *testing.T) {
    input := ReadInput("../test_input")
    result := Duet(input)
    assert.Equal(t, 4, result)
}