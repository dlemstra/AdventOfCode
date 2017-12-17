package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestSpinlock(t *testing.T) {
    result := Spinlock(3)
    assert.Equal(t, 638, result)
}