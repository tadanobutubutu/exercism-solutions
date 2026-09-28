#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    NotEnoughPinsLeft,
    GameComplete,
}

pub struct BowlingGame {
    rolls: Vec<u16>,
}

impl BowlingGame {
    pub fn new() -> Self {
        Self { rolls: Vec::new() }
    }

    pub fn roll(&mut self, pins: u16) -> Result<(), Error> {
        if game_complete(&self.rolls) {
            return Err(Error::GameComplete);
        }
        if pins > 10 {
            return Err(Error::NotEnoughPinsLeft);
        }

        let (frame, start) = current_frame(&self.rolls);
        if frame < 9 {
            if self.rolls.len() > start && self.rolls[start] + pins > 10 {
                return Err(Error::NotEnoughPinsLeft);
            }
        } else if self.rolls.len() > start {
            let first = self.rolls[start];
            if first == 10 {
                if self.rolls.len() > start + 1 {
                    let bonus_one = self.rolls[start + 1];
                    if bonus_one < 10 && bonus_one + pins > 10 {
                        return Err(Error::NotEnoughPinsLeft);
                    }
                }
            } else if self.rolls.len() == start + 1 && self.rolls[start] + pins > 10 {
                return Err(Error::NotEnoughPinsLeft);
            }
        }

        self.rolls.push(pins);
        Ok(())
    }

    pub fn score(&self) -> Option<u16> {
        if !game_complete(&self.rolls) {
            return None;
        }

        let mut total = 0;
        let mut roll = 0;
        for _ in 0..10 {
            if self.rolls[roll] == 10 {
                total += 10 + self.rolls[roll + 1] + self.rolls[roll + 2];
                roll += 1;
            } else {
                let frame_score = self.rolls[roll] + self.rolls[roll + 1];
                if frame_score == 10 {
                    total += 10 + self.rolls[roll + 2];
                } else {
                    total += frame_score;
                }
                roll += 2;
            }
        }
        Some(total)
    }
}

fn current_frame(rolls: &[u16]) -> (usize, usize) {
    let mut index = 0;
    for frame in 0..9 {
        if index >= rolls.len() {
            return (frame, index);
        }
        if rolls[index] == 10 {
            index += 1;
        } else if index + 1 < rolls.len() {
            index += 2;
        } else {
            return (frame, index);
        }
    }
    (9, index)
}

fn game_complete(rolls: &[u16]) -> bool {
    let mut index = 0;
    for _ in 0..9 {
        if index >= rolls.len() {
            return false;
        }
        if rolls[index] == 10 {
            index += 1;
        } else {
            if index + 1 >= rolls.len() {
                return false;
            }
            index += 2;
        }
    }

    if index >= rolls.len() {
        return false;
    }
    let first = rolls[index];
    if first == 10 {
        rolls.len() >= index + 3
    } else if index + 1 >= rolls.len() {
        false
    } else if first + rolls[index + 1] == 10 {
        rolls.len() >= index + 3
    } else {
        true
    }
}
