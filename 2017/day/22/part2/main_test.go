package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestSporificaVirus(t *testing.T) {
    input := ReadInput("../test_input")
    result := SporificaVirus(input, 100)
    assert.Equal(t, 26, result)
}

func TestSporificaVirus2(t *testing.T) {
    input := ReadInput("../test_input")
    result := SporificaVirus(input, 10000000)
    assert.Equal(t, 2511944, result)
}