package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestDuelingGenerators(t *testing.T) {
    result := DuelingGenerators(65, 8921, 1056)
    assert.Equal(t, 1, result)
}