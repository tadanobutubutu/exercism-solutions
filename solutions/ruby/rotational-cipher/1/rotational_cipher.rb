class RotationalCipher
  def self.rotate(text, shift)
    text.tr("a-zA-Z", build_alphabet(shift))
  end

  def self.build_alphabet(shift)
    lower = ("a".."z").to_a
    upper = ("A".."Z").to_a
    shifted_lower = lower.rotate(shift)
    shifted_upper = upper.rotate(shift)
    "#{lower.join}#{upper.join}#{shifted_lower.join}#{shifted_upper.join}"
  end
end
