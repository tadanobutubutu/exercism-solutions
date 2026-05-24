class Allergies
  ITEMS = %w[eggs peanuts shellfish strawberries tomatoes chocolate pollen cats]

  def initialize(score)
    @score = score
  end

  def allergic_to?(item)
    idx = ITEMS.index(item)
    @score & (1 << idx) != 0
  end

  def list
    ITEMS.select { |item| allergic_to?(item) }
  end
end
