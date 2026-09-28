let reverse_string input =
  String.init (String.length input) (fun index ->
      input.[String.length input - index - 1])
