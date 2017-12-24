package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestElectromagneticMoat(t *testing.T) {
    input := ReadInput("../test_input")
    result := ElectromagneticMoat(input)
    assert.Equal(t, 31, result)
}