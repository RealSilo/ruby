# 1. Get the product of all other elements with no division
# [1, 2, 3, 4, 5] => [120, 60, 40, 30, 24]
# Tricky solution
def other_product(arr)
  len = arr.length
  return nil if len == 0 || len == 1

  sub_array = Array.new(len) { 1 }

  arr.each_with_index do |element, i|

  end
end

# 1.2. Locate smallest window to be sorted
# Given an array of pos ints determine the bounds of the smallest window that must be sorted
# [3, 7, 5, 6, 9] => [1, 3]
def smallest_window(arr)
  return false if arr.length < 2

  smallest_window = [nil, nil]
  current_min = nil
  current_max = nil
  arr.each_with_index do |element, i|
    current_max = element unless current_max
    current_max = element if element > current_max
    smallest_window[1] = i if element < current_max
  end
  arr.reverse.each_with_index do |element, i|
    current_min = element unless current_min
    current_min = element if element < current_min
    smallest_window[0] = arr.length - 1 - i if element > current_min
  end
  
  smallest_window
end

# p smallest_window([1, 2, 9, 7, 8, 6])

# 1.3. Calculate max subarray sum
# Tricky solution
# [34, -50, 42, 14, -5, 86] => 42 + 14 + (-5) + 86 = 137
# [-3, -5, -8, -1] => 0
# O(n) time, O(1) space
def max_subarray_sum(arr)
  maximum = 0
  current_maximum = 0

  arr.each do |element|
    current_maximum = [element, current_maximum + element].max
    maximum = [current_maximum, maximum].max
  end

  maximum
end

# p max_subarray_sum([34, -50, 42, 14, -5, 86])
# p max_subarray_sum([-3, -5, -8, -1])

# 1.4 Find smaller elements to the right
# [3, 4, 9, 6, 1] => [1, 1, 2, 1, 0]
# O(n * log n)
def smaller_counts_right(arr)
end

# 2.2 Generate palindrome pairs
# ['code', 'edoc', 'da', 'd'] => [[0, 1], [1, 0], [2, 3]]

def palindrome_pairs(arr)

end

# 2.3 Print zigzag form
# ['abcdefghijkl'], 3
# a   e   i
#  b d f h j l
#   c   g   k

def zigzag(str, k)
  pos_side = false
  lines = Array.new(k) { '' }
  str.each_char.with_index do |char, j|
    remainder = j % (k - 1)
    pos_side = !pos_side if remainder == 0
    k.times do |i| 
      if pos_side
        if i == remainder
          lines[i] << char
        else
          lines[i] << ' '
        end
      else
        if i == k - 1 - remainder
          lines[i] << char
        else
          lines[i] << ' '
        end
      end
    end
  end
  puts lines
end

# zigzag('abcdefghijklmnopqrst', 4)

# 3.1 Reverse a linked list

class Node
  attr_accessor :data, :next_node

  def initialize(data, next_node = nil)
    @data = data
    @next_node = next_node
  end
end

n1 = Node.new(4)
n2 = Node.new(3, n1)
n3 = Node.new(2, n2)
n4 = Node.new(1, n3)

def reverse_linked_list(head)
  current = head
  prev_node = nil

  while current
    next_node = current.next_node
    current.next_node = prev_node
    prve_node = current
    current = next_node
  end
end

reverse_linked_list(n1)

# 3.2. Sum two linked lists that represent nums
# 9 -> 9
# 5 -> 2
# Returns 4 -> 2 -> 1 (99 + 25 = 124)

n32_1 = Node.new(9)
n32_2 = Node.new(9, n32_1)
n32_3 = Node.new(2)
n32_4 = Node.new(5, n32_3)

def sum_linked_lists(head1, head2, carry = 0)
  return nil unless head1 || head2 || carry > 0

  head1_val = head1 ? head1.data : 0
  head2_val = head2 ? head2.data : 0
  total = head1_val + head2_val + carry

  next_head1 = head1 ? head1.next_node : nil
  next_head2 = head2 ? head2.next_node : nil
  next_carry = total >= 10 ? 1 : 0

  Node.new(total % 10, sum_linked_lists(next_head1, next_head2, next_carry))
end

# p sum_linked_lists(n32_2, n32_4)

# 3.3. Rearrange a linked list to alternate high-low

def rearrange_high_low(head)
  even = true
  current = head

  while current.next_node
    if current.data > current.next_node.data && even
      current.data, current.next_node.data = current.next_node.data, current.data
    end

    if current.data < current.next_node.data && !even
      current.data, current.next_node.data = current.next_node.data, current.data
    end

    even = !even
    current = current.next_node
  end

  head
