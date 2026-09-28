pub fn find_saddle_points(input: &[Vec<u64>]) -> Vec<(usize, usize)> {
    let Some(first_row) = input.first() else {
        return Vec::new();
    };
    let columns = first_row.len();
    if columns == 0 {
        return Vec::new();
    }

    let column_minima: Vec<u64> = (0..columns)
        .map(|column| input.iter().map(|row| row[column]).min().unwrap())
        .collect();
    let mut points = Vec::new();
    for (row_index, row) in input.iter().enumerate() {
        let row_maximum = *row.iter().max().unwrap();
        for (column_index, &value) in row.iter().enumerate() {
            if value == row_maximum && value == column_minima[column_index] {
                points.push((row_index, column_index));
            }
        }
    }
    points
}
