let rec isShouting = (message, index, hasUpper, hasLower) =>
  if (index >= String.length(message)) {
    hasUpper && !hasLower;
  } else {
    let character = String.get(message, index);
    let upper = character >= 'A' && character <= 'Z';
    let lower = character >= 'a' && character <= 'z';
    isShouting(message, index + 1, hasUpper || upper, hasLower || lower);
  };

let hey = (remark) => {
  let message = String.trim(remark);
  let length = String.length(message);
  let silence = length == 0;
  let question = length > 0 && String.get(message, length - 1) == '?';
  let shouting = isShouting(message, 0, false, false);

  if (silence) {
    "Fine. Be that way!";
  } else if (shouting && question) {
    "Calm down, I know what I'm doing!";
  } else if (shouting) {
    "Whoa, chill out!";
  } else if (question) {
    "Sure.";
  } else {
    "Whatever.";
  };
};