end

n33_1 = Node.new(5)
n33_2 = Node.new(4, n33_1)
n33_3 = Node.new(3, n33_2)
n33_4 = Node.new(2, n33_3)
n33_5 = Node.new(1, n33_4)
# p rearrange_high_low(n33_5)

# 3.4. Find intersecting nodes of linked lists

def find_intersecting_nodes(head1, head2)
  ll1_length = 0 
  ll2_length = 0
  current1 = head1
  current2 = head2

  while head1.next_node
    ll1_length += 1
    head1 = head1.next_node
  end

  while head2.next_node
    ll2_length += 1
    head2 = head2.next_node
  end

  while ll1_length > ll2_length
    current1 = current1.next_node
    ll1_length -= 1
  end

  while ll1_length < ll2_length
    current2 = current2.next_node
    ll2_length -= 1
  end

  until current1 == current2
    current1 = current1.next_node
    current2 = current2.next_node
  end

  current1
end

n34_1 = Node.new(10)
n34_2 = Node.new(8, n34_1)
n34_3 = Node.new(7, n34_2)
n34_4 = Node.new(3, n34_3)

n34_5 = Node.new(1, n34_2)
n34_6 = Node.new(99, n34_5)

# p find_intersecting_nodes(n34_4, n34_6)

# 4.1. Implement a max stack
# push, pop and max operations should be constant time

class Stack
  attr_accessor :store, :maxes

  def initialize
    self.store = []
    self.maxes = []
  end

  def push(value)
    if maxes.empty?
      maxes.push(value)
    else
      maxes.push([value, maxes.last].max)
    end
    store.push(value)
  end

  def pop
    maxes.pop unless maxes.empty?
    store.pop
  end

  def max
    maxes.last
  end
end

# s = Stack.new
# s.push(3)
# s.push(5)
# s.push(4)
# s.push(2)
# s.pop

# 4.2. Determine if the brackets are balanced

def bracket_balance(brackets)
  openers = ['{', '(', '[']
  pairs = [['{', '}'], ['(', ')'], ['[', ']']]
  stack = []

  brackets.each_char do |bracket|
    if openers.include?(bracket)
      stack.push(bracket)
    else
      return false if stack.empty?
      
      opener = stack.pop

      return false unless pairs.include?[opener, bracket] 
    end
  end

  stack.empty?
end

# 4.3. Compute max of k-length sub arrays O(n) time and O(k) space.
# [10, 5, 2, 7, 8, 7] and 3 would return [10, 7, 8, 8]
# max (10, 5, 2) => 10
# max (5, 2 , 7) => 7
# etc.

def max_of_sub_array(arr, k)
  return nil if arr.length < k

  stack = []
  current_max = nil
  maxes = []

  arr.each_with_index do |element, i|
    stack.push(element)
    if i == k - 1
      current_max = stack.max
      maxes.push(current_max)
    end

    unless i < k
      stack.shift
      current_max = stack.max
      maxes.push(current_max)
    end
  end

  maxes
end

# p max_of_sub_array([10, 5, 2, 7, 8, 7], 3)

# 4.4. Given [0, 1, 2, ..., N] jumbled reconstruct the array in O(n) time
# and space based on the info if the prev element was smaller or bigger.
# [nil, +, +, -, +] => [0, 1, 3, 2, 4]
def reconstruct(arr)
  answer = []
  stack = []

  arr.each_with_index do |_element, i|
    if arr[i + 1] == '-'
      stack.push(i)
    else
      answer.push(i)
      answer.push(stack.pop) while stack.any?
    end
  end

  answer.push(stack.pop) while stack.any?

  answer
end

# p reconstruct([nil, '+', '+', '-', '+'])

# 5.1. Implement LRU cache
class LruNode
  attr_accessor :key, :value, :prev_node, :next_node
  def initialize(key, value, prev_node = nil, next_node = nil)
    @key = key                   
    @value = value
    @prev_node = prev_node
    @next_node = next_node
  end
end

