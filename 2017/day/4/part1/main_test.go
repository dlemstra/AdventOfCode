package main

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestIsValidPassphrase_aa_bb_cc_dd_ee(t *testing.T) {
    result := IsValidPassphrase("aa bb cc dd ee")
    assert.Equal(t, true, result)
}

func TestIsValidPassphrase_aa_bb_cc_dd_aa(t *testing.T) {
    result := IsValidPassphrase("aa bb cc dd aa")
    assert.Equal(t, false, result)
}

func TestIsValidPassphrase_aa_bb_cc_dd_aaa(t *testing.T) {
    result := IsValidPassphrase("aa bb cc dd aaa")
    assert.Equal(t, true, result)
}