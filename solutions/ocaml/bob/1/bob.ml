let response_for message =
  let message = String.trim message in
  let has_letter = ref false in
  let has_lowercase = ref false in
  String.iter
    (fun character ->
      if character >= 'A' && character <= 'Z' then has_letter := true
      else if character >= 'a' && character <= 'z' then (
        has_letter := true;
        has_lowercase := true))
    message;
  let shouting = !has_letter && not !has_lowercase in
  let question =
    String.length message > 0 && message.[String.length message - 1] = '?'
  in
  if String.length message = 0 then "Fine. Be that way!"
  else if shouting && question then "Calm down, I know what I'm doing!"
  else if shouting then "Whoa, chill out!"
  else if question then "Sure."
  else "Whatever."
