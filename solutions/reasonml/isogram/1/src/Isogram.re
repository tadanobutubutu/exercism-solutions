let isLetter = (character) =>
  (character >= 'A' && character <= 'Z')
  || (character >= 'a' && character <= 'z');

let rec scan = (phrase, index, seen) =>
  if (index >= String.length(phrase)) {
    true;
  } else {
    let character = String.get(phrase, index);
    if (!isLetter(character)) {
      scan(phrase, index + 1, seen);
    } else {
      let normalized = Char.lowercase_ascii(character);
      if (List.mem(normalized, seen)) {
        false;
      } else {
        scan(phrase, index + 1, [normalized, ...seen]);
      };
    };
  };

let is_isogram = (phrase) => scan(phrase, 0, []);
