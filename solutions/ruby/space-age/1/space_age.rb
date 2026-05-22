class SpaceAge
  ORBITAL_PERIODS = {
    mercury: 0.2408467,
    venus: 0.61519726,
    earth: 1.0,
    mars: 1.8808158,
    jupiter: 11.862615,
    saturn: 29.447498,
    uranus: 84.016846,
    neptune: 164.79132
  }.freeze

  EARTH_YEAR_IN_SECONDS = 31557600

  def initialize(seconds)
    @seconds = seconds
  end

  def method_missing(method_name, *args)
    if method_name.to_s.start_with?("on_")
      planet = method_name.to_s.sub("on_", "").to_sym
      return age_on(planet)
    end
    super
  end

  def respond_to_missing?(method_name, include_private = false)
    method_name.to_s.start_with?("on_") || super
  end

  def age_on(planet)
    @seconds / (EARTH_YEAR_IN_SECONDS * ORBITAL_PERIODS[planet])
  end
end
