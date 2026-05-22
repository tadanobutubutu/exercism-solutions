class ResistorColorTrio
  COLORS = %w[black brown red orange yellow green blue violet grey white].freeze

  def initialize(colors)
    @colors = colors
  end

  def label
    color1, color2, color3 = @colors
    value = (COLORS.index(color1) * 10 + COLORS.index(color2)) * (10**COLORS.index(color3))
    
    label_value = value
    unit = "ohms"
    
    if value >= 1_000_000_000
      label_value = value / 1_000_000_000
      unit = "gigaohms"
    elsif value >= 1_000_000
      label_value = value / 1_000_000
      unit = "megaohms"
    elsif value >= 1_000
      label_value = value / 1_000
      unit = "kiloohms"
    end
    
    "Resistor value: #{label_value} #{unit}"
  end
end
