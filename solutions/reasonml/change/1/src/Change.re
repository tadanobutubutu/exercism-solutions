type coins = list(int);

let rec chooseCoin = (coins, value, bestCount, bestCoin, counts) =>
  switch (coins) {
  | [] => (bestCount, bestCoin)
  | [coin, ...tail] =>
    if (coin <= 0 || coin > value) {
      chooseCoin(tail, value, bestCount, bestCoin, counts);
    } else {
      let previousCount = Array.get(counts, value - coin);
      if (previousCount + 1 < bestCount) {
        chooseCoin(tail, value, previousCount + 1, coin, counts);
      } else {
        chooseCoin(tail, value, bestCount, bestCoin, counts);
      }
    }
  };

let rec fillCounts = (value, amount, coins, counts, previous) =>
  if (value > amount) {
    ();
  } else {
    let (count, coin) = chooseCoin(coins, value, amount + 1, 0, counts);
    Array.set(counts, value, count);
    Array.set(previous, value, coin);
    fillCounts(value + 1, amount, coins, counts, previous);
  };

let rec insertSorted = (coin, result) =>
  switch (result) {
  | [] => [coin]
  | [head, ...tail] =>
    if (coin <= head) {
      [coin, head, ...tail];
    } else {
      [head, ...insertSorted(coin, tail)];
    }
  };

let rec buildChange = (value, previous, result) =>
  if (value == 0) {
    Some(result);
  } else {
    let coin = Array.get(previous, value);
    if (coin <= 0 || coin > value) {
      None;
    } else {
      buildChange(value - coin, previous, insertSorted(coin, result));
    }
  };

let makeChange = (amount, coins) =>
  if (amount < 0) {
    None;
  } else if (amount == 0) {
    Some([]);
  } else {
    let counts = Array.make(amount + 1, amount + 1);
    let previous = Array.make(amount + 1, 0);
    Array.set(counts, 0, 0);
    fillCounts(1, amount, coins, counts, previous);
    if (Array.get(counts, amount) > amount) {
      None;
    } else {
      buildChange(amount, previous, []);
    };
  };
