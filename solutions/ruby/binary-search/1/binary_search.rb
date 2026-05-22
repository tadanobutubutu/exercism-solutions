class BinarySearch
  def initialize(array)
    @array = array
  end

  def search(value)
    low = 0
    high = @array.length - 1
    
    while low <= high
      mid = (low + high) / 2
      if @array[mid] == value
        return mid
      elsif @array[mid] < value
        low = mid + 1
      else
        high = mid - 1
      end
    end
    nil
  end
  
  alias_method :search_for, :search
end
