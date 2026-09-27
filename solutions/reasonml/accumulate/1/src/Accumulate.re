let rec accumulate = (operation, collection) =>
  switch (collection) {
  | [] => []
  | [head, ...tail] => [operation(head), ...accumulate(operation, tail)]
  };
