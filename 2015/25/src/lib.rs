extern crate num_integer;

pub fn let_it_snow(target_x: i64, target_y: i64) -> i64 {
    let mut x = 1i64;
    let mut y = 1i64;

    let mut row = 1;
    let mut count = 1;
    while !(x == target_x && y == target_y) {
        if y - 1 == 0 {
            row += 1;
            y = row;
            x = 1;
        } else {
            y -= 1;
            x += 1;
        }

        count += 1;
    }

    let mut prev = 20151125i64;
    let mut code = 0i64;

    while count > 1 {
        let (_, modulus) = num_integer::div_rem(prev * 252533, 33554393);
        code = modulus;
        prev = code;

        count -= 1;
    }

    return code;
}
