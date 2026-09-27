let normalized = (word) => String.lowercase_ascii(word);

let rec countLetter = (word, letter, index, count) =>
  if (index >= String.length(word)) {
    count;
  } else {
    let current = Char.lowercase_ascii(String.get(word, index));
    countLetter(word, letter, index + 1, count + (if (current == letter) {1} else {0}));
  };

let rec sameLetterCounts = (target, candidate, index) =>
  if (index >= String.length(target)) {
    true;
  } else {
    let letter = Char.lowercase_ascii(String.get(target, index));
    countLetter(target, letter, 0, 0) == countLetter(candidate, letter, 0, 0)
    && sameLetterCounts(target, candidate, index + 1);
  };

let isAnagram = (target, candidate) => {
  let targetLower = normalized(target);
  let candidateLower = normalized(candidate);
  String.length(target) == String.length(candidate)
  && targetLower != candidateLower
  && sameLetterCounts(target, candidate, 0);
};

let rec collectAnagrams = (target, candidates, matches) =>
  switch (candidates) {
  | [] => List.rev(matches)
  | [candidate, ...tail] =>
    if (isAnagram(target, candidate)) {
      collectAnagrams(target, tail, [candidate, ...matches]);
    } else {
      collectAnagrams(target, tail, matches);
    }
  };

let anagrams = (target, candidates) => collectAnagrams(target, candidates, []);
