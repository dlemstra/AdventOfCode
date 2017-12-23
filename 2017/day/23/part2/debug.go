package main

import (
    "fmt"
)

func main() {
    b := 0
    c := 0
    d := 0
    e := 0
    f := 0
    g := 0
    h := 0

    b = 67       // set b 67
    c = b        // set c b
                 // jnz a 2
                 // jnz 1 5
    b *= 100     // mul b 100
    b -= -100000 // sub b -100000
    c = b        // set c b
    c -= -17000  // sub c -17000
i8:
    f = 1        // set f 1
    d = 2        // set d 2
i10:
    e = 2        // set e 2
i11:
    for b % d != 0 {
        d++
    }

    if b == d {
        goto i30
    }

    goto next

    g = d        // set g d
    g *= e       // mul g e
    g -= b       // sub g b
    if g != 0 {  // jnz g 2
        goto i16
    }
    f = 0        // set f 0
    goto next
i16:
    e -= -1      // sub e -1
    g = e        // set g e
    g -= b       // sub g b
    if g != 0 {  // jnz g -8
        goto i11
    }
    d -= -1      // sub d -1
    g = d        // set g d
    g -= b       // sub g b
    if g != 0 {  // jnz g -13
        goto i10
    }
    if f != 0 {  // jnz f 2
        goto i26
    }
next:
    h -= -1      // sub h -1
i26:
    g = b        // set g b
    g -= c       // sub g c
    if g != 0 {  // jnz g 2
        goto i30
    }
    fmt.Println(h)
    return       // jnz 1 3
i30:
    b -= -17     // sub b -17
    goto i8
}