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
# (doubling cost (1+2+4+8+...+m/2+m) + appending cost (m)) / append times (m) => O(3m/m) => O(1)
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
        coded_char = char
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

  # PROBLEM 7: Check if string is a palindrome (space can be removed)

  def palindrome_without_recursion?(string)
    string = string.downcase.tr(' ', '')
    return true if string.length <= 1
    reversed_string = ''

    (string.length - 1).downto(0) { |i| reversed_string << string[i] }

    (string.length - 1).times { |i| return false unless string[i] == reversed_string[i] }

    true
  end

  def palindrome?(string)
    string = string.downcase.tr(' ', '')

    return true if string.empty?
    
    string[0] == string[-1] && palindrome?(string[1..-2])
  end
end
