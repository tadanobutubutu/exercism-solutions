let isDigit = (character) => character >= '0' && character <= '9';

let isFormatting = (character) =>
  character == ' ' || character == '\t' || character == '\n'
  || character == '\r' || character == '-' || character == '.'
  || character == '(' || character == ')';

let rec collectDigits = (text, index, digits) =>
  if (index >= String.length(text)) {
    Some(digits);
  } else {
    let character = String.get(text, index);
    if (isDigit(character)) {
      collectDigits(text, index + 1, digits ++ String.make(1, character));
    } else if (character == '+' && index == 0) {
      collectDigits(text, index + 1, digits);
    } else if (isFormatting(character)) {
      collectDigits(text, index + 1, digits);
    } else {
      None;
    };
  };

let validNanp = (digits) => {
  let length = String.length(digits);
  let tenDigits =
    if (length == 10) {
      Some(digits);
    } else if (length == 11 && String.get(digits, 0) == '1') {
      Some(String.sub(digits, 1, 10));
    } else {
      None;
    };
  switch (tenDigits) {
  | None => None
  | Some(number) => {
    let areaCode = String.get(number, 0);
    let exchangeCode = String.get(number, 3);
    if (
      areaCode >= '2' && areaCode <= '9'
      && exchangeCode >= '2' && exchangeCode <= '9'
    ) {
      Some(number);
    } else {
      None;
    };
    }
  };
};

let phoneNumber = (text) =>
  switch (collectDigits(text, 0, "")) {
  | None => None
  | Some(digits) => validNanp(digits)
  };