class LruCache
  attr_reader :limit, :store, :head, :tail, :size
  def initialize(limit)
    @limit = limit
    @size = 0
    @store = {}
    @head = nil
    @tail = nil
    @head = nil
  end

  def get(key)
    node = store[key]
    return nil unless node
    return if head == node # node.prev_node.nil?

    if node.next_node
      prev_node = node.prev_node
      next_node = node.next_node
      prev_node.next_node = next_node
      next_node.prev_node = prev_node
    else
      @tail = node.prev_node
      tail.next_node = nil
    end

    node.next_node = head
    node.prev_node = nil
    head.prev_node = node
    @head = node

    node.value
  end

  def set(key, value)
    exisiting_node = store[key]
    if exisiting_node
      exisiting_node.value = value
      return self.get(key)
    end

    @size += 1
    node = LruNode.new(key, value)
    store[key] = node

    if size == 1
      @head = node
      @tail = node
      return node
    end

    if size > limit
      oldest_key = tail.key
      @tail = tail.prev_node
      tail.next_node = nil
      @size -= 1
      store.delete(oldest_key)
    end

    head.prev_node = node
    node.next_node = head
    @head = node

    node.value
  end
end

lru = LruCache.new(4)
lru.set('A', 3)
lru.set('B', 4)
lru.set('A', 5)
lru.set('C', 6)
lru.get('C')
lru.get('A')

# 6.1. Count unival trees
# Unival tree is a tree where all nodes under it have the same value.

class TreeNode
  attr_accessor :value, :left, :right
  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end
end

def unival_helper(root)
  return [0, true] unless root

  left_count, is_left_unival = unival_helper(root.left)
  right_count, is_right_unival = unival_helper(root.right)
  count = left_count + right_count

  if is_left_unival && is_right_unival
    return [count, false] if root.left && root.value != root.left.value
    return [count, false] if root.right && root.value != root.right.value
    return [count + 1, true]
  end

  return [count, false]
end

def count_unival_trees(root)
  count, _ = unival_helper(root)
  count
end

tree_node1 = TreeNode.new('b', nil, nil)
tree_node2 = TreeNode.new('b', nil, nil)
tree_node3 = TreeNode.new('b', nil, tree_node1)
tree_node4 = TreeNode.new('c', nil, nil)
tree_node5 = TreeNode.new('b', tree_node2, tree_node3)
root = TreeNode.new('a', tree_node4, tree_node5)

# p count_unival_trees(root)

# 6.2. Reconstruct the tree from pre-order and in-order travelsals:
# pre-order: [a, b, d, e, c, f, g]
# in-order: [d, b, e, a, f, c, g]
def reconstruct_tree(preorder, inorder)
  return nil unless preorder.any? || inorder.any?
  return preorder[0] if preorder.length == 1 && inorder.length == 1

  root = preorder[0]
  root_i = inorder.find_index(root)
  root.left = reconstruct_tree(preorder[1..root_i], inorder[0...root_i])
  root.right = reconstruct_tree(preorder[root_i + 1..-1], inorder[root_i + 1..-1])

  root
end

# a = TreeNode.new('a')
# b = TreeNode.new('b')
# c = TreeNode.new('c')
# d = TreeNode.new('d')
# e = TreeNode.new('e')
# f = TreeNode.new('f')
# g = TreeNode.new('g')

# p reconstruct_tree([a, b ,d , e, c, f, g], [d, b ,e ,a, f, c, g])

# 7. Write a BST with insert, find and delete operations.

class BST
  def initialize(root = nil)
    @root = root
  end

  def insert(value)
    if @root
      insert_helper(value, @root)
    else
      @root = TreeNode.new(value)
    end
  end

  def find(value, node = @root)
    return nil unless root

    if node.value == value
      node
    elsif node.value > value
      find(value, node.left)
    elsif node.value < value
      find(value, node.right)
    end
  end

  def find_min(node = @root)
    current = node
    current = current.left while current.left
    curren.value
  end

  def delete(value, node = @root, parent = nil)
    return nil unless root

    if node.value > value
      delete(value, node.left, node)
    elsif node.value < value
      delete(value, node.right, node)
    else
      if @root == node 
        current_node = node.left || node.right
        @root = current_node
      elsif node.left && node.right
        value = find_min(node)
        node.value = value
        delete(value, node.right, node)
      else
        current_node = node.left || node.right
        if parent.left.value == value
          parent.left = current_node
        else
          parent.right = current_node
        end
      end
    end
  end

  private

  def insert_helper(value, root)
    if root.value > value
      if root.left
        insert_helper(value, root.left)
      else
        root.left = TreeNode.new(value)
      end
    else
      if root.right
        insert_helper(value, root.right)
      else
        root.right = TreeNode.new(value)
      end
    end
  end
end
