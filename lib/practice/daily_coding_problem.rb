require 'byebug'

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

tree_node0 = TreeNode.new('g', nil, nil)
tree_node1 = TreeNode.new('e', nil, nil)
tree_node2 = TreeNode.new('f', nil, nil)
tree_node3 = TreeNode.new('b', nil, tree_node1)
tree_node4 = TreeNode.new('c', nil, tree_node0)
tree_node5 = TreeNode.new('d', tree_node2, tree_node3)
root = TreeNode.new('a', tree_node4, tree_node5)

def level_order(root)
  level_order = []
  queue = [root]

  while queue.any?
    node = queue.shift
    queue.push << node.left if node.left
    queue.push << node.right if node.right
    level_order.push << node.value
  end

  level_order
end

p level_order(root)

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

# 7.1. Find floor and ceiling for a given integer in BST
def find_floor_and_ceiling(node, x, floor = nil, ceiling = nil)
  return [floor, ceiling] unless root

  if x == node.data
    return [x, x]
  elsif x > node.data
    find_floor_and_ceiling(node.right, x, node.value, ceiling)
  elsif x < node.data
    find_floor_and_ceiling(node.left, x, floor, node.value)
  end

  [floor, ceiling]
end

# 7.2. Convert a sorted array to BST
# O(n) time and space
def make_bst_from_array(arr)
  return nil unless arr.any?

  mid = arr[arr.length / 2]

  root = TreeNode.new(arr[mid])
  root.left = arr[0..arr.length / 2  - 1]
  root.right = arr[arr.length / 2  + 1..-1]
  root
end

# 7.3. Construct all possible BSTs with n nodes from [1...N]
# O(n x 2expn) time and space complexity
preorder_results = []
def preorder(node = nil)
  preorder_results << node.value
  preorder(node.left)
  preorder(node.right)
end

def make_trees(low, high)
  trees = []

  if low > high
    trees.push(nil)
    return trees
  end

  (low..high).each do |i|
    left = make_trees(low..i - 1)
    right = make_trees(i + 1..high)

    left.each do |left_element|
      right.each do |right_element|
        node = TreeNode.new(i, left_element, right_element)
        tree_nodes.push(node)
      end
    end
  end

  trees
end

def construct_bsts(n)
  trees = make_trees(1, n)
  trees.each do |tree|
    p(preorder(tree))
  end
end

# 8. Tries
# Can be implemented with nodes/hash

class HashTrie
  END_SIGN = '#'
  attr_reader :store

  def initialize
    @store = {}
  end

  def find(str)
    trie = store.clone
    str.each_char do |char|
      if trie[char]
        trie = trie[char]
      else
        return []
      end
    end
    elements(str, trie)
  end

  def elements(str, trie, result = [])
    trie.each do |k, v|
      if k == END_SIGN
        result.push(str)
      else
        new_string = str.clone + k
        elements(new_string, v, result)
      end
    end
    result
  end

  def insert(word)
    trie = store
    word.each_char.with_index do |char, i|
      trie[char] = {} unless trie[char]
      trie = trie[char]
    end
    trie['#'] = true
  end
end

# ht = HashTrie.new
# ht.insert('ba')
# ht.insert('bac')
# ht.insert('bae')
# p ht
# p ht.find('ba')

# class NodeTrie
# end

# 8.2. Create PrefixMapSum class
# 8.3. Find Max XOR of element pairs

# 9. Heaps

# Min Heap

class MinHeap
  attr_reader :store

  def initialize
    @store = [nil]
  end

  def length
    store.length
  end

  def min
    store[1]
  end

  def add(value)
    store.push(value)
    return if store.length < 3

    i = store.length - 1

    while i > 1 && store[i] < store[i / 2]
      store[i], store[i / 2] = store[i / 2], store[i]
      i /= 2
    end
  end

  def delete_min
    return nil if store.length <= 1
    return store.pop if store.length == 2

    smallest = store[1]
    store[1] = store.pop
    
    return smallest if store.length == 2

    if store.length == 3
      store[1], store[2] = store[2], store[1] if store[2] < store[1]
      return smallest
    end

    i = 1
    left = i * 2
    right = i * 2 + 1

    while store[i] > store[left] || store[i] > store[right]
      if store[left] < store[right]
        store[i], store[left] = store[left], store[i]
        i *= 2
      else
        store[i], store[right] = store[right], store[i]
        i = i * 2 + 1
      end

      left = i * 2
      right = i * 2 + 1

      break unless store[left] && store[right]
    end
  
    smallest
  end

  def heap_sort
    result = []

    result.push << store.pop while store.length > 1

    result
  end
