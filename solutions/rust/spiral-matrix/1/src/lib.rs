pub fn spiral_matrix(size: u32) -> Vec<Vec<u32>> {
    let size = size as usize;
    let mut matrix = vec![vec![0; size]; size];
    if size == 0 {
        return matrix;
    }

    let (mut top, mut bottom) = (0, size - 1);
    let (mut left, mut right) = (0, size - 1);
    let mut value = 1;

    while top <= bottom && left <= right {
        for col in left..=right {
            matrix[top][col] = value;
            value += 1;
        }
        top += 1;
        if top > bottom {
            break;
        }

        for row in top..=bottom {
            matrix[row][right] = value;
            value += 1;
        }
        if right == 0 {
            break;
        }
        right -= 1;
        if left > right {
            break;
        }

        for col in (left..=right).rev() {
            matrix[bottom][col] = value;
            value += 1;
        }
        if bottom == 0 {
            break;
        }
        bottom -= 1;
        if top > bottom {
            break;
        }

        for row in (top..=bottom).rev() {
            matrix[row][left] = value;
            value += 1;
        }
        left += 1;
    }

    matrix
}
