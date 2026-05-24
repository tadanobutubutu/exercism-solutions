class Transpose
  def self.transpose(input)
    return "" if input.empty?
    lines = input.split("\n")
    max_length = lines.map(&:length).max
    max_length.times.map do |i|
      chars = lines.map { |l| i < l.length ? l[i] : nil }
      last_real = chars.rindex { |c| !c.nil? }
      chars[0..last_real].map { |c| c.nil? ? " " : c }.join
    end.join("\n")
  end
end
