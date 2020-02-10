# Find the largest continous sum in a collection
# The elements are integers.
# [1, 2, -1, 3, 4, 10, 10, -10, -1] would return 29

def largest_cont_sum(array)
  return nil if array.empty?
  
  max_sum = 0
  current_max_sum = 0

  array.each do |number|
    current_max_sum = [current_max_sum + number, number].max
    max_sum = [current_max_sum, max_sum].max
  end

  max_sum
end

p largest_cont_sum([1, 2, -1, 3, 4, 10, 10, -10, -1])

# Find the first non-repeated (unique) character in a given string.
# Time complexity O(N), space complexity O(N) where N is the length of the string.
def first_non_repeated_char(string)
  store = {}

  string.each_char do |char|
    if store[char]
      store[char] += 1
    else
      store[char] = 1
    end
  end

  string.each_char do |char|
    return char if store[char] == 1
  end

  nil
end

# Write a program to check if a String contains another String in
# O(N) time.
def substring_of_string(string, substring)
  sub_i = 0

  string.each_char.with_index do |char, i|
    if substring[sub_i] == char
      return true if sub_i == substring.length - 1
      sub_i += 1
    else
      if substring[0] == char
        sub_i = 1
      else
        sub_i = 0
      end
    end
  end

  false
end

# p substring_of_string("hohohho", "hhho")

def reverse_vowels(string)
  vowels = ['a', 'e', 'i', 'o', 'u']
  i = 0
  j = string.length - 1

  while i <= j
    i += 1 until vowels.include?(string[i])
    j -= 1 until vowels.include?(string[j])

    string[i], string[j] = string[j], string[i]
    i += 1
    j -= 1
  end

  string
end

# Implement split in Ruby
def my_split(string, divider)
  array = []
  current_element = ''

  formatted_string = string.clone
  formatted_string.strip!

  formatted_string.each_char do |char|
    if char == divider
      array << current_element
      current_element = ''
    else
      current_element << char
    end
  end

  array << current_element

  array
end

split_string = ' hoho hehe haha '
p my_split(split_string, ' ')

# Flatten an array
# [[3, 4], 5, [[4, 8], 9], 10] => [3, 4, 5, 4, 8, 9, 10]
def my_flatten(arr, flattened_arr = [])
end
