let raindrop number =
  let sounds =
    (if number mod 3 = 0 then ["Pling"] else [])
    @ (if number mod 5 = 0 then ["Plang"] else [])
    @ (if number mod 7 = 0 then ["Plong"] else [])
  in
  match sounds with
  | [] -> string_of_int number
  | _ -> String.concat "" sounds
