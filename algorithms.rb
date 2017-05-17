# binary search with recursion
# def binary_search(array, value, lower = 0, upper = nil)
#   upper = array.count - 1 unless upper

#   return "No value in array" if lower > upper

#   mid = (lower + upper) / 2

#   if value < array[mid]
#     return binary_search(array, value, lower, mid - 1)
#   elsif value > array[mid]
#     return binary_search(array, value, mid + 1, upper)
#   else
#     return mid
#   end
# end

# binary serach without recursion
# def binary_search_with_while(array, value)
#   lower = 0
#   upper = array.length - 1

#   while lower <= upper do
#     mid = (lower + upper) / 2

#     if value < array[mid]
#       upper = mid - 1
#     elsif value > array[mid]
#       lower = mid + 1
#     elsif value == array[mid]
#       return mid
#     end
#   end

#   return "suck"
# end

# puts binary_search([1,2,3,4,5], 6)
# puts binary_search_with_while([10,20,40,50], 50)


# Given the string in form AAABBBCCCC compress it to
# A3B3C4. Should be case sensitive AAaa should be A2B2

def compress(string)
  l = string.size
  r = ""

  return r if l == 0
  return string if l == 1

  i, counter = 1, 1

  while i < l
    if string[i] == string[i-1]
      counter += 1
    else
      r << "#{string[i-1]}#{counter}"
      counter = 1
    end
    i += 1
  end
  
  r << "#{string[i-1]}#{counter}"
end

compressed = compress("AAABBCCCCCCC")
puts compressed

