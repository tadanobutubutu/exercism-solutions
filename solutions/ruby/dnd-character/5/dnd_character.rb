=begin
Write your code for the 'D&D Character' exercise in this file. Make the tests in
`dnd_character_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/dnd-character` directory.
=end

class DndCharacter
  attr_reader :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma, :hitpoints

  def self.modifier(score)
    ((score - 10) / 2.0).floor
  end

  def self.ability
    4.times.map { rand(1..6) }.sort.drop(1).sum
  end

  def initialize
    @strength = self.class.ability
    @dexterity = self.class.ability
    @constitution = self.class.ability
    @intelligence = self.class.ability
    @wisdom = self.class.ability
    @charisma = self.class.ability
    @hitpoints = 10 + self.class.modifier(@constitution)
  end
end
