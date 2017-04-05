# binary search with recursion
def binary_search(array, value, lower = 0, upper = nil)
  upper = array.count - 1 unless upper

  return "No value in array" if lower > upper

  mid = (lower + upper) / 2

  if value < array[mid]
    return binary_search(array, value, lower, mid - 1)
  elsif value > array[mid]
    return binary_search(array, value, mid + 1, upper)
  else
    return mid
  end
end

# binary serach without recursion
def binary_search_with_while(array, value)
  lower = 0
  upper = array.length - 1

  while lower <= upper do
    mid = (lower + upper) / 2

    if value < array[mid]
      upper = mid - 1
    elsif value > array[mid]
      lower = mid + 1
    elsif value == array[mid]
      return mid
    end
  end

  return "suck"
end

puts binary_search([1,2,3,4,5], 6)
puts binary_search_with_while([10,20,40,50], 50)