# reading element O(N) worst case, O(k) average (k-th element)
# insertion, deletion O(1)
# linked lists can continue to expand without having to specify their size ahead of time
# good to use them for stack for instance where always the first element is accessed/written

# ruby specs:
# there is no linked list in ruby => either use array or implement your own to avoid dynamic array resizing

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

class LinkedLists
  attr_accessor :head

  def initialize(value)
    @head = SinglyLinkedNode.new(value)
  end

  def add(value) # adding element to the end
    current = head

    current =  current.next_node while current.next_node

    current.next_node = SinglyLinkedNode.new(value)
  end
end

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

# puts cycle_in_linked_list?(s1)

# PROBLEM2: Write a function to reversea linked list

def reverse_linked_list(head)
  # without new linked list -> O(1) space complexity
  # should be O(n) time complexity

  current = head
  prevnode = nil
  # nextnode = nil

  while current
    nextnode = current.next_node # first define the nextnode for the iteration with the old pointer
    current.next_node = prevnode # change the pointer to point to the prev element
    prevnode = current # change the current node to prev node for the iteration
    current = nextnode # change the nextnode to current for the iteration
  end
end

# reverse_linked_list(s1)
# puts s4.next_node.value
# puts s1.next_node.nil?

# PROBLEM3: Write a function that takes the head node and an integer value (n) and returns
#           the nth element to the last node in the linked list.

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

# puts nth_to_the_last(s1, 2)

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

# puts nth_to_the_last_improved(s1, 2)