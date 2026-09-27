let appendRun = (character, count) =>
  (if (count > 1) {string_of_int(count)} else {""})
  ++ String.make(1, character);

let rec encodeFrom = (input, index, character, count, output) =>
  if (index >= String.length(input)) {
    if (count == 0) {output} else {output ++ appendRun(character, count)};
  } else {
    let nextCharacter = String.get(input, index);
    if (count == 0) {
      encodeFrom(input, index + 1, nextCharacter, 1, output);
    } else if (nextCharacter == character) {
      encodeFrom(input, index + 1, character, count + 1, output);
    } else {
      encodeFrom(
        input,
        index + 1,
        nextCharacter,
        1,
        output ++ appendRun(character, count),
      );
    };
  };

let encode = (input) => encodeFrom(input, 0, ' ', 0, "");

let isDigit = (character) => character >= '0' && character <= '9';

let rec repeatCharacter = (character, count, output) =>
  if (count <= 0) {
    output;
  } else {
    repeatCharacter(character, count - 1, output ++ String.make(1, character));
  };

let rec decodeFrom = (input, index, count, output) =>
  if (index >= String.length(input)) {
    output;
  } else {
    let character = String.get(input, index);
    if (isDigit(character)) {
      let digit = Char.code(character) - Char.code('0');
      decodeFrom(input, index + 1, count * 10 + digit, output);
    } else {
      let repetitions = if (count == 0) {1} else {count};
      let expanded = repeatCharacter(character, repetitions, "");
      decodeFrom(input, index + 1, 0, output ++ expanded);
    };
  };

let decode = (input) => decodeFrom(input, 0, 0, "");
