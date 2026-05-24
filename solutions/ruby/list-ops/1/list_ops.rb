class ListOps
  def self.arrays(arr)
    count = 0
    arr.each { count += 1 }
    count
  end

  def self.reverser(arr)
    result = []
    arr.each { |e| result.unshift(e) }
    result
  end

  def self.concatter(arr1, arr2)
    result = []
    arr1.each { |e| result << e }
    arr2.each { |e| result << e }
    result
  end

  def self.mapper(arr)
    result = []
    arr.each { |e| result << (block_given? ? yield(e) : e) }
    result
  end

  def self.filterer(arr)
    result = []
    arr.each { |e| result << e if block_given? && yield(e) }
    result
  end

  def self.sum_reducer(arr)
    total = 0
    arr.each { |e| total += e }
    total
  end

  def self.factorial_reducer(arr)
    result = 1
    arr.each { |e| result *= e }
    result
  end
end
