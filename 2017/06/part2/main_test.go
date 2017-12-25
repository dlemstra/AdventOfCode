package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestMemoryReallocation(t *testing.T) {
    input := []int {0, 2, 7, 0}
    result := MemoryReallocation(input)
    assert.Equal(t, 4, result)
}