end

class MaxHeap
  attr_reader :store

  def initialize
    @store = [nil]
  end

  def length
    store.length
  end

  def max
    store[1]
  end

  def add(value)
    store.push(value)

    return if store.length < 3

    i = store.length - 1

    while i > 1 && store[i] > store[i / 2]
      store[i], store[i / 2] = store[i / 2], store[i]
      i /= 2
    end
  end

  def delete_max
    return nil if store.length <= 1
    return store.pop if store.length == 2

    largest = store[1]
    store[1] = store.pop

    return smallest if store.length == 2

    if store.length == 3
      store[1], store[2] = store[2], store[1] if store[1] < store[2]
      return largest
    end

    i = 1
    left = i * 2
    right = i * 2 + 1

    while store[i] < store[left] || store[i] < store[right]
      if store[left] < store[right]
        store[right], store[i] = store[i], store[right]
      else
        store[left], store[i] = store[i], store[left]
      end  

      i *= 2
      left = i * 2
      right = i * 2 + 1

      break unless store[left] && store[right]
    end

    largest
  end

  def heap_sort
    result = []

    result.push(store.pop) while store.length > 1

    result
  end
end

# 9.1. Compute the running median
min_heap = MinHeap.new
max_heap = MaxHeap.new

def add_to_median(num, min_heap, max_heap)
  if min_heap.length + max_heap.length < 1
    min_heap.add(num)
    return
  end

  median = get_median(min_heap, max_heap)

  if num > median
    min_heap.add(num)
  else
    max_heap.add(num)
  end
end

def rebalance_heaps(min_heap, max_heap)
  if min_heap.length > max_heap.length + 1
    max_heap.add(min_heap.delete_min)
  end

  if max_heap.length > min_heap.length + 1
    min_heap.add(max_heap.delete_max)
  end
end

def get_median(min_heap, max_heap)
  if min_heap.length > max_heap.length
    min_heap.min
  elsif min_heap.length < max_heap.length
    max_heap.max
  else
    (min_heap.min.to_f + max_heap.max.to_f) / 2
  end
end

def running_median(arr, min_heap, max_heap)
  arr.each do |number|
    add_to_median(number, min_heap, max_heap)
    rebalance_heaps(min_heap, max_heap)
    p get_median(min_heap, max_heap)
  end
end

# running_median([1, 4, 5, 9, 22, 44], min_heap, max_heap)

# 10 Graphs
def simple_bfs(graph, root)
  queue = [root]
  visited = {}

  while queue.any?
    node = queue.shift
    next if visited[node]

    visited[node] = true

    graph[node].each do |connection|
      queue.push(connection) unless visited[connection]
    end
  end

  visited.map { |k, _v| k }
end

def simple_dfs(graph, root)
  stack = [root]
  visited = {}

  while stack.any?
    node = stack.pop
    next if visited[node]

    visited[node] = true

    graph[node].each do |connection|
      stack.push(connection) unless visited[connection]
    end
  end

  visited.map { |k, _v| k }
end

def dfs_helper(graph, node, visited)
  return if visited[node]

  visited[node] = true

  graph[node].each do |connection|
    dfs_helper(graph, connection, visited) unless visited[connection]
  end
end

def dfs_with_recursion(graph, root, visited = {})
  dfs_helper(graph, root, visited = {})
  visited.map { |k, _v| k }
end

# 10.5 Topological sort

def topological_helper(graph, node, tsorted, visited = {})
  return if visited[node]

  visited[node] = true

  graph[node].each do |connection|
    topological_helper(graph, connection, tsorted, visited) unless visited[connection]
  end

  tsorted.unshift(node) unless tsorted.include?(node)
end

def topological_sort(graph, root, tsorted = [])
  topological_helper(graph, root, tsorted)
  tsorted
end

graph = {
  'a' => ['b', 'c'],
  'b' => ['e', 'f'],
  'c' => ['d', 'e'],
  'd' => ['f', 'g'],
  'e' => [],
  'f' => [],
  'g' => []
}

# p simple_bfs(graph, 'a')
# p simple_dfs(graph, 'a')
# p dfs_with_recursion(graph, 'a')
# p topological_sort(graph, 'a')

# 12. Recursion

# Write the factorial function recursively

# 5! => 5 * 4!
def factorial(n)
  return n if n <= 1

  n * factorial(n - 1)
end

