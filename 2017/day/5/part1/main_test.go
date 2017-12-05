package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestGetTwistyTrampolines(t *testing.T) {
    input := []int {0, 3, 0, 1, -3}
    result := GetTwistyTrampolines(input)
    assert.Equal(t, 5, result)
}