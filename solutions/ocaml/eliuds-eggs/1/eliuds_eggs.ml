let egg_count number =
  let rec count remaining total =
    if remaining = 0 then total
    else count (remaining land (remaining - 1)) (total + 1)
  in
  count number 0
