pub struct PascalsTriangle {
    rows: Vec<Vec<u32>>,
}

impl PascalsTriangle {
    pub fn new(row_count: u32) -> Self {
        let mut rows: Vec<Vec<u32>> = Vec::with_capacity(row_count as usize);
        for row_index in 0..row_count as usize {
            let mut row = vec![1; row_index + 1];
            for column in 1..row_index {
                row[column] = rows[row_index - 1][column - 1] + rows[row_index - 1][column];
            }
            rows.push(row);
        }
        Self { rows }
    }

    pub fn rows(&self) -> Vec<Vec<u32>> {
        self.rows.clone()
    }
}
