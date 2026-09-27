let twoFer = (name) => {
  let person =
    switch (name) {
    | Some(value) => value
    | None => "you"
    };
  "One for " ++ person ++ ", one for me.";
};
