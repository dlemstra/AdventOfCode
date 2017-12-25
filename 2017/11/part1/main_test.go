package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestHexEd_1(t *testing.T) {
    input := []string {"ne", "ne", "ne"}
    result := HexEd(input)
    assert.Equal(t, 3, result)
}

func TestHexEd_2(t *testing.T) {
    input := []string {"ne", "ne", "sw", "sw"}
    result := HexEd(input)
    assert.Equal(t, 0, result)
}

func TestHexEd_3(t *testing.T) {
    input := []string {"ne", "ne", "s", "s"}
    result := HexEd(input)
    assert.Equal(t, 2, result)
}

func TestHexEd_4(t *testing.T) {
    input := []string {"se", "sw", "se", "sw", "sw"}
    result := HexEd(input)
    assert.Equal(t, 3, result)
}