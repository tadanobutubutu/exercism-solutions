let two_fer name =
  let name = Option.value name ~default:"you" in
  "One for " ^ name ^ ", one for me."
