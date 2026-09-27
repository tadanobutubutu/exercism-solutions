let isLetterOrDigit = (character) =>
  (character >= 'A' && character <= 'Z')
  || (character >= 'a' && character <= 'z')
  || (character >= '0' && character <= '9');

let flush = (current, words) =>
  if (String.length(current) == 0) {words} else {[current, ...words]};

let rec tokenize = (text, index, current, words) =>
  if (index >= String.length(text)) {
    List.rev(flush(current, words));
  } else {
    let character = String.get(text, index);
    if (isLetterOrDigit(character)) {
      let normalized = String.make(1, Char.lowercase_ascii(character));
      tokenize(text, index + 1, current ++ normalized, words);
    } else if (
      character == '\''
      && String.length(current) > 0
      && index + 1 < String.length(text)
      && isLetterOrDigit(String.get(text, index + 1))
    ) {
      tokenize(text, index + 1, current ++ "'", words);
    } else {
      tokenize(text, index + 1, "", flush(current, words));
    };
  };

let rec countWords = (words, counts) =>
  switch (words) {
  | [] => counts
  | [word, ...tail] => {
      let nextCount =
        switch (Js.Dict.get(counts, word)) {
        | Some(count) => count + 1
        | None => 1
        };
      Js.Dict.set(counts, word, nextCount);
      countWords(tail, counts);
    }
  };

let wordCount = (text) =>
  countWords(tokenize(text, 0, "", []), Js.Dict.empty());
