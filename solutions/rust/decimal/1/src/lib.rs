use std::cmp::Ordering;
use std::fmt;
use std::ops::{Add, Mul, Sub};

use num_bigint::{BigInt, Sign};
use num_traits::{pow, Signed, Zero};

/// Type implementing arbitrary-precision decimal arithmetic
#[derive(Debug, Eq, Clone)]
pub struct Decimal {
    digits: BigInt,
    decimal_index: usize,
}

impl Decimal {
    fn new(digits: BigInt, decimal_index: usize) -> Decimal {
        let mut value = Decimal {
            digits,
            decimal_index,
        };
        value.reduce();
        value
    }

    pub fn try_from(input: &str) -> Option<Decimal> {
        let input = input.trim();
        if input.is_empty() {
            return None;
        }

        let mut digits = String::with_capacity(input.len());
        let mut decimal_index = 0;
        let mut has_decimal_point = false;
        let mut has_digit = false;
        for (index, ch) in input.chars().enumerate() {
            match ch {
                '0'..='9' => {
                    digits.push(ch);
                    has_digit = true;
                    if has_decimal_point {
                        decimal_index += 1;
                    }
                }
                '.' => {
                    if has_decimal_point {
                        return None;
                    }
                    has_decimal_point = true;
                }
                '+' | '-' if index == 0 => digits.push(ch),
                _ => return None,
            }
        }
        if !has_digit {
            return None;
        }
        Some(Decimal::new(digits.parse().ok()?, decimal_index))
    }

    /// Add precision to the less-precise value until precisions match
    ///
    /// Precision, in this case, is defined as the decimal index.
    fn equalize_precision(one: &mut Decimal, two: &mut Decimal) {
        fn expand(lower_precision: &mut Decimal, higher_precision: &Decimal) {
            let precision_difference =
                higher_precision.decimal_index - lower_precision.decimal_index;

            lower_precision.digits =
                &lower_precision.digits * pow(BigInt::from(10_usize), precision_difference);
            lower_precision.decimal_index += precision_difference;
        }
        match one.decimal_index.cmp(&two.decimal_index) {
            std::cmp::Ordering::Equal => {}
            std::cmp::Ordering::Less => expand(one, two),
            std::cmp::Ordering::Greater => expand(two, one),
        }
        assert_eq!(one.decimal_index, two.decimal_index);
    }

    /// Eliminate extraneous trailing zeroes
    ///
    /// This reduces the decimal index, so that the raw values are easier to parse
    fn reduce(&mut self) {
        if self.digits.is_zero() {
            self.decimal_index = 0;
            return;
        }
        let extra_zeroes = self
            .digits
            .abs()
            .to_string()
            .chars()
            .rev()
            .take(self.decimal_index)
            .take_while(|&c| c == '0')
            .count();
        self.digits = &self.digits / pow(BigInt::from(10_usize), extra_zeroes);
        self.decimal_index -= extra_zeroes;
    }
}

macro_rules! auto_impl_decimal_ops {
    ($(#[$attr:meta])* $trait:ident, $func_name:ident, $digits_operation:expr, $index_operation:expr) => {
        impl $trait for Decimal {
            type Output = Self;
            $(#[$attr])*
            fn $func_name(mut self, mut rhs: Self) -> Self {
                Decimal::equalize_precision(&mut self, &mut rhs);
                Decimal::new(
                    #[allow(clippy::redundant_closure_call)]
                    $digits_operation(self.digits, rhs.digits),
                    #[allow(clippy::redundant_closure_call)]
                    $index_operation(self.decimal_index, rhs.decimal_index),
                )
            }
        }
    };
}

auto_impl_decimal_ops!(Add, add, |s, o| s + o, |s, _| s);
auto_impl_decimal_ops!(Sub, sub, |s, o| s - o, |s, _| s);
auto_impl_decimal_ops!(
    #[allow(clippy::suspicious_arithmetic_impl)]
    Mul,
    mul,
    |s, o| s * o,
    |s, o| s + o
);

macro_rules! auto_impl_decimal_cow {
    ($trait:ident, $func_name:ident, $digits_operation:expr, $return_type:ty) => {
        impl $trait for Decimal {
            fn $func_name(&self, other: &Self) -> $return_type {
                if self.decimal_index == other.decimal_index {
                    #[allow(clippy::redundant_closure_call)]
                    $digits_operation(&self.digits, &other.digits)
                } else {
                    // if we're here, the decimal indexes are unmatched.
                    // We have to compare equal terms.
                    // clone both sides so we can modify either of them as necessary.
                    // not efficient, but whatever.
                    let mut one = self.clone();
                    let mut two = other.clone();
                    Decimal::equalize_precision(&mut one, &mut two);
                    one.$func_name(&two)
                }
            }
        }
    };
}

auto_impl_decimal_cow!(PartialEq, eq, |a, b| a == b, bool);
auto_impl_decimal_cow!(Ord, cmp, |a: &BigInt, b: &BigInt| a.cmp(b), Ordering);

impl PartialOrd for Decimal {
    fn partial_cmp(&self, other: &Decimal) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl fmt::Display for Decimal {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        let negative = self.digits.sign() == Sign::Minus;
        let digits = self.digits.abs().to_string();
        if self.decimal_index == 0 {
            return if negative {
                write!(f, "-{digits}")
            } else {
                write!(f, "{digits}")
            };
        }

        let padded = format!("{:0>width$}", digits, width = self.decimal_index + 1);
        let split = padded.len() - self.decimal_index;
        let (whole, fractional) = padded.split_at(split);
        if negative {
            write!(f, "-{whole}.{fractional}")
        } else {
            write!(f, "{whole}.{fractional}")
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn display_temp() {
        for &test_str in &["0", "1", "20", "0.3", "0.04", "50.05", "66.0006", "0.007"] {
            println!(
                "Decimal representation of \"{}\": {}",
                test_str,
                Decimal::try_from(test_str).expect("This should always become a decimal")
            );
            assert_eq!(
                test_str,
                Decimal::try_from(test_str)
                    .expect("This should always become a decimal")
                    .to_string()
            )
        }
    }
}
