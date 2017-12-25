package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestDuet(t *testing.T) {
    input := ReadInput("../test_input")
    result := Duet(input)
    assert.Equal(t, 1, result)
}

func TestDuet2(t *testing.T) {
    input := ReadInput("../test_input_deadlock")
    result := Duet(input)
    assert.Equal(t, 3, result)
}