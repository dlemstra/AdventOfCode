package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestSeriesOfTubes(t *testing.T) {
    input := ReadInput("../test_input")
    result := SeriesOfTubes(input)
    assert.Equal(t, 38, result)
}