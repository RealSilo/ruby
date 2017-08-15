require 'byebug'
# reading element O(N) worst case, O(k) average (k-th element)
# insertion, deletion O(1)
# linked lists can continue to expand without having to specify their size ahead of time
# good to use them for stack for instance where always the first element is accessed/written

# ruby specs:
# there is no linked list in ruby => either use array or implement your own to avoid dynamic array resizing

class LinkedLists
  class SinglyLinkedNode
    attr_accessor :value, :next_node

    def initialize(value, next_node = nil)
      @value = value
      @next_node = next_node
    end
  end

  s1 = SinglyLinkedNode.new(1)
  s2 = SinglyLinkedNode.new(2)
  s3 = SinglyLinkedNode.new(3)
  s4 = SinglyLinkedNode.new(4)

  s1.next_node = s2
  s2.next_node = s3
  s3.next_node = s4

  # puts [s1.inspect s2.inspect, s3.inspect, s4.inspect]
  # puts s2.next_node.value

  class DoublyLinkedNode
    attr_accessor :value, :prev_node, :next_node

    def initialize(value, prev_node = nil, next_node = nil)
      @value = value
      @prev_node = prev_node
      @next_node = next_node
    end
  end

  d1 = DoublyLinkedNode.new(1)
  d2 = DoublyLinkedNode.new(2)
  d3 = DoublyLinkedNode.new(3)
  d4 = DoublyLinkedNode.new(4)

  d1.next_node = d2
  d2.prev_node = d1
  d2.next_node = d3
  d3.prev_node = d2
  d3.next_node = d4
  d4.prev_node = d3

  # puts [d1.inspect, d2.inspect, d3.inspect, d4.inspect]
  # puts d3.prev_node.value

  class LinkedList
    attr_accessor :head, :size

    def initialize(value)
      @head = SinglyLinkedNode.new(value)
      @size = 1
    end

    def add(value) # adding element to the end
      node = SinglyLinkedNode.new(value)
      current = head
      current = current.next_node while current.next_node
      current.next_node = node

      self.size += 1
      node
    end

    def remove(value) # removing element
      current = head

      if current.value == value
        self.head = head.next_node
      else
        until current.value == value
          return 'No such element' if current.next_node.nil?
          previous_node = current
          current = current.next_node
        end

        previous_node.next_node = current.next_node
      end

      self.size -= 1
      current
    end

    def add_at(index, value)
      return false if index > size || index < 0

      node = SinglyLinkedNode.new(value)
      current = head
      current_index = 0

      if index == 0
        node.next_node = current
        self.head = node
      else
        until index == current_index
          previous_node = current
          current = current.next_node
          current_index += 1
        end

        node.next_node = current
        previous_node.next_node = node
      end

      self.size += 1
      node
    end

    def remove_at(index)
      return nil if index < 0 || index >= size

      current = head
      current_index = 0

      if index == 0
        self.head = current.next_node
        return current
      end

      until index == current_index
        previous_node = current
        current = current.next_node
        current_index += 1
      end

      previous_node.next_node = current.next_node
      self.size -= 1
      current
    end
  end

  list = LinkedList.new('dog')
  list.add('cat')
  list.add('horse')
  puts list.head.inspect
  list.remove('cat')
  puts list.head.inspect
  list.add_at(1, 'mouse')
  puts list.head.inspect
  list.add('parrot')
  list.remove_at(1)
  puts list.head.inspect

  # PROBLEM1: Check if there is a "cycle" in the singly linked list
  # cycle could be anywhere like 1 => 2 => 3 => 4 = > 5 => 2 (5th element points at the 2nd one)
  def cycle_in_linked_list?(node)
    marker1 = node
    marker2 = node

    until marker2.nil? || marker2.next_node.nil?

      # if there is a cycle marker2 will catch up with marker 1
      marker1 = marker1.next_node
      marker2 = marker2.next_node.next_node

      return true if marker1 == marker2
    end
    false
  end

  # PROBLEM2: Write a function to reverse a linked list
  # without new linked list -> O(1) space complexity
  # should be O(n) time complexity
  def reverse_linked_list(head)
    current = head
    prevnode = nil

    while current
      nextnode = current.next_node # first define the nextnode for the iteration with the old pointer
      current.next_node = prevnode # change the pointer to point to the prev element
      prevnode = current # change the current node to prev node for the iteration
      current = nextnode # change the nextnode to current for the iteration
    end
  end

  # PROBLEM3: Write a function that takes the head node and an integer value (n) and returns
  # the nth element to the last node in the linked list.
  def nth_to_the_last(head, n)
    current = head
    elements = []

    loop do
      elements << current
      break unless current.next_node
      current = current.next_node
    end

    raise "Less elements in linked list than #{n}" if elements.size < n
    elements[-n].value
  end

  def nth_to_the_last_improved(head, n)
    left_pointer = head
    right_pointer = head

    n.times do
      raise "Less elements in linked list than #{n}" unless right_pointer.next_node
      right_pointer = right_pointer.next_node
    end

    while right_pointer.next_node
      left_pointer = left_pointer.next_node
      right_pointer = right_pointer.next_node
    end

    left_pointer = left_pointer.next_node
    left_pointer.value
  end

  # PROBLEM4: Write code to remove duplicates from an unsorted linked list.
  def remove_duplicate(head)
    current = head

    store = {}
    prev = nil

    while current
      if store[current.value]
        prev.next_node = current.next_node
      else
        store[current.value] = 1
        prev = current
      end

      current = current.next_node
    end
  end

  # To achieve in-place we have to use O(N2) time.
  def remove_duplicate_without_buffer(head)
    current = head

    while current
      runner = current
      while runner.next_node
        if runner.next_node.data == current.data
          runner.next_node = runner.next_node.next_node
        else
          runner = runner.next_node
        end
      end
      current = current.next_node
    end
  end

  # PROBLEM5: Implement a function to check if a linked list is a palindrome.
  # 0 -> 1 -> 2 -> 1 -> 0
  def palindrome?(head)
    current = head
    marker = head
    stack = []

    while marker && marker.next_node
      stack << current.value
      current = current.next_node
      marker = marker.next_node.next_node
    end

    # if the number of the elements is odd
    current = current.next_node if marker

    while current
      return false unless stack.pop == current.value
      current = current.next_node
    end

    true
  end

  # PROBLEM6: Intersection: Given two (singly) linked lists, determine if the two
  # lists intersect. Return the intersecting node. Note that the intersection is
  # defined based on reference, not value. That is, if the kth node of the first
  # linked list is the exact same node (by reference) as the jth node of the second
  # linked list, then they are intersecting.
  def find_intersection(head1, head2)
    current1 = head1
    current2 = head2

    result1 = find_tail_helper(current1)
    result2 = find_tail_helper(current2)

    length1, tail1 = result1[:length], result1[:current]
    length2, tail2 = result2[:length], result2[:current]

    return nil unless tail1 == tail2

    shorter = length1 <= length2 ? head1 : head2
    longer = length2 <= length1 ? head1 : head2

    until length1 == length2
      longer = longer.next_node
      length1 < length2 ? length2 -= 1 : length1 -= 1
    end

    until shorter == longer
      shorter = shorter.next_node
      longer = longer.next_node
    end

    shorter
  end

  def find_tail_helper(current)
    current = current
    length = 0

    while current.next_node
      length += 1
      current = current.next_node
    end

    { current: current, length: length }
  end
end
