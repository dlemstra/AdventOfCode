package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestSporificaVirus(t *testing.T) {
    input := ReadInput("../test_input")
    result := SporificaVirus(input, 7)
    assert.Equal(t, 5, result)
}

func TestSporificaVirus2(t *testing.T) {
    input := ReadInput("../test_input")
    result := SporificaVirus(input, 70)
    assert.Equal(t, 41, result)
}

func TestSporificaVirus3(t *testing.T) {
    input := ReadInput("../test_input")
    result := SporificaVirus(input, 10000)
    assert.Equal(t, 5587, result)
}