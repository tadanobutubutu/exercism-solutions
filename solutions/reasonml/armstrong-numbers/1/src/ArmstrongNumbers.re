let rec digitCount = (number) =>
  if (number < 10) {1} else {1 + digitCount(number / 10)};

let rec digitPower = (digit, exponent) =>
  if (exponent == 0) {1} else {digit * digitPower(digit, exponent - 1)};

let rec sumPoweredDigits = (number, exponent) =>
  if (number == 0) {
    0;
  } else {
    digitPower(number mod 10, exponent)
    + sumPoweredDigits(number / 10, exponent);
  };

let validate = (number) =>
  sumPoweredDigits(number, digitCount(number)) == number;
