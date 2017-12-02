package part1

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestInverseCaptcha_1122(t *testing.T) {
    result := InverseCaptcha("1122")
    assert.Equal(t, 3, result)
}

func TestInverseCaptcha_1111(t *testing.T) {
    result := InverseCaptcha("1111")
    assert.Equal(t, 4, result)
}

func TestInverseCaptcha_1234(t *testing.T) {
    result := InverseCaptcha("1234")
    assert.Equal(t, 0, result)
}

func TestInverseCaptcha_91212129(t *testing.T) {
    result := InverseCaptcha("91212129")
    assert.Equal(t, 9, result)
}