def recursive_reverse(str)
  return str if str.length <= 1

  str[-1] + recursive_reverse(str[0..-2])
end

# Fibonacci f(n) = f(n-1) + f(n-2)
# O(2^N) runtime, O(N) space
def fib_no_memo(n)
  return n if n <= 1

  fib_no_memo(n - 1) + fib_no_memo(n - 2)
end

# O(N) runtimem O(N) space
def fib_memo(n, memo = {})
  return n if n <= 1

  memo[n] ||= fib_memo(n - 1, memo) + fib_memo(n - 2, memo)

  # return memo[n] if memo[n]

  # memo[n] = fib_memo(n - 1, memo) + fib_memo(n - 2, memo)
  # memo[n]
end

# p Time.now
# p fib_no_memo(40)
# p Time.now
# p fib_memo(40)
# p Time.now

def tower_of_hanoi(n, a = '1', b = '2', c = '3')
  return unless n >= 1

  tower_of_hanoi(n - 1, a, c, b)
  p "Move size #{n} from #{a} to #{c}"
  tower_of_hanoi(n - 1, b, a, c)
end

# tower_of_hanoi(5)

# Given a target amount n and a list of array of distinct coin
# values [1,2,5,10], what is the fewest coins needed to make the change amount
# For 10 -> 1 (1 10cents), 8 -> 3 1penny
# This is a pretty inefficient in time/space

def min_coins(target, coins)
  min_coins = target
  return 1 if coins.include?(target)

  coins.each do |coin|
    next unless coin <= target
    num_coins = 1 + min_coins(target - coin, coins)

    min_coins = num_coins if num_coins < min_coins
  end

  min_coins
end

# 13. Dynamic programming

def coin_ways_top_down(num, coins, memo = {})
  return 0 if num < 0
  return 1 if num == 0
  return memo[num] if memo[num]

  memo[num] = coins.inject { |sum, coin| sum + coin_ways_top_down(num - coin, coins, memo) }
  memo[num]
end

p coin_ways_top_down(1, [1, 5])

def coin_ways_bottom_up()

end

# Count the paths from top-left corner to bottom-right
# Can step right or down.
# 00000000
# 00X000X0
# 0000X000
# X0X00X00
# 00X00000
# 000XX0X0
# 0X000X00
# 00000000

$count_no_memo = 0
def count_steps_no_memo(board, row, col)
  $count_no_memo += 1
  return 0 if row >= board.length
  return 0 if col >= board.first.length
  return 0 if board[row][col] == 'X'
  return 1 if row == board.length - 1 && col == board.first.length - 2
  return 1 if row == board.length - 2 && col == board.first.length - 1

  count_steps_no_memo(board, row, col + 1) + count_steps_no_memo(board, row + 1, col)
end

$count_memo = 0
def count_steps(board, row, col, memo = {})
  $count_memo += 1
  return 0 if row >= board.length
  return 0 if col >= board.first.length
  return 0 if board[row][col] == 'X'
  return 1 if row == board.length - 1 && col == board.first.length - 2
  return 1 if row == board.length - 2 && col == board.first.length - 1

  memo["r#{row}c#{col}"] ||= count_steps(board, row, col + 1, memo) + count_steps(board, row + 1, col, memo)
end

board = [
  ['O', 'O', 'O', 'O', 'O', 'O', 'O', 'O'],
  ['O', 'O', 'X', 'O', 'O', 'O', 'X', 'O'],
  ['O', 'O', 'O', 'O', 'X', 'O', 'O', 'O'],
  ['X', 'O', 'X', 'O', 'O', 'X', 'O', 'O'],
  ['O', 'O', 'X', 'O', 'O', 'O', 'O', 'O'],
  ['O', 'O', 'O', 'X', 'X', 'O', 'X', 'O'],
  ['O', 'X', 'O', 'O', 'O', 'X', 'O', 'O'],
  ['O', 'O', 'O', 'O', 'O', 'O', 'O', 'O']
]

# p count_steps_no_memo(board, 0, 0)
# p count_steps(board, 0, 0)
# p $count_no_memo
# p $count_memo

# Count the number of ways climbing a stair_case (where max_step is defined)
def number_of_ways_stair_case(n, step_sizes = [1, 2])
  return 0 if n < 0
  return 1 if n == 0

  sum = 0
  step_sizes.each do |step_size|
    sum += number_of_ways_stair_case(n - step_size, step_sizes)
  end
  sum
end

