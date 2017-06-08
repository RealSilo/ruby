# array

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
    if number == capacity
      resize
    end
    
    self[number] = element
    self.number += 1
  end

  alias_method :<<, :push

  private

  def resize
    doubled_capacity = 2 * capacity
    puts doubled_capacity

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
