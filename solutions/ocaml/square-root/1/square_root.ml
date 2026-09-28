let square_root number =
  if number <= 1 then max 0 number
  else
    let rec search low high =
      if low > high then high
      else
        let middle = low + (high - low) / 2 in
        if middle <= number / middle then search (middle + 1) high
        else search low (middle - 1)
    in
    search 1 number
