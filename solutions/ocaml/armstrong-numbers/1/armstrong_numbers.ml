let validate candidate =
  if candidate < 0 then false
  else
    let rec digit_count value =
      if value < 10 then 1 else 1 + digit_count (value / 10)
    in
    let digits = digit_count candidate in
    let rec bounded_power base exponent limit value =
      if exponent = 0 then Some value
      else if base <> 0 && value > limit / base then None
      else bounded_power base (exponent - 1) limit (value * base)
    in
    let rec sum_digits value total =
      if value = 0 then Some total
      else
        let digit = value mod 10 in
        match bounded_power digit digits (candidate - total) 1 with
        | None -> None
        | Some power -> sum_digits (value / 10) (total + power)
    in
    match sum_digits candidate 0 with
    | Some sum -> sum = candidate
    | None -> false
