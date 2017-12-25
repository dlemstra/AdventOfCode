package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestIsValidPassphrase_abcde_fghij(t *testing.T) {
    result := IsValidPassphrase("abcde fghij")
    assert.Equal(t, true, result)
}

func TestIsValidPassphrase_abcde_xyz_ecdab(t *testing.T) {
    result := IsValidPassphrase("abcde xyz ecdab")
    assert.Equal(t, false, result)
}

func TestIsValidPassphrase_a_ab_abc_abd_abf_abj(t *testing.T) {
    result := IsValidPassphrase("a ab abc abd abf abj")
    assert.Equal(t, true, result)
}

func TestIsValidPassphrase_iiii_oiii_ooii_oooi_oooo(t *testing.T) {
    result := IsValidPassphrase("iiii oiii ooii oooi oooo")
    assert.Equal(t, true, result)
}

func TestIsValidPassphrase_oiii_ioii_iioi_iiio(t *testing.T) {
    result := IsValidPassphrase("oiii ioii iioi iiio")
    assert.Equal(t, false, result)
}