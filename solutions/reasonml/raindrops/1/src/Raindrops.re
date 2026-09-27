let raindrops = (number) => {
  let sounds =
    (if (number mod 3 == 0) {"Pling"} else {""})
    ++ (if (number mod 5 == 0) {"Plang"} else {""})
    ++ (if (number mod 7 == 0) {"Plong"} else {""});
  if (sounds == "") {string_of_int(number)} else {sounds};
};
