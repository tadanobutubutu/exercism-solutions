class ZebraPuzzle
  COLORS = %w[Red Green Ivory Yellow Blue].freeze
  NATIONS = %w[Englishman Spaniard Ukrainian Norwegian Japanese].freeze
  DRINKS = %w[Tea Coffee Milk OrangeJuice Water].freeze
  SMOKES = %w[OldGold Kools Chesterfield LuckyStrike Parliaments].freeze
  PETS = %w[Dog Snails Fox Horse Zebra].freeze

  def self.water_drinker
    (solve || {})[:water]
  end

  def self.zebra_owner
    (solve || {})[:zebra]
  end

  def self.solve
    COLORS.permutation.each do |colors|
      next unless colors.index('Green') == colors.index('Ivory') + 1

      NATIONS.permutation.each do |nations|
        next unless nations[0] == 'Norwegian'
        next unless nations[colors.index('Red')] == 'Englishman'
        next unless (nations.index('Norwegian') - colors.index('Blue')).abs == 1

        DRINKS.permutation.each do |drinks|
          next unless drinks[colors.index('Green')] == 'Coffee'
          next unless drinks[nations.index('Ukrainian')] == 'Tea'
          next unless drinks[2] == 'Milk'

          SMOKES.permutation.each do |smokes|
            next unless smokes[colors.index('Yellow')] == 'Kools'
            next unless smokes[nations.index('Japanese')] == 'Parliaments'
            next unless drinks[smokes.index('LuckyStrike')] == 'OrangeJuice'

            PETS.permutation.each do |pets|
              next unless pets[nations.index('Spaniard')] == 'Dog'
              next unless pets[smokes.index('OldGold')] == 'Snails'
              next unless (pets.index('Fox') - smokes.index('Chesterfield')).abs == 1
              next unless (pets.index('Horse') - smokes.index('Kools')).abs == 1

              water = nations[drinks.index('Water')]
              zebra = nations[pets.index('Zebra')]
              return { water: water, zebra: zebra }
            end
          end
        end
      end
    end
    nil
  end
end
