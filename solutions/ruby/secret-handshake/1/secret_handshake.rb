class SecretHandshake
  ACTIONS = ['wink', 'double blink', 'close your eyes', 'jump']

  def initialize(code)
    @code = code
  end

  def commands
    return [] if @code < 1
    result = []
    ACTIONS.each_with_index do |action, i|
      result << action if @code & (1 << i) != 0
    end
    @code & 16 != 0 ? result.reverse : result
  end
end
