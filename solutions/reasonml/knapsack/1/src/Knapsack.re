open Item;

let rec updateCapacities = (item, currentCapacity, bestValues) =>
  if (currentCapacity < item.weight) {
    ();
  } else {
    let previousValue = Array.get(bestValues, currentCapacity - item.weight);
    let candidateValue = previousValue + item.value;
    if (candidateValue > Array.get(bestValues, currentCapacity)) {
      Array.set(bestValues, currentCapacity, candidateValue);
    };
    updateCapacities(item, currentCapacity - 1, bestValues);
  };

let rec processItems = (items, capacity, bestValues) =>
  switch (items) {
  | [] => ()
  | [item, ...remaining] => {
      updateCapacities(item, capacity, bestValues);
      processItems(remaining, capacity, bestValues);
    }
  };

let maximum_value = (items, capacity) =>
  if (capacity <= 0) {
    0;
  } else {
    let bestValues = Array.make(capacity + 1, 0);
    processItems(items, capacity, bestValues);
    Array.get(bestValues, capacity);
  };
