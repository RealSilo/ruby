require 'byebug'
# static arrays

# each member of an array must use the same number of bytes (or
# same number of memory addresses) so the element can be accessed as
# start + cellsize * index with O(1) where cellsize is the number of
# memory addresses used => to make this happen array implementations
# only store just references to objects

# referential arrays

# when computing a slice of a list the result is a new list instance;
# the new list has references to the same elements that can be found
# in the original list; when elements are updated it doesn't change
# the original but changes the reference to a new object;

# dynamic array

# array size doesn't need to be specified upfront;
# 1. a new larger array(B) gets allocated when the array(A) gets full
# 2. the references from array(a) get stored in array(B)
# 3. reassign the reference A to array(B) -> from now on it is array(A)

# array insertion at the end time complexity: O(n)
# dynamic insertion at the end amortized time complexity: O(1)
# when we append m elements:
# (doubling cost (1+2+4+8+...+m/2+m = 2m) + appending cost (m)) / append times (m) => O(3m/m) => O(1)
# any array deletion at the end time complexity: O(1)
# any array insertion at the beginning time complexity: O(n)
# any array deletion at the beginning time complexity: O(n)
# any array index lookup: O(1)
# any array basic search: O(n)

# Ruby Array class
# stack/queue/dequeue all in one thanks to LIFO/FIFO methods
# O(1) operations -> pop/shift

# inserting, prepending or appending as well as deleting has a worst-case
# time complexity of O(n) AND and amortized worst-case time complexity of O(1)

# accessing an element has a worst-case time complexity of O(1)
# iterating over all elements has a worst-case time complexity of O(n)

