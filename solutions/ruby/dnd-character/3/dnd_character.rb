class DndCharacter
  attr_reader :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma, :hitpoints

  def self.modifier(score)
    ((score - 10) / 2.0).floor
  end

  def initialize
    @strength = roll_dice
    @dexterity = roll_dice
    @constitution = roll_dice
    @intelligence = roll_dice
    @wisdom = roll_dice
    @charisma = roll_dice
    @hitpoints = 10 + self.class.modifier(@constitution)
  end

  private

  def roll_dice
    Array.new(4) { rand(1..6) }.sort.last(3).sum
  end
end