def number_of_ways_stair_case_no_inject(n)
  return 0 if n < 0
  return 1 if n == 0
  number_of_ways_stair_case_no_inject(n - 1) + number_of_ways_stair_case_no_inject(n - 2)
end

def number_of_ways_stair_case_no_inject_memo(n, memo = {})
  return 0 if n < 0
  return 1 if n == 0
  memo[n] ||= number_of_ways_stair_case_no_inject_memo(n - 1, memo) + number_of_ways_stair_case_no_inject_memo(n - 2, memo)
end

def number_of_ways_stair_case_with_memo(n, step_sizes = [1, 2], memo = {})
  return 0 if n < 0
  return 1 if n == 0

  sum = 0
  step_sizes.each do |step_size|
    if memo[n - step_size]
      sum += memo[n - step_size]
      next
    end
    memo[n - step_size] = number_of_ways_stair_case_with_memo(n - step_size, step_sizes, memo)
    sum += memo[n - step_size]
  end
  sum
end

# p number_of_ways_stair_case(35)
# p number_of_ways_stair_case_no_inject(35)
# p number_of_ways_stair_case_no_inject_memo(35)
# p number_of_ways_stair_case_with_memo(35)

# 14. Backtracking

# N queens problem

def safe_queen_condition?(queens, row, col)
  return false unless queens.none? { |q| q[0] == row }
  return false unless queens.none? { |q| q[1] == col }
  return false unless queens.none? { |q| (q[0] - row).abs == (q[1] - col).abs }

  true
end

def n_queens
  queens_left = 8
  queens = []

  row = 0
  col = 0

  while queens_left > 0
    row.upto(7) do |current_row|
      col.upto(7) do |current_col|
        if safe_queen_condition?(queens, current_row, current_col)
          queens.push([current_row, current_col])
          row = 0
          col = 0
          break if queens.length > 8 - queens_left
        end
      end
      break if queens.length > 8 - queens_left
    end
    
    if queens.length > 8 - queens_left
      queens_left -= 1 
      next
    end

    removed_queen = queens.pop
    queens_left += 1
    if removed_queen[1] < 7
      row = removed_queen[0]
      col = removed_queen[1] + 1
    else
      row = removed_queen[0] + 1
      col = 0
    end
  end

  queens
end

# p n_queens

# 14.2. Sudoku

def current_row_condition?(num, board, current_row)
  board[current_row].each do |box|
    box.each do |col|
      return false if col == num
    end
  end
  true
end

def current_box_condition?(num, board, current_row, current_box)
  box_area = current_row / 3

  board.each_with_index do |row, i|
    next unless i / 3 == box_area
    row[current_box].each do |col|
      return false if col == num
    end
  end

  true
end

def current_col_condition?(num, board, current_col)
  board.each do |row|
    row.each do |box|
      return false if box[current_col] == num
    end
  end
  true
end

def safe_num_condition?(num, board, current_row, current_box, current_col)
  if current_row_condition?(num, board, current_row) &&
     current_box_condition?(num, board, current_row, current_box) &&
     current_col_condition?(num, board, current_col)
    return true
  end
  false
end

def sudoku(start_board)
  base_remaining_nums = 81
  start_board.each do |row|
    row.each do |box|
      box.each do |col|
        base_remaining_nums -= 1 if col.is_a? Integer
      end
    end
  end
  

  current_board = start_board.clone
  added_num_and_coords = []

  num = 1
  row = 0
  box = 0
  col = 0
  remaining_nums = base_remaining_nums

  while remaining_nums > 0
    p added_num_and_coords
    row.upto(8) do |current_row|
      box.upto(2) do |current_box|
        col.upto(2) do |current_col|
          if current_board[current_row][current_box][current_col].is_a? Integer
            next
          end
          num.upto(9) do |current_num|
            if safe_num_condition?(current_num, current_board, current_row, current_box, current_col)
              current_board[current_row][current_box][current_col] = current_num
              added_num_and_coords.push([current_num, current_row, current_box, current_col])
              break
            end
          end
          if added_num_and_coords.length == base_remaining_nums - remaining_nums
            added_num_and_coords_last = added_num_and_coords.pop
            current_board[added_num_and_coords_last[1]][added_num_and_coords_last[2]][added_num_and_coords_last[3]] = nil
            num = added_num_and_coords_last[0] + 1
            row = 0
            box = 0
            col = 0
            remaining_nums += 1
          end
          break if added_num_and_coords.length > base_remaining_nums - remaining_nums
        end
        break if added_num_and_coords.length > base_remaining_nums - remaining_nums
      end
      break if added_num_and_coords.length > base_remaining_nums - remaining_nums
    end

    if added_num_and_coords.length > base_remaining_nums - remaining_nums
      remaining_nums -= 1
      next
    end

    added_num_and_coords_last = added_num_and_coords.pop
    current_board[added_num_and_coords_last[1]][added_num_and_coords_last[2]][added_num_and_coords_last[3]] = nil
    num = added_num_and_coords_last[0] + 1
    row = added_num_and_coords_last[1]
    box = added_num_and_coords_last[2]
    col = added_num_and_coords_last[3]
    remaining_nums += 1

    # added_num_and_coords_last = added_num_and_coords.pop
    # current_board[added_num_and_coords_last[1]][added_num_and_coords_last[2]][added_num_and_coords_last[3]] = nil
    # remaining_nums += 1
    # p "HAHA"
    # p added_num_and_coords
  end

  current_board
