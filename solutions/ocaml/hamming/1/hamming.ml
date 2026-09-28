type nucleotide = A | C | G | T

let hamming_distance left right =
  let rec count differences left right =
    match left, right with
    | [], [] -> Ok differences
    | a :: left_tail, b :: right_tail ->
        count (differences + if a = b then 0 else 1) left_tail right_tail
    | _ -> Error "strands must be of equal length"
  in
  count 0 left right
