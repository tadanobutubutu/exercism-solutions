let rec stepsToOne = (number, steps) =>
  if (number == 1) {
    Ok(steps);
  } else if (number mod 2 == 0) {
    stepsToOne(number / 2, steps + 1);
  } else {
    stepsToOne(number * 3 + 1, steps + 1);
  };

let collatzConjecture = (number) =>
  if (number <= 0) {
    Error("Only positive integers are allowed");
  } else {
    stepsToOne(number, 0);
  };
