package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestStreamProcessing_1(t *testing.T) {
    result := StreamProcessing("<>")
    assert.Equal(t, 0, result)
}

func TestStreamProcessing_2(t *testing.T) {
    result := StreamProcessing("<random characters>")
    assert.Equal(t, 17, result)
}

func TestStreamProcessing_3(t *testing.T) {
    result := StreamProcessing("<<<<>")
    assert.Equal(t, 3, result)
}

func TestStreamProcessing_4(t *testing.T) {
    result := StreamProcessing("<{!>}>")
    assert.Equal(t, 2, result)
}

func TestStreamProcessing_5(t *testing.T) {
    result := StreamProcessing("<!!>")
    assert.Equal(t, 0, result)
}

func TestStreamProcessing_6(t *testing.T) {
    result := StreamProcessing("<!!!>>")
    assert.Equal(t, 0, result)
}

func TestStreamProcessing_7(t *testing.T) {
    result := StreamProcessing("<{o\"i!a,<{i<a>")
    assert.Equal(t, 10, result)
}