package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestSpinlock(t *testing.T) {
    result := Spinlock(3, 2017)
    assert.Equal(t, 1226, result)
}