# common big O cases:

# O(1)
# O(log n) -> binary search
# O(n) ->  simple linear search
# O(n * log n) -> sorting algorithms
# O(n2) -> nested loops
# O(2n) -> subsets
# O(n!) -> traveling salesman


#O(n) examples

# simple linear search with ordered array
# check if the value is in the array
def simple_linear_search(array, value)
  array.each do |element|
    return value if element == value
    break "Not in array" if element > value
  end
  "Not in array"
end

puts simple_linear_search([1,2,3,4,5,6,9,11,233,444,565,2345,5436], 9)
puts simple_linear_search([1,2,3,4,5,6,9,11,233,444,565,2345,5436], 467)

# check if number is prime
def is_prime?(number)
  return false if number < 2
  
  (2..number - 1).each do |n|
    return false if number % n == 0
  end

  true
end

puts is_prime?(44)
puts is_prime?(31)

# binary search with recursion
# check if the value is in the array
def binary_search(array, value, lower = 0, upper = nil)
  upper = array.count - 1 unless upper

  return "Not in array" if lower > upper

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

# is there any duplicates in the array?
# naive O(n2) implementation

def has_duplicate?(array)
  array.each_with_index do |_, i|
    array.each_with_index do |_, j|
      if i != j && array[i] == array[j]
        return true
      end
    end
  end
  false
end

puts has_duplicate?([1,2,3,4,5,6,7,7])
puts has_duplicate?([1,2,3,4,5,6,7])


# O(2^n)
# 2^10 = 1024, 2^20 = 1_048_576, 2^30 = 1_073_741_824
# find all subsets of an array

def subset_in_array?(array, value)
  result = 1.upto(array.length).flat_map do |n|
    array.combination(n).to_a
  end
  result.include?(value)
end

p subset_in_array?([1,2,3,4], [1,3])

# Given the string in form AAABBBCCCC compress it to
# A3B3C4. Should be case sensitive AAaa should be A2B2

# def compress(string)
#   l = string.size
#   r = ""

#   return r if l == 0
#   return string if l == 1

#   i, counter = 1, 1

#   while i < l
#     if string[i] == string[i-1]
#       counter += 1
#     else
#       r << "#{string[i-1]}#{counter}"
#       counter = 1
#     end
#     i += 1
#   end
  
#   r << "#{string[i-1]}#{counter}"
# end

# compressed = compress("AAABBCCCCCCC")
# puts compressed

# def unique(string)
#   coll = {}

#   string.chars.each do |char|
#     return false if coll[char]
#     coll[char] = 1
#   end

#   true
# end

# puts unique("fasdf")

