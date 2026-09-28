#[derive(Debug)]
pub struct HighScores {
    scores: Vec<u32>,
}

impl HighScores {
    pub fn new(scores: &[u32]) -> Self {
        Self {
            scores: scores.to_vec(),
        }
    }

    pub fn scores(&self) -> &[u32] {
        &self.scores
    }

    pub fn latest(&self) -> Option<u32> {
        self.scores.last().copied()
    }

    pub fn personal_best(&self) -> Option<u32> {
        self.scores.iter().copied().max()
    }

    pub fn personal_top_three(&self) -> Vec<u32> {
        let mut top_scores = self.scores.clone();
        top_scores.sort_unstable_by(|left, right| right.cmp(left));
        top_scores.truncate(3);
        top_scores
    }
}
