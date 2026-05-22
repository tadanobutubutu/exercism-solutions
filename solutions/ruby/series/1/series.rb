class Series
  def initialize(series)
    raise ArgumentError if series.empty?
    @series = series
  end

  def slices(length)
    raise ArgumentError if length <= 0 || length > @series.length
    @series.chars.each_cons(length).map(&:join)
  end
end
