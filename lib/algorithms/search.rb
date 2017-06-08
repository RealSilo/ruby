class Search
  # binary_serch with recursion
  def binary_search(array, value, from = 0, to = nil)
    to = array.count - 1 unless to

    return 'Value not in array' if from > to

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
    to = array.count - 1

    while from <= to
      mid = (from + to) / 2

      if value < array[mid]
        to = array[mid] - 1
      elsif value > array[mid]
        from = array[mid] + 1
      else
        return mid
      end
    end

    'Value not in array'
  end
end

# puts Search.new.binary_search([10, 20, 30, 40, 50], 60)
