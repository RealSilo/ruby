class Node
  attr_accessor :value, :next_node

  def initialize(value, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  attr_accessor :head, :tail

  def initialize(value)
    @head = Node.new(value)
    @tail = @head
  end

  def add(value)
    node = Node.new(value)
    @tail.next_node = node
    @tail = node
  end
end

ll = LinkedList.new(2)
ll.add(3)
ll.add(4)
ll.add(3)
ll.add(3)
ll.add(5)


def remove_duplication(ll)
  store = {}
  node = ll.head
  prev = nil

  while node
    if store[node.value]
      prev.next_node = node.next_node
    else
      store[node.value] = 1
      prev = node
    end

    node = node.next_node
  end
end

remove_duplication(ll)

ll2 = LinkedList.new(0)
10.times do |i|
  ll2.add(i + 1)
end

def kth_to_last(ll, k)
  node = ll.head
  counter_node = ll.head

  k.times do |_|
    raise 'Longer than k' unless counter_node
    counter_node = counter_node.next_node
  end

  while counter_node
    node = node.next_node
    counter_node = counter_node.next_node
  end

  node
end

# p kth_to_last(ll2, 7).value

ll3 = LinkedList.new(9)
ll3.add(2)
ll3.add(3)

ll4 = LinkedList.new(8)
ll4.add(9)
ll4.add(1)

def sum_digits_in_lls(ll, ll2)
  node = ll.head
  node2 = ll2.head
  sum_array = []
  remainder = 0

  while node || node2
    if node && node2
      sum = node.value + node2.value + remainder
    elsif node
      sum = node.value + remainder
    elsif node2
      sum = node2.value + remainder
    end

    remainder = sum / 10
    sum_array.unshift(sum.digits.first)
    node = node&.next_node
    node2 = node2&.next_node
  end

  sum_array.join
end

p sum_digits_in_lls(ll3, ll4)

# {{()}}{()} should return true
# [][]{()}( should return false

def balanced_parantheses?(string)
  openings = ['[', '{', '(']
  matchings = [['[', ']'], ['{', '}'], ['(', ')']]
  stack = []

  string.each_char do |char|
    if openings.include?(char)
      stack.push(char)
    else
      return false if stack.empty?

      last_opening = stack.pop

      return false unless matchings.include?([last_opening, char])
    end
  end

  true
end

def is_palindrome?(str)
  return true if str.length <= 1

  return false unless str[0] == str[-1]

  is_palindrome?(str[1..-2])
end

p is_palindrome?('abcdcba')
p is_palindrome?('abcdgcba')
p is_palindrome?('abcddcba')

def is_palindrome2?(str)
  return true if str.length <= 1
  i = 0
  j = str.length - 1

  while i < j
    return false unless str[i] == str[j]
    i += 1
    j -= 1
  end

  true
end

p is_palindrome2?('abcdcba')
p is_palindrome2?('abcdgcba')
p is_palindrome2?('abcddcba')
