pub struct Triangle {
    sides: [u64; 3],
}

impl Triangle {
    pub fn build(sides: [u64; 3]) -> Option<Triangle> {
        let mut sorted = sides;
        sorted.sort_unstable();
        if sorted[0] == 0 || (sorted[0] as u128 + sorted[1] as u128) <= sorted[2] as u128 {
            return None;
        }
        Some(Self { sides })
    }

    pub fn is_equilateral(&self) -> bool {
        self.sides[0] == self.sides[1] && self.sides[1] == self.sides[2]
    }

    pub fn is_scalene(&self) -> bool {
        self.sides[0] != self.sides[1]
            && self.sides[1] != self.sides[2]
            && self.sides[0] != self.sides[2]
    }

    pub fn is_isosceles(&self) -> bool {
        self.sides[0] == self.sides[1]
            || self.sides[1] == self.sides[2]
            || self.sides[0] == self.sides[2]
    }
}
