#[derive(Debug, PartialEq, Eq)]
pub struct Clock {
    minutes_since_midnight: i32,
}

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        let total = (i64::from(hours) * 60 + i64::from(minutes)).rem_euclid(24 * 60);
        Self {
            minutes_since_midnight: total as i32,
        }
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        let total = (i64::from(self.minutes_since_midnight) + i64::from(minutes))
            .rem_euclid(24 * 60);
        Self {
            minutes_since_midnight: total as i32,
        }
    }
}

impl std::fmt::Display for Clock {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "{:02}:{:02}",
            self.minutes_since_midnight / 60,
            self.minutes_since_midnight % 60
        )
    }
}
