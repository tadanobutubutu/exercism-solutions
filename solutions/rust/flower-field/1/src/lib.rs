pub fn annotate(garden: &[&str]) -> Vec<String> {
    garden
        .iter()
        .enumerate()
        .map(|(row, line)| {
            let mut annotated = Vec::with_capacity(line.len());
            for (column, square) in line.bytes().enumerate() {
                if square == b'*' {
                    annotated.push(b'*');
                    continue;
                }

                let mut flowers = 0_u8;
                for adjacent_row in row.saturating_sub(1)..=(row + 1).min(garden.len() - 1) {
                    let start = column.saturating_sub(1);
                    let end = column + 1;
                    for adjacent_column in start..=end {
                        if (adjacent_row != row || adjacent_column != column)
                            && garden[adjacent_row].as_bytes().get(adjacent_column) == Some(&b'*')
                        {
                            flowers += 1;
                        }
                    }
                }
                annotated.push(if flowers == 0 { b' ' } else { b'0' + flowers });
            }
            String::from_utf8(annotated).expect("the garden uses ASCII")
        })
        .collect()
}
