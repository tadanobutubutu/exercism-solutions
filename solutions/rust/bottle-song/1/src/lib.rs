pub fn recite(start_bottles: u32, take_down: u32) -> String {
    fn number_word(value: u32) -> &'static str {
        match value {
            0 => "no",
            1 => "one",
            2 => "two",
            3 => "three",
            4 => "four",
            5 => "five",
            6 => "six",
            7 => "seven",
            8 => "eight",
            9 => "nine",
            10 => "ten",
            _ => "many",
        }
    }

    (0..take_down)
        .map(|offset| {
            let bottles = start_bottles.saturating_sub(offset);
            let next = bottles.saturating_sub(1);
            let current_word = number_word(bottles);
            let current_word = format!("{}{}", current_word[..1].to_uppercase(), &current_word[1..]);
            let current_noun = if bottles == 1 { "bottle" } else { "bottles" };
            let next_noun = if next == 1 { "bottle" } else { "bottles" };
            format!(
                "{current_word} green {current_noun} hanging on the wall,\n\
                 {current_word} green {current_noun} hanging on the wall,\n\
                 And if one green bottle should accidentally fall,\n\
                 There'll be {} green {next_noun} hanging on the wall.",
                number_word(next)
            )
        })
        .collect::<Vec<_>>()
        .join("\n\n")
}
