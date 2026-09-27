let letterValue = (letter) =>
  switch (Char.uppercase_ascii(letter)) {
  | 'D' | 'G' => 2
  | 'B' | 'C' | 'M' | 'P' => 3
  | 'F' | 'H' | 'V' | 'W' | 'Y' => 4
  | 'K' => 5
  | 'J' | 'X' => 8
  | 'Q' | 'Z' => 10
  | 'A' | 'E' | 'I' | 'O' | 'U' | 'L' | 'N' | 'R' | 'S' | 'T' => 1
  | _ => 0
  };

let rec sumLetters = (word, index) =>
  if (index >= String.length(word)) {
    0;
  } else {
    letterValue(String.get(word, index)) + sumLetters(word, index + 1);
  };

let score = (word) => sumLetters(word, 0);
