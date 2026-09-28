use std::collections::HashMap;

const UNASSIGNED: u8 = u8::MAX;

struct Solver {
    columns: Vec<Vec<(u8, u64)>>,
    result: Vec<u8>,
    leading: [bool; 26],
    assignment: [u8; 26],
    used_digits: u16,
}

impl Solver {
    fn solve_column(&mut self, column: usize, carry: u64) -> bool {
        if column == self.columns.len() {
            return carry == 0;
        }
        self.assign_column_letters(column, 0, carry)
    }

    fn assign_column_letters(&mut self, column: usize, index: usize, total: u64) -> bool {
        if index == self.columns[column].len() {
            let expected = (total % 10) as u8;
            let next_carry = total / 10;

            return match self.result.get(column).copied() {
                Some(letter) => {
                    let assigned = self.assignment[letter as usize];
                    if assigned != UNASSIGNED {
                        assigned == expected && self.solve_column(column + 1, next_carry)
                    } else if self.used_digits & (1 << expected) != 0
                        || (expected == 0 && self.leading[letter as usize])
                    {
                        false
                    } else {
                        self.assignment[letter as usize] = expected;
                        self.used_digits |= 1 << expected;
                        let solved = self.solve_column(column + 1, next_carry);
                        if !solved {
                            self.assignment[letter as usize] = UNASSIGNED;
                            self.used_digits &= !(1 << expected);
                        }
                        solved
                    }
                }
                None => expected == 0 && self.solve_column(column + 1, next_carry),
            };
        }

        let (letter, multiplicity) = self.columns[column][index];
        let assigned = self.assignment[letter as usize];
        if assigned != UNASSIGNED {
            return self.assign_column_letters(
                column,
                index + 1,
                total + multiplicity * u64::from(assigned),
            );
        }

        for digit in 0..=9_u8 {
            if self.used_digits & (1 << digit) != 0
                || (digit == 0 && self.leading[letter as usize])
            {
                continue;
            }
            self.assignment[letter as usize] = digit;
            self.used_digits |= 1 << digit;
            if self.assign_column_letters(
                column,
                index + 1,
                total + multiplicity * u64::from(digit),
            ) {
                return true;
            }
            self.assignment[letter as usize] = UNASSIGNED;
            self.used_digits &= !(1 << digit);
        }
        false
    }
}

pub fn solve(input: &str) -> Option<HashMap<char, u8>> {
    let (addends, result) = input.split_once("==")?;
    let addends = addends
        .split('+')
        .map(str::trim)
        .collect::<Vec<_>>();
    let result = result.trim();
    if addends.is_empty() || result.is_empty() {
        return None;
    }

    let mut leading = [false; 26];
    let mut unique_letters = [false; 26];
    let mut max_columns = result.len();
    let mut addend_bytes = Vec::with_capacity(addends.len());
    for word in addends.iter().copied().chain(std::iter::once(result)) {
        if word.is_empty() || !word.bytes().all(|byte| byte.is_ascii_uppercase()) {
            return None;
        }
        max_columns = max_columns.max(word.len());
        let bytes = word.bytes().map(|byte| byte - b'A').collect::<Vec<_>>();
        if bytes.len() > 1 {
            leading[bytes[0] as usize] = true;
        }
        for &letter in &bytes {
            unique_letters[letter as usize] = true;
        }
        addend_bytes.push(bytes);
    }

    let letters = unique_letters.iter().filter(|&&used| used).count();
    if letters > 10 {
        return None;
    }

    let result = addend_bytes.pop()?;
    let mut columns = vec![HashMap::<u8, u64>::new(); max_columns];
    for word in addend_bytes {
        for (column, letter) in word.iter().rev().copied().enumerate() {
            *columns[column].entry(letter).or_default() += 1;
        }
    }

    let mut solver = Solver {
        columns: columns
            .into_iter()
            .map(|column| {
                let mut letters = column.into_iter().collect::<Vec<_>>();
                letters.sort_unstable_by_key(|&(letter, _)| letter);
                letters
            })
            .collect(),
        result: result.into_iter().rev().collect(),
        leading,
        assignment: [UNASSIGNED; 26],
        used_digits: 0,
    };

    if !solver.solve_column(0, 0) {
        return None;
    }

    Some(
        unique_letters
            .iter()
            .enumerate()
            .filter(|(_, used)| **used)
            .map(|(letter, _)| ((b'A' + letter as u8) as char, solver.assignment[letter]))
            .collect(),
    )
}
