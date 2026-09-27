let isLetter = (character) =>
  (character >= 'A' && character <= 'Z')
  || (character >= 'a' && character <= 'z');

let rec collectLetters = (sentence, index, seen) =>
  if (index >= String.length(sentence)) {
    seen;
  } else {
    let character = String.get(sentence, index);
    if (!isLetter(character)) {
      collectLetters(sentence, index + 1, seen);
    } else {
      let normalized = Char.lowercase_ascii(character);
      if (List.mem(normalized, seen)) {
        collectLetters(sentence, index + 1, seen);
      } else {
        collectLetters(sentence, index + 1, [normalized, ...seen]);
      };
    };
  };

let isPangram = (sentence) => List.length(collectLetters(sentence, 0, [])) == 26;
