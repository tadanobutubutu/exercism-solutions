let rec search = (number, low, high) =>
  if (low > high) {
    high;
  } else {
    let middle = low + (high - low) / 2;
    let square = middle * middle;
    if (square == number) {
      middle;
    } else if (square < number) {
      search(number, middle + 1, high);
    } else {
      search(number, low, middle - 1);
    };
  };

let squareRoot = (number) => search(number, 1, number / 2 + 1);
