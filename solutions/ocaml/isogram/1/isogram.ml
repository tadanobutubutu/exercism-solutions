let is_isogram (word: string) : bool =
  let seen = Array.make 26 false in
  let valid = ref true in
  String.iter
    (fun character ->
      let index =
        if character >= 'a' && character <= 'z' then
          Char.code character - Char.code 'a'
        else if character >= 'A' && character <= 'Z' then
          Char.code character - Char.code 'A'
        else -1
      in
      if index >= 0 then
        if seen.(index) then valid := false else seen.(index) <- true)
    word;
  !valid
