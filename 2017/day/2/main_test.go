package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestInverseCaptcha(t *testing.T) {
    result := CorruptionChecksum(`5	1	9	5
7	5	3
2	4	6	8`)
    assert.Equal(t, 18, result)
}