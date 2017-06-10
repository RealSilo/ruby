class Search
  # scenarios
  # if item is present:
  # best: O(1), avg: O(N/2), worst: O(N)
  # if item is NOT present
  # best, avg, worst: O(N)
  def unsorted_sequential_search(array, value)
    array.each_with_index do |element, i|
      return i if element == value
    end

    false
  end

  # scenarios
  # if item is present:
  # best: O(1), avg: O(N/2), worst: O(N)
  # if item is NOT present
  # best: O(1), avg: O(N/2), worst: O(N)
  def sorted_sequential_search(array, value)
    i = 0

    while i < array.length
      return i if array[i] == value
      return false if array[i] > value
      i += 1
    end

    false
  end

  # binary_serch with recursion
  def binary_search(array, value, from = 0, to = nil)
    to = array.count - 1 unless to

    return false if from > to

    mid = (from + to) / 2

    if value < array[mid]
      return binary_search(array, value, from, mid - 1)
    elsif value > array[mid]
      return binary_search(array, value, mid + 1, to)
    else
      return mid
    end
  end

  # binary search without recursion
  def binary_search_with_while(array, value)
    from = 0
    to = array.size - 1

    while from <= to
      mid = (from + to) / 2

      if array[mid] > value
        to = mid - 1
      elsif array[mid] < value
        from = mid + 1
      else
        return mid
      end
    end

    false
  end
end
