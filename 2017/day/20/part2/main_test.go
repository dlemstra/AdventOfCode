package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestParticleSwarm(t *testing.T) {
    input := ReadInput("../test_input")
    result := ParticleSwarm(input)
    assert.Equal(t, 2, result)
}

func TestParticleSwarm2(t *testing.T) {
    input := ReadInput("../test_input2")
    result := ParticleSwarm(input)
    assert.Equal(t, 1, result)
}

func TestParticleSwarm3(t *testing.T) {
    input := ReadInput("../test_input3")
    result := ParticleSwarm(input)
    assert.Equal(t, 1, result)
}