end

start_state_sudoku = [
  [[2, 5, nil], [nil, 3, nil], [9, nil, 1]],
  [[nil, 1, nil], [nil, nil, 4], [nil, nil, nil]],
  [[4, nil, 7], [nil, nil, nil], [2, nil, 8]],
  [[nil, nil, 5], [2, nil, nil], [nil, nil, nil]],
  [[nil, nil, nil], [nil, 9, 8], [1, nil, nil]],
  [[nil, 4, nil], [nil, nil, 3], [nil, nil, nil]],
  [[nil, nil, nil], [3, 6, nil], [nil, 7, 2]],
  [[nil, 7, nil], [nil, nil, nil], [nil, nil, 3]],
  [[9, nil, 3], [nil, nil, nil], [6, nil, 4]]
]

# sudoku(start_state_sudoku)

# 15. Searching/sorting
def binary_search(arr, num)
  low = 0
  high = arr.length - 1

  while low <= high
    mid = (high + low) / 2

    if arr[mid] > num
      high = mid - 1
    elsif arr[mid] < num
      low = mid + 1
    else
      return mid
    end
  end

  nil
end

# p binary_search([1, 3, 5, 7, 9, 11], 11)

# 15.1 Dutchflag problem
# Given chars of R, G and B, segregate the values of the array
# so Rs come first, Gs second and Bs come last.


def dutch_flag(arr)
  low = 0
  mid = 0
  high = arr.length - 1

  while mid <= high
    if arr[mid] == 'R'
      arr[low], arr[mid] = arr[mid], arr[low]
      low += 1
      mid += 1
    elsif arr[mid] == 'G'
      mid += 1
    elsif arr[mid] == 'B'
      arr[high], arr[mid] = arr[mid], arr[high]
      high -= 1
    end
  end

  arr
end

# p dutch_flag(['R', 'G', 'B', 'G', 'B', 'R', 'R', 'B', 'G'])

class Minesweeper
  attr_reader :board

  def initialize(row = 10, col = 10, bombs = 10)
    @board = Array.new(row) { Array.new(col) { { val: 0, open: false } } }
    @bombs = bombs
    build_board
  end

  def click(row, col)
    if board[row][col][:open]
      puts 'Already revealed'
      print_board
      return
    end

    if board[row][col][:val] == 'X'
      return 'You loose'
    else
      board[row][col][:open] = true
      open_zero_fields(row, col) if board[row][col][:val] == 0
    end
    print_board
  end

  def open_zero_fields(row, fields)
    
  end

  def print_board
    board.each do |row|
      row_values = []
      row.each do |col|
        if col[:open] == false
          row_values << '?'
        else
          row_values << col[:val]
        end
      end
      p row_values
    end
  end

  private

  def build_board
    bomb_number = 0

    until bomb_number == 10
      next if board[rand(0..board.length - 1)][rand(0..board.first.length - 1)][:val] == 'X'
      board[rand(0..board.length - 1)][rand(0..board.first.length - 1)][:val] = 'X'
      bomb_number += 1
    end

    board.each_with_index do |row, i|
      row.each_with_index do |col, j|
        next unless col[:val] == 'X'

        (-1).upto(1) do |k|
          (-1).upto(1) do |l|
            next if i + k < 0 || i + k > board.length - 1
            next if j + l < 0 || j + l > board.first.length - 1
            next if board[i + k][ j + l][:val] == 'X'
            board[i + k][ j + l][:val] += 1
          end
        end
      end
    end
  end
end

# minesweeper = Minesweeper.new
# minesweeper.click(1, 2)
