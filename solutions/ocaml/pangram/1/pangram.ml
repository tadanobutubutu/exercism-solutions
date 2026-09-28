let is_pangram sentence =
  let seen = Array.make 26 false in
  String.iter
    (fun character ->
      let index =
        if character >= 'a' && character <= 'z' then
          Char.code character - Char.code 'a'
        else if character >= 'A' && character <= 'Z' then
          Char.code character - Char.code 'A'
        else -1
      in
      if index >= 0 then seen.(index) <- true)
    sentence;
  Array.for_all Fun.id seen
