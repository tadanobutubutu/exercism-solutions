open Base

let empty = Map.empty (module Char)

let nucleotides = ['A'; 'C'; 'G'; 'T']

let invalid_nucleotide s =
  String.find s ~f:(fun nucleotide ->
      not (List.mem nucleotides nucleotide ~equal:Char.equal))

let count_nucleotide s c =
  if not (List.mem nucleotides c ~equal:Char.equal) then Error c
  else
    match invalid_nucleotide s with
    | Some invalid -> Error invalid
    | None ->
        Ok
          (String.fold s ~init:0 ~f:(fun count nucleotide ->
               if Char.equal nucleotide c then count + 1 else count))

let count_nucleotides s =
  match invalid_nucleotide s with
  | Some invalid -> Error invalid
  | None ->
      Ok
        (String.fold s ~init:empty ~f:(fun counts nucleotide ->
             Map.update counts nucleotide ~f:(function
                 | None -> 1
                 | Some count -> count + 1)))
