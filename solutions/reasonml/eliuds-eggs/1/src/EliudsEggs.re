let rec countSetBits = (number, count) =>
  if (number == 0) {
    count;
  } else {
    countSetBits(number / 2, count + (number mod 2));
  };

let eggCount = (number) => countSetBits(number, 0);
