package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestStreamProcessing_1(t *testing.T) {
    result := StreamProcessing("{}")
    assert.Equal(t, 1, result)
}

func TestStreamProcessing_2(t *testing.T) {
    result := StreamProcessing("{{{}}}")
    assert.Equal(t, 6, result)
}

func TestStreamProcessing_3(t *testing.T) {
    result := StreamProcessing("{{},{}}")
    assert.Equal(t, 5, result)
}

func TestStreamProcessing_4(t *testing.T) {
    result := StreamProcessing("{{{},{},{{}}}}")
    assert.Equal(t, 16, result)
}

func TestStreamProcessing_5(t *testing.T) {
    result := StreamProcessing("{<a>,<a>,<a>,<a>}")
    assert.Equal(t, 1, result)
}

func TestStreamProcessing_6(t *testing.T) {
    result := StreamProcessing("{{<ab>},{<ab>},{<ab>},{<ab>}}")
    assert.Equal(t, 9, result)
}

func TestStreamProcessing_7(t *testing.T) {
    result := StreamProcessing("{{<!!>},{<!!>},{<!!>},{<!!>}}")
    assert.Equal(t, 9, result)
}

func TestStreamProcessing_8(t *testing.T) {
    result := StreamProcessing("{{<a!>},{<a!>},{<a!>},{<ab>}}")
    assert.Equal(t, 3, result)
}