pub struct Allergies {
    score: u32,
}

#[derive(Debug, PartialEq, Eq, Clone, Copy)]
pub enum Allergen {
    Eggs,
    Peanuts,
    Shellfish,
    Strawberries,
    Tomatoes,
    Chocolate,
    Pollen,
    Cats,
}

impl Allergies {
    pub fn new(score: u32) -> Self {
        Self { score }
    }

    pub fn is_allergic_to(&self, allergen: &Allergen) -> bool {
        let bit = match allergen {
            Allergen::Eggs => 0,
            Allergen::Peanuts => 1,
            Allergen::Shellfish => 2,
            Allergen::Strawberries => 3,
            Allergen::Tomatoes => 4,
            Allergen::Chocolate => 5,
            Allergen::Pollen => 6,
            Allergen::Cats => 7,
        };
        self.score & (1 << bit) != 0
    }

    pub fn allergies(&self) -> Vec<Allergen> {
        [
            Allergen::Eggs,
            Allergen::Peanuts,
            Allergen::Shellfish,
            Allergen::Strawberries,
            Allergen::Tomatoes,
            Allergen::Chocolate,
            Allergen::Pollen,
            Allergen::Cats,
        ]
        .into_iter()
        .filter(|allergen| self.is_allergic_to(allergen))
        .collect()
    }
}
