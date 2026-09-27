let rec encode = (number, values) =>
  switch (values) {
  | [] => ""
  | [(value, numeral), ...tail] =>
    if (number >= value) {
      numeral ++ encode(number - value, values);
    } else {
      encode(number, tail);
    }
  };

let toRoman = (number) =>
  encode(
    number,
    [
      (1000, "M"),
      (900, "CM"),
      (500, "D"),
      (400, "CD"),
      (100, "C"),
      (90, "XC"),
      (50, "L"),
      (40, "XL"),
      (10, "X"),
      (9, "IX"),
      (5, "V"),
      (4, "IV"),
      (1, "I"),
    ],
  );
