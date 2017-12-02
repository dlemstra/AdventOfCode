package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestCorruptionChecksum(t *testing.T) {
    result := CorruptionChecksum(`5	9	2	8
9	4	7	3
3	8	6	5`)
    assert.Equal(t, 9, result)
}