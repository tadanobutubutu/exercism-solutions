module Port
  IDENTIFIER = :PALE

  def self.get_identifier(city)
    city[0, 4].upcase.to_sym
  end

  def self.get_terminal(ship_identifier)
    type = ship_identifier.to_s[0, 3]
    if type == "OIL" || type == "GAS"
      :A
    else
      :B
    end
  end
end
