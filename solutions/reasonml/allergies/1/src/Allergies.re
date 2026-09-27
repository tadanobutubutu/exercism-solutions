let allergens = [
  ("eggs", 1),
  ("peanuts", 2),
  ("shellfish", 4),
  ("strawberries", 8),
  ("tomatoes", 16),
  ("chocolate", 32),
  ("pollen", 64),
  ("cats", 128),
];

let rec allergenValue = (item, items) =>
  switch (items) {
  | [] => None
  | [(name, value), ...tail] =>
    if (item == name) {
      Some(value);
    } else {
      allergenValue(item, tail);
    }
  };

let isAllergicTo = (item, score) =>
  switch (allergenValue(item, allergens)) {
  | None => false
  | Some(value) => score / value mod 2 == 1
  };

let rec collectAllergies = (items, score, result) =>
  switch (items) {
  | [] => List.rev(result)
  | [(name, value), ...tail] =>
    if (score / value mod 2 == 1) {
      collectAllergies(tail, score, [name, ...result]);
    } else {
      collectAllergies(tail, score, result);
    }
  };

let toList = (score) => collectAllergies(allergens, score, []);
