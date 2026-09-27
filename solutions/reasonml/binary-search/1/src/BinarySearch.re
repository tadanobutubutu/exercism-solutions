let rec search = (values, target, low, high) =>
  if (low > high) {
    None;
  } else {
    let middle = low + (high - low) / 2;
    let value = Array.get(values, middle);
    if (value == target) {
      Some(middle);
    } else if (value < target) {
      search(values, target, middle + 1, high);
    } else {
      search(values, target, low, middle - 1);
    };
  };

let find = (values, target) =>
  search(values, target, 0, Array.length(values) - 1);
