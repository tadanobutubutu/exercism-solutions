pub fn encode(n: u64) -> String {
    const SMALL: [&str; 20] = [
        "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
        "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen",
        "eighteen", "nineteen",
    ];
    const TENS: [&str; 10] = ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"];
    const SCALES: [&str; 7] = ["", "thousand", "million", "billion", "trillion", "quadrillion", "quintillion"];

    fn under_thousand(number: u16) -> String {
        match number {
            0..=19 => SMALL[number as usize].to_string(),
            20..=99 => {
                let tens = TENS[(number / 10) as usize];
                let ones = number % 10;
                if ones == 0 { tens.to_string() } else { format!("{tens}-{}", SMALL[ones as usize]) }
            }
            _ => {
                let hundreds = SMALL[(number / 100) as usize];
                let remainder = number % 100;
                if remainder == 0 { format!("{hundreds} hundred") }
                else { format!("{hundreds} hundred {}", under_thousand(remainder)) }
            }
        }
    }

    if n == 0 { return "zero".to_string(); }
    let mut number = n;
    let mut groups = Vec::new();
    let mut scale = 0;
    while number > 0 {
        let group = (number % 1000) as u16;
        if group > 0 {
            let words = under_thousand(group);
            groups.push(if SCALES[scale].is_empty() { words } else { format!("{words} {}", SCALES[scale]) });
        }
        number /= 1000;
        scale += 1;
    }
    groups.reverse();
    groups.join(" ")
}
