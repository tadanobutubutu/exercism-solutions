class RotationalCipher
  def self.rotate(text, shift)
    lower = ('a'..'z').to_a
    upper = ('A'..'Z').to_a
    rotated = lower.rotate(shift % 26).join + upper.rotate(shift % 26).join
    text.tr('a-zA-Z', rotated)
  end
end
