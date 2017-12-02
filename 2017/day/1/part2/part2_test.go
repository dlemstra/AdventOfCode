package part2

import (
    "testing"
    "github.com/stretchr/testify/assert"
)

func TestInverseCaptcha_1212(t *testing.T) {
    result := InverseCaptcha("1212")
    assert.Equal(t, 6, result)
}

func TestInverseCaptcha_1221(t *testing.T) {
    result := InverseCaptcha("1221")
    assert.Equal(t, 0, result)
}

func TestInverseCaptcha_123425(t *testing.T) {
    result := InverseCaptcha("123425")
    assert.Equal(t, 4, result)
}

func TestInverseCaptcha_123123(t *testing.T) {
    result := InverseCaptcha("123123")
    assert.Equal(t, 12, result)
}

func TestInverseCaptcha_12131415(t *testing.T) {
    result := InverseCaptcha("12131415")
    assert.Equal(t, 4, result)
}