package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestKnotHash(t *testing.T) {
    list := CreateList(5)
    input := []int {3, 4, 1, 5}
    result := KnotHash(list, input)
    assert.Equal(t, 12, result)
}