class Arrays
  class DynamicArray
    attr_accessor :capacity, :number, :array

    def initialize(capacity = 1)
      @capacity = capacity
      @number = 0
      @array = Array.new(@capacity)
    end

    def length
      number
    end

    def [](i)
      raise 'IndexError' unless 0 <= i && i < number
      array[i]
    end

    def []=(i, val)
      raise 'IndexError' unless 0 <= i && i <= number
      array[i] = val
    end

    def push(element)
      resize if number == capacity

      self[number] = element
      self.number += 1
    end

    private

    def resize
      doubled_capacity = 2 * capacity

      doubled_array = Array.new(doubled_capacity)

      length.times do |i|
        doubled_array[i] = array[i]
      end

      self.array = doubled_array
      self.capacity = doubled_capacity
    end
  end

  # dynamic_array = DynamicArray.new
  # puts dynamic_array.capacity
  # dynamic_array.push(1)
  # puts dynamic_array.inspect
  # puts dynamic_array.capacity
  # dynamic_array.push(1)
  # puts dynamic_array.inspect
  # dynamic_array.push(1)
  # puts dynamic_array.inspect
  # dynamic_array.push(1)
  # dynamic_array << 1
  # puts dynamic_array.length
  # puts dynamic_array
  # print dynamic_array.array

  class CircularBufferDynamicArray
    # great for queues
  end

  # PROBLEM 1: Given 2 strings check if they are anagrams
  # anagram -> two strings can be written with the same exact letters
  # (capital and space inlcuded)
  # the following solution will be 0(N) time complexity
  def anagram(string1, string2)
    string1 = string1.downcase.tr(' ', '')
    string2 = string2.downcase.tr(' ', '')

    return false unless string1.length == string2.length

    letters = {}

    string1.split('').each do |letter|
      if letters[letter]
        letters[letter] = letters[letter] + 1
      else
        letters[letter] = 1
      end
    end

    string2.split('').each do |letter|
      if letters[letter]
        letters[letter] = letters[letter] - 1
      else
        letters[letter] = -1
      end
    end

    letters.values.each do |val|
      return false unless val == 0
    end

    true
  end

  # PROBLEM 2: Given an array find a pair in it that equals a number (return true if any)
  # array is sorted and includes integers (can be negative)
  # with args [1, 2, 3, 9], 8 returns false
  # with args [1, 2, 4, 4], 8 returns true

  # O(N2) solution would be a double iteration with summing up all the combinations
  # O(N*logN) solution would be an iteration with a binary search for the complement
  # the following solution is O(N) time complexity
  def sorted_array_pair_sum(array, number)
    low = 0
    high = array.length - 1

    loop do
      break if low == high
      return true if array[low] + array[high] == number

      if array[low] + array[high] < number
        low += 1
      elsif array[low] + array[high] > number
        high -= 1
      end
    end

    false
  end

  # the following is the optimal solution for the sorted version as well
  def unsorted_array_pair_sum(array, number)
    return false if array.length < 2

    store = {}

    array.each do |element|
      return true if store[element]
      store[number - element] = 1
    end

    false
  end

  # PROBLEM 3: There is a sorted array of non-negativ integers and another array
  # that is formed by shuffling the elements of the first array and delete a
  # random one. Find the missing element!

  def find_missing(array1, array2)
    raise 'Wrong args' unless array1.length == array2.length + 1 && array1.length > 0

    store = {}

    array2.each do |element|
      if store[element]
        store[element] = store[element] + 1
      else
        store[element] = 1
      end
    end

    array1.each do |element|
      return element if store[element] == 0
      return element if store[element].nil?
      store[element] -= 1
    end
  end

  # PROBLEM 4: Find the largest continous sum in a collection
  # The elements are integers.
  # [1, 2, -1, 3, 4, 10, 10, -10, -1] would return 29

  def largest_cont_sum(array)
    return 0 if array.empty?
    return array[0] if array.length == 1

    max_sum = 0
    current_sum = 0

    array.each do |number|
      current_sum = [current_sum + number, number].max

      max_sum = [current_sum, max_sum].max
    end

    max_sum
  end

  # PROBLEM 5: Sentence reversal
  # There is string that includes words.
  # 'This is the best' would be 'best the is This'
  # All leading or trailing whitespaces should be removed.
  # ' haha hihi ' will be 'hihi haha'

  # quick ruby solution
  # def sentence_reversal(sentence)
  #   sentence.split(" ").reverse.join(" ")
  # end

  # O(N) solution
  def sentence_reversal(sentence)
    return '' if sentence.empty?

    words = []
    word = []

    sentence.each_char do |char|
      if char.strip.empty?
        words.unshift(word.join('')) unless word.join('') == ''
        word = []
      else
        word << char
      end
    end
    words.unshift(word.join('')) unless word.join('') == ''

    words.join(' ')
  end

  # PROBLEM 6: String compression
  # Case sensitive, no problem if compressed string in longer than original, no spaces

  # gAAaacBBBBBBh will be g1A2a2c1B6h1
  def string_compression(string)
    return '' if string.empty?

    compressed_string = ''
    coded_char = ''
    repetition = 1

    string.each_char.with_index do |char, i|
      coded_char = char
      if char == string[i + 1]
        repetition += 1
      else
        coded_char << repetition.to_s
        compressed_string << coded_char
        coded_char = string[i+1]
        repetition = 1
      end
    end

    compressed_string
  end

  # PROBLEM 7: Parse the strings at spaces
  # "12 3 + 4 + 55" -> [12, 3, +, 4, 55]

  def parse_string(string)
    parsed_array = []
    coded_char = ''

    string.each_char.with_index do |char, i|
      if string[i + 1] == ' '
        coded_char << char
        parsed_array << coded_char
        coded_char = ''
      else
        coded_char << char unless char == ' '
      end
    end

    parsed_array << coded_char

    parsed_array
  end

  def number_of_trailing_zeros_of_factorial(n)
    factorial = (1..n).inject(:*) || 1

    string = factorial.to_s

    counter = 0

    (string.length - 1).downto(0) do |i|
      return counter unless string[i] == '0'
      counter += 1
    end
  end

  # PROBLEM 8: Check if string is a palindrome (space can be removed)
  def palindrome_without_recursion?(string)
    string = string.downcase.tr(' ', '')
    return true if string.length <= 1

    i = 0
    j = string.length - 1

    while i < j
      return false unless string[i] == string[j]
      i += 1
      j -= 1
    end

    true
  end

  def palindrome?(string)
    string = string.downcase.tr(' ', '')

    return true if string.length <= 1

    string[0] == string[-1] && palindrome?(string[1..-2])
  end

  # PROBLEM 9: Write a method to replace all spaces in a string with '%20'. You can assume
  # that the string has sufficient space at the end to hold the additional characters, and
  # that you are given the "true" length of the string.
  # "Mr John Smith  ",will be "Mr%20John%20Smith"

  def urlify_inplace(string, length)
    string = string[0..length - 1]

    length.times do |i|
      string[i] = '%20' if string[i] == ' '
    end

    string
  end

  def urlify(string, _length)
    string.split(' ').join('%20')
  end

  def urlify_backwards(string, length)
    space_count = 0

    string = string[0..length - 1] # removing spaces from the end

    string.each_char do |char|
      space_count += 1 if char == ' '
    end

    index = length + space_count * 2 # calculating the new length

    (length..index).step(1) do |i|
      string[i] = ' ' # setting the new length
    end

    string = string[0..-2] # getting rid of last space

    (length - 1).downto(0) do |i|
      if string[i] == ' '
        string[index - 1] = '0'
        string[index - 2] = '2'
        string[index - 3] = '%'
        index -= 3
      else
        string[index - 1] = string[i]
        index -= 1
      end
    end

    string
  end

  # PROBLEM 10: Rotate a matrix by 90
  # 1  2  3  4       4  8  12 16
  # 5  6  7  8   ==> 3  7  11 15
  # 9  10 11 12  ==> 2  6  10 14
  # 13 14 15 16      1  5  9  13

  # [[1,2,3,4][5,6,7,8],[9,10,11,12],[13,14,15,16]]
  # time complexity O(N) where N is the number of elements in the matrix
  # space complaexity O(N)
  def rotate(matrix)
    length = matrix.length
    rotated_matrix = Array.new(length) { Array.new(length) { nil } }

    matrix.each_with_index do |row, i|
      row.each_with_index do |_col, j|
        rotated_matrix[length - 1 - j][i] = matrix[i][j]
      end
    end

    rotated_matrix
  end

  def rotate_in_place(matrix)
    length = matrix.length

    (length / 2).times do |layer|
      last = length - 1 - layer
      for i in layer..last - 1
        offset = i - layer
        top_temp = matrix[layer][i]

        matrix[layer][i] = matrix[i][last]
        matrix[i][last] = matrix[last][last - offset]
        matrix[last][last - offset] = matrix[last - offset][layer]
        matrix[last - offset][layer] = top_temp
      end
    end

    matrix
  end

  # PROBLEM11: Write an algorithm such that if an element in an MxN matrix
  # is 0, its entire row and column are set to 0.
  # In-place algorithm with time complextiy O(N) where N is the number of elements
  # in the matrix.
  def change_zeros(matrix)
    zero_rows = [].to_set
    zero_cols = [].to_set

    matrix.each_with_index do |row, i|
      row.each_with_index do |_col, j|
        if matrix[i][j] == 0
          zero_rows.add(i)
          zero_cols.add(j)
        end
      end
    end

    zero_rows.each do |row|
      matrix[row].each_with_index { |_number, i| matrix[row][i] = 0 }
    end

    zero_cols.each do |col|
      matrix.each_with_index { |_row, i| matrix[i][col] = 0 }
    end

    matrix
  end

  # PROBLEM12: Find the first non-repeated (unique) character in a given string.
  # Time complexity O(N), space complexity O(N) where N is the length of the string.
  def first_non_repeated_char(string)
    return nil if string.empty?
    store = {}

    string.each_char do |letter|
      if store[letter]
        store[letter] += 1
      else
        store[letter] = 1
      end
    end

    string.each_char do |letter|
      return letter if store[letter] == 1
    end
  end

  # PROBLEM13: Find all permutations of a string.
  # Easy solution: "abc".chars.permutation.map &:join
  def permutations(string)
    # output = []

    # if string.length == 1
    #   output = [string]
    # else
    #   string.each_char.with_index do |char, index|
    #     for perm in permutation_count((string[0..index] + string[(index + 1)..-1])) do
    #       output += [char + perm]
    #     end
    #   end
    # end

    # output
  end

  # PROBLEM14: Remove all the duplicated chars from a string.
  def remove_duplicates(string)
    store = {}

    string.each_char do |letter|
      if store[letter]
        store[letter] += 1
      else
        store[letter] = 1
      end
    end

    (string.length - 1).downto(0) do |i|
      if store[string[i]] > 1
        store[string[i]] -= 1
        string.slice!(i)
      end
    end

    string
  end

  # PROBLEM15: How to check if a String is valid shuffle of two String?
  # Order must be kept so 'ABDEFC' is a valid shuffle of 'ABC' and 'DEF' but
  # 'BADEFC' is not
  def shuffle_of_two_strings?(string1, string2, string3)
    i = 0
    j = 0

    string3.each_char do |char|
      if char == string1[i]
        i += 1
      elsif char == string2[j]
        j += 1
      else
        return false
      end
    end

    true
  end

  # PROBLEM16: Write a program to check if a String contains another String in
  # O(N) time.
  def substring_of_string(string1, string2)
    i = 0

    string1.each_char.with_index do |char, j|
      if char == string2[i]
        i += 1
        return j - string2.length + 2 if i == string2.length - 1
      elsif char == string2[0]
        i = 1
      else
        i = 0
      end
    end

    false
  end

  # PROBLEM17: One of the simplest and most widely known ciphers is a Caesar
  # cipher, also known as a shift cipher. In a shift cipher the meanings of the
  # letters are shifted by some set amount. A common modern use is the ROT13
  # cipher, where the values of the letters are shifted by 13 places. Thus
  # 'A' ↔ 'N', 'B' ↔ 'O' and so on.
  def caesar_cipher(string)
    split_str = string.split('')

    split_str.each_with_index do |_char, i|
      next if split_str[i] == ' '

      split_str[i] = split_str[i].ord + 13
      split_str[i] -= 26 if split_str[i] > 90
      split_str[i] = split_str[i].chr
    end

    split_str.join
  end

  # PROBLEM18: Reverse only the vowels in a word
  def reverse_vowels(string)
    vowels = ['a', 'e', 'i', 'o', 'u']

    i = 0
    j = string.length - 1

    until i >= j
      i += 1 until vowels.include?(string[i]) || i >= j
      j -= 1 until vowels.include?(string[j]) || i >= j

      string[i], string[j] = string[j], string[i] unless i == j
      i += 1
      j -= 1
    end

    string
  end

  # PROBLEM19: Implement split in Ruby
  def my_split(string, divider)
    result = []
    current = ''

    formatted_string = string.clone
    formatted_string.strip!

    formatted_string.each_char do |char|
      if char == divider
        result << current
        current = ''
      else
        current.concat(char)
      end
    end

    result << current unless current.empty?

    result
  end

  # PROBLEM20: Flatten an array
  # [[3, 4], 5, [[4, 8], 9], 10] => [3, 4, 5, 4, 8, 9, 10]
  def my_flatten(arr, flattened_arr = [])
    arr.each do |element|
      if element.is_a? Array
        my_flatten(element, flattened_arr)
      else
        flattened_arr << element
      end
    end
    flattened_arr
  end

  # PROBLEM21: Check if the word is a permutation of a palindrome
  # "civic", "ivicc" => true
  # "civil", "livci" => false
  def perm_of_palin?(string)
    return true if string.length <= 1

    store = {}

    string.each_char do |char|
      if store[char]
        store[char] += 1
      else
        store[char] = 1
      end
    end

    odds = 0

    store.each do |char, num|
      if num.odd?
        odds += 1
        return false if odds > 1
      end
    end

    true
  end
end
