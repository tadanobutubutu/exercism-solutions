let rec append = (first, second) =>
  switch (first) {
  | [] => second
  | [head, ...tail] => [head, ...append(tail, second)]
  };

let rec concat = (lists) =>
  switch (lists) {
  | [] => []
  | [head, ...tail] => append(head, concat(tail))
  };

let rec filter = (items, predicate) =>
  switch (items) {
  | [] => []
  | [head, ...tail] =>
    if (predicate(head)) {
      [head, ...filter(tail, predicate)];
    } else {
      filter(tail, predicate);
    }
  };

let rec length = (items) =>
  switch (items) {
  | [] => 0
  | [_, ...tail] => 1 + length(tail)
  };

let rec map = (items, operation) =>
  switch (items) {
  | [] => []
  | [head, ...tail] => [operation(head), ...map(tail, operation)]
  };

let rec foldl = (items, accumulator, operation) =>
  switch (items) {
  | [] => accumulator
  | [head, ...tail] => foldl(tail, operation(accumulator, head), operation)
  };

let rec foldr = (items, accumulator, operation) =>
  switch (items) {
  | [] => accumulator
  | [head, ...tail] => operation(foldr(tail, accumulator, operation), head)
  };

let rec reverseWithAccumulator = (items, reversed) =>
  switch (items) {
  | [] => reversed
  | [head, ...tail] => reverseWithAccumulator(tail, [head, ...reversed])
  };

let reverse = (items) => reverseWithAccumulator(items, []);
