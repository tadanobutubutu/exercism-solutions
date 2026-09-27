let isLetter = (character) =>
  (character >= 'A' && character <= 'Z')
  || (character >= 'a' && character <= 'z');

let isSeparator = (character) =>
  character == ' ' || character == '\t' || character == '\n'
  || character == '\r' || character == '-';

let rec collect = (phrase, index, atWordStart, acronym) =>
  if (index >= String.length(phrase)) {
    acronym;
  } else {
    let character = String.get(phrase, index);
    if (isSeparator(character)) {
      collect(phrase, index + 1, true, acronym);
    } else if (atWordStart && isLetter(character)) {
      let initial = String.uppercase_ascii(String.sub(phrase, index, 1));
      collect(phrase, index + 1, false, acronym ++ initial);
    } else if (atWordStart) {
      collect(phrase, index + 1, true, acronym);
    } else {
      collect(phrase, index + 1, false, acronym);
    };
  };

let abbreviate = (phrase) => collect(phrase, 0, true, "");
