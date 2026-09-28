pub struct Matrix {
    grid: Vec<Vec<u32>>,
}

impl Matrix {
    pub fn new(input: &str) -> Self {
        let grid = input
            .lines()
            .map(|line| {
                line.split_whitespace()
                    .map(|number| number.parse::<u32>().unwrap())
                    .collect()
            })
            .collect();

        Self { grid }
    }

    pub fn row(&self, row_no: usize) -> Option<Vec<u32>> {
        self.grid
            .get(row_no.checked_sub(1)?)
            .map(|row| row.to_owned())
    }

    pub fn column(&self, col_no: usize) -> Option<Vec<u32>> {
        if self.grid.is_empty() {
            return None;
        }
        let col = col_no.checked_sub(1)?;
        self.grid
            .iter()
            .map(|row| row.get(col).copied())
            .collect()
    }
}
