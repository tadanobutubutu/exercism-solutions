let rec validDigits = (digits, inputBase) =>
  switch (digits) {
  | [] => true
  | [digit, ...tail] =>
    digit >= 0 && digit < inputBase && validDigits(tail, inputBase)
  };

let rec toDecimal = (digits, inputBase, value) =>
  switch (digits) {
  | [] => value
  | [digit, ...tail] => toDecimal(tail, inputBase, value * inputBase + digit)
  };

let rec fromDecimal = (value, outputBase, digits) =>
  if (value == 0) {
    digits;
  } else {
    fromDecimal(value / outputBase, outputBase, [value mod outputBase, ...digits]);
  };

let rebase = (inputBase, digits, outputBase) => {
  if (inputBase < 2 || outputBase < 2 || digits == []) {
    None;
  } else if (!validDigits(digits, inputBase)) {
    None;
  } else {
    let value = toDecimal(digits, inputBase, 0);
    if (value == 0) {None} else {Some(fromDecimal(value, outputBase, []))};
  };
};
