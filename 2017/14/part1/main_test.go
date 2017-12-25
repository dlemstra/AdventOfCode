package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestDiskDefragmentation(t *testing.T) {
    result := DiskDefragmentation("flqrgnkx")
    assert.Equal(t, 8108, result)
}