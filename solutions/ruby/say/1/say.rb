class Say
  def initialize(number)
    @number = number
  end

  def in_english
    raise ArgumentError if @number < 0 || @number >= 1_000_000_000_000
    return 'zero' if @number == 0

    result = ''
    chunks = chunk_number(@number)
    chunks.each_with_index.reverse_each do |chunk, i|
      next if chunk == 0
      result << ' ' unless result.empty?
      result << under_1000(chunk)
      result << " #{SCALE[i]}" if SCALE[i]
    end
    result
  end

  private

  SCALE = [nil, 'thousand', 'million', 'billion']

  def chunk_number(n)
    chunks = []
    while n > 0
      chunks << n % 1000
      n /= 1000
    end
    chunks
  end

  def under_1000(n)
    result = ''
    if n >= 100
      result << "#{ONES[n / 100]} hundred"
      n %= 100
      result << ' ' if n > 0
    end
    if n >= 20
      result << TENS[n / 10]
      n %= 10
      result << '-' if n > 0
    elsif n >= 10
      result << (n == 10 ? 'ten' : TEENS[n - 10])
      n = 0
    end
    if n > 0
      result << ONES[n]
    end
    result
  end

  ONES = [nil, 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
  TEENS = [nil, 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen']
  TENS = [nil, 'ten', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety']
end
