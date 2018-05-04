require 'byebug'
# def merge_sort(arr)
#   return arr if arr.length <= 1

#   mid = arr.length / 2

#   left = merge_sort(arr[0..mid - 1])
#   right = merge_sort(arr[mid..-1])

#   if left.max <= right.min
#     left + right
#   else
#     merge(left, right)
#   end
# end

# def merge(left, right)
#   return right if left.empty?
#   return left if right.empty?

#   if left.first < right.first
#     [left.first] + merge(left[1..-1], right)
#   else
#     [right.first] + merge(left, right[1..-1])
#   end
# end

# p merge_sort([3,4,1,2,88,22])

# def quick_sort(arr)
#   quick_sort_helper(arr, 0, arr.length - 1)
# end

# def quick_sort_helper(arr, first, last)
#   return arr unless first < last
#   split_point = quick_partition(arr, first, last)
#   quick_sort_helper(arr,first, split_point - 1)
#   quick_sort_helper(arr,split_point + 1, last)
# end

# def quick_partition(arr, first, last)
#   pivot = arr[first]

#   left_mark = first + 1
#   right_mark = last

#   loop do
#     while left_mark <= right_mark && arr[left_mark] <= pivot
#       left_mark += 1
#     end

#     while left_mark <= right_mark && pivot <= arr[right_mark]
#       right_mark -= 1
#     end

#     break if left_mark > right_mark

#     arr[left_mark], arr[right_mark] = arr[right_mark], arr[left_mark]
#   end

#   arr[first], arr[right_mark] = arr[right_mark], arr[first]

#   right_mark
# end

# p quick_sort([3,4,1,2,88,22])

# def quick_select(arr, nth)
#   quick_select_partition(arr, nth - 1, 0, arr.length - 1)
# end

# def quick_select_partition(arr, nth, first, last)
#   pivot = arr[first]
#   left_mark = first + 1
#   right_mark = last

#   loop do
#     while left_mark <= right_mark && arr[left_mark] <= pivot
#       left_mark += 1
#     end

#     while left_mark <= right_mark && arr[right_mark] >= pivot
#       right_mark -= 1
#     end

#     break if left_mark > right_mark
#     arr[left_mark], arr[right_mark] = arr[right_mark], arr[left_mark]
#   end

#   if right_mark < nth
#     quick_select_partition(arr, nth, right_mark + 1, last)
#   elsif right_mark > nth
#     quick_select_partition(arr, nth, first, right_mark - 1)
#   else
#     arr[right_mark]
#   end
# end

# p quick_select([3,6,9], 2)

# def binary_search(arr, num, first = 0, last = nil)
#   last = arr.last unless last
#   return nil if first > last

#   mid = (first + last) / 2

#   if arr[mid] > num
#     binary_search(arr, num, first, mid - 1)
#   elsif arr[mid] < num
#     binary_search(arr, num, mid + 1, last)
#   else
#     mid
#   end
# end

# p binary_search([1,3,5,7], 7)
# class Node
#   attr_accessor :children, :data, :endpoint

#   def initialize(data = nil)
#     @children = {}
#     @data = data
#     @endpoint = false
#   end
# end

# class Trie
#   attr_reader :root

#   def initialize
#     @root = Node.new
#   end

#   def add(string, data, node = root)
#     if string.empty?
#       node.data = data
#       node.endpoint = true
#     elsif node.children.keys.include?(string[0])
#       add(string[1..-1], data, node.children[string[0]])
#     else
#       node.children[string[0]] = Node.new
#       add(string[1..-1], data, node.children[string[0]])
#     end
#   end

#   def find(string, node = root)
#     return nil unless node

#     if string.empty? && node.endpoint?
#       node.data
#     elsif node.children.keys.include?(string[0])
#       find(string[1..-1], node)
#     else
#       nil
#     end
#   end

#   def find_all(node = root)
#     words = []
#     collect(node, '', words)
#     words
#   end

#   def find_all_with_term(term = '', node = root)
#     words = []
#     collect_with_term(node, term, '', words)
#     words
#   end

#   private

#   def collect(node, string, words)
#     if node.children.any?
#       node.children.each_key do |letter|
#         new_string = string.clone + letter
#         collect(node.children[letter], new_string, words)
#       end

#       words << string if node.endpoint
#     else
#       words << string unless string.empty?
#     end

#     words
#   end

#   def collect_with_term(node, term, string, words)
#     return nil unless node

#     if term.empty?
#       collect(node, string, words)
#     elsif node.children.keys.include?(term[0])
#       new_string = string.clone + term[0]
#       collect_with_term(node.children[term[0]], term[1..-1], new_string, words)
#     end

#     words
#   end
# end

# ttrie = Trie.new
# ttrie.add('hackerrank', date: '1988-02-26')
# ttrie.add('hack', date: '1977-02-12')
# ttrie.add('danny', date: '1998-04-21')
# ttrie.add('jane', date: '1985-05-08')
# ttrie.add('jack', date: '1994-11-04')
# ttrie.add('pete', date: '1977-12-18')
# p ttrie.find_all
# p ttrie.find_all_with_term('ja')

# class Car
#   def top_speed
#     100
#   end

#   def haha
#     'hihi'
#   end
# end

# class CarDecorator
#   attr_reader :component

#   def initialize(component)
#     @component = component
#   end

#   def haha
#     component.haha
#   end
# end

# class Nitro < CarDecorator
#   attr_reader :component

#   def initialize(component)
#     super(component)
#   end

#   def top_speed
#     component.top_speed + 10
#   end
# end

# class Boost < CarDecorator
#   attr_reader :component

#   def initialize(component)
#     super(component)
#   end

#   def top_speed
#     component.top_speed + 30
#   end
# end

# p Nitro.new(Boost.new(Car.new)).haha

# def sort_by_frequency(arr)
#   store = {}
#   max = 0

#   arr.each do |element|
#     if store[element]
#       store[element] += 1
#       max = [store[element], max].max
#     else
#       store[element] = 1
#       max = 1
#     end
#   end

#   bucket = Array.new(max) { [] }

#   store.each do |key, value|
#     bucket[max - value].push([key, value.to_s])
#   end

#   bucket.flatten(1)
# end

# p sort_by_frequency(['b', 'c', 'a', 'b', 'a', 'a', 'd', 'b'])

# class Node
#   def initialize(key, data)
#     @key = key
#     @data = data
#     @prev = nil
#     @next = nil
#   end
# end

# class LRU
#   def initialize(max_items = 5)
#     @max_items = max_items
#     @head = nil
#     @tail = nil
#     @size += 1
#     @store = {}
#   end

#   def set(key, data)
#     if @store[key]
#       node = @store[key]
#       node.data = data

#       if node.prev_node && node.next_node
#         node.prev_node.next_node = node.next_node.prev_node
#         node.next_node.prev_node = node.prev_node.next_node
#       elsif node.prev_node
#         node.prev_node.next_node = nil
#       elsif node.next_node
#         node.next_node.prev_node = nil
#       end
#     else
#       @size += 1
#       node = Node.new(key, data)
#       @store[key] = node
#     end

#     if @size == 1
#       @store[key] = node
#       @head = node
#       @tail = node
#       return node
#     end

#     if @size > max_items
#       oldest_key = @tail.key
#       @tail = @tail.prev_node
#       @tail.next_node = nil
#       @store.delete(oldest_key)
#       @size -= 1
#     end

#     @head.prev_node = node
#     node.next_node = @head

#     @head = node
#   end

#   def get(key)
#   end
# end

# post, bar, eat, rab, opts, tops, tea
# post => 'post', 'opts'

# def anagram_group(arr)

# end

# clone a connected not directed graph

# graph = {
#   'A': ['B', 'C'],
#   'B': ['A', 'D'],
#   'C': ['A', 'D'],
#   'D': ['B', 'C']
# }

# def clone_graph(graph, start_node)
#   new_graph = {}

#   visited = {}
#   queue = [start_node]

#   while queue.any?
#     node = queue.shift

#     next if visited[node]
#     visited[node] = 1

#     graph[node.to_sym].each do |neighbor|
#       if new_graph[node.to_sym]
#         new_graph[node.to_sym].push(neighbor)
#       else
#         new_graph[node.to_sym] = [neighbor]
#       end
#       queue.push(neighbor)
#     end
#   end

#   new_graph
# end

# p graph
# p clone_graph(graph, 'A')

# 1.upto(100).each do |el|
#   str = ''
#   str << 'fizz' if el % 3 == 0
#   str << 'buzz' if el % 5 == 0
#   puts str unless str.empty?
# end

# Flatten nested hashes and compare them.
# {
#     :a => {
#        :b => {:c => 1, :d => 2},
#        :e => 3,
#     },
#     :f => 4,
# }
# INTO
# {
#     [:a, :b, :c] => 1,
#     [:a, :b, :d] => 2,
#     [:a, :e] => 3,
#     [:f] => 4,
# }

def flat_hash(h, k=[])
  new_hash = {}

  h.each_pair do |key, val|
    if val.is_a?(Hash)
      new_hash.merge!(flat_hash(val, k + [key]))
    else
      new_hash[k + [key]] = val
    end
  end

  new_hash
end

# print flat_hash({
#     :a => {
#        :b => {:c => 1, :d => 2},
#        :e => 3,
#     },
#     :f => 4,
# })

# Find k largest element in an unsorted array

# 1. Bubble sort (outer loop k times)
# time complexity O(n*k)
def k_largest_with_bubble_sort(array, k)
  k.times do |number|
    (array.length - 1).times do |element|
      if array[element] > array[element + 1]
        array[element], array[element + 1] = array[element + 1], array[element]
      end
    end
  end

  array[array.length - k..-1]
end

# print k_largest_with_bubble_sort([8,5,3,9,1,4,7,0,11,2], 3)

# 2. Temporary array
def k_largest_with_temp_array(array, k)
  temp = array[0..k-1]

  array[k..-1].each do |num|
    temp_min_index = temp.each_with_index.min.last
    if num > array[temp_min_index]
      temp.delete_at(temp_min_index)
      temp.push(num)
    end
  end

  # sorting if needed
  temp.sort!

  temp
end

# print k_largest_with_temp_array([8,5,3,11,1,4,7,0,9,2], 3)

# 3. Sorting algorithms

# 4. Min heap
class MaxHeap
  attr_accessor :store

  def initialize
    @store = [nil]
  end

  def add(value)
    store.push(value)
    length = store.length

    i = length - 1

    return if length < 3

    while i > 1 && store[i] > store[i / 2]
      store[i / 2], store[i] = store[i], store[i / 2]
      i /= 2
    end
  end

  def remove
    return nil if store.length == 1
    return store.pop if store.length == 2

    largest = store[1]

    store[1] = store.pop

    if store.length == 3
      store[1], store[2] = store[2], store[1] if store[2] > store[1]
      return largest
    end

    return largest if store.length == 2

    i = 1
    left = i * 2
    right = i * 2 + 1

    while store[i] < store[left] || store[i] < store[right]
      if store[left] < store[right]
        store[i], store[right] = store[right], store[i]
        i = i * 2 + 1
      else
        store[i], store[left] = store[left], store[i]
        i *= 2
      end

      left = i * 2
      right = i * 2 + 1
      break if store[left].nil? || store[right].nil?
    end

    largest
  end
end

def k_largest_with_max_heap(array, k)
  max_heap = MaxHeap.new

  array.each do |element|
    max_heap.add(element)
  end

  k_largest = []
  
  k.times do
    k_largest.push(max_heap.remove)
  end

  k_largest
end

# print k_largest_with_max_heap([8,5,3,11,1,4,7,0,9,2], 3)

# create a dynamic array

class DynamicArray
  attr_reader :array, :capacity

  def initialize(capacity = 1)
    @capacity = capacity
    @number = 0
    @array = Array.new(@capacity)
  end

  def push(value)
    resize if @number == @capacity

    @array[@number] = value
    @number += 1
  end

  def [](i)
    raise 'IndexError' unless 0 <= i && i < @number
  end

  def []=(i, val)
    raise 'IndexError' unless 0 <= i && i <= @number
    @number += 1 if i == @number
    array[i] = val
  end

  private

  def resize
    @capacity *= 2
    doubled_array = Array.new(@capacity)
    @number.times { |i| doubled_array[i] = @array[i] }
    @array = doubled_array
  end
end

# implement a queue with 2 stacks
class QueueWithTwoStacks
  attr_reader :stack1, :stack2

  def initialize
    @stack1 = []
    @stack2 = []
  end

  def enqueue(val)
    @stack1.push(val)
  end

  def dequeue
    if @stack2.empty?
      @stack2.push(@stack1.pop) until @stack1.empty?
    end

    @stack2.pop
  end
end

class StackWithQueues
  attr_reader :queue1, :queue2

  def initialize
    @queue1 = []
    @queue2 = []
  end

  def push(val)
    queue1.push(val)
  end

  def pop
    queue2.push(queue1.shift) while queue1.length > 1

    value = queue1.shift

    @queue1, @queue2 = @queue2, @queue1

    value
  end
end

module StackAndQueueWithLinkedList
  class Node
    attr_reader :next_node, :value

    def initialize(value, next_node = nil)
      @value = value
      @next_node = next_node
    end
  end

  class Stack
    def initialize
      @first = nil
    end

    def push(val)
      @first = Node.new(value, @first)
    end

    def pop
      raise 'Stack is empty' if @first.nil?
      value = @first.value
      @first = @first.next_node
      value
    end
  end

  class Queue
    def initialize
      @first = nil
      @last = nil
    end

    def enqueue(val)
      node = Node.new(val, nil)
      @last&.next_node = node
      @last = node
      @first = node unless @first
    end

    def dequeue
      raise 'Empty' if @first.nil?
      value = @first.value
      @last = nil unless @first.next_node
      @first = @first.next_node
    end
  end
end

class LRUNode
  attr_accessor :key, :value, :prev_node, :next_node

  def initialize(key, value)
    @key = key
    @value = value
    @prev_node = prev_node
    @next_node = next_node
  end
end

class LRUCache
  def initialize(capacity)
    @capacity = capacity
    @store = {}
    @head = nil
    @tail = nil
    @size = 0
  end

  def set(key, value)
    if @store[key]
      @store[key].value = value
      return if @size == 1
      return if @store[key].next_node.nil?
      @store[key].next_node.prev_node = @store[key].prev_node
      if @store[key] == @head
         @store[key].next_node = @head
         @head.prev_node = nil
      else
        @store[key].prev_node.next_node = @store[key].next_node
      end
      @tail.next_node = @store[key]
      @store[key].prev_node = @tail
      @tail = store[key]
      return @store[key]
    end

    @size += 1
    new_node = LRUNode.new(key, value)

    if @size > @capacity
      oldest_key = @head.key
      @head = @head.next_node
      @head.prev_node = nil
      @size -= 1
      @store.delete(oldest_key)
    end

    @tail.next_node = new_node
    new_node.prev_node = @tail
    @tail = next_node
    @store[key] = new_node
    new_node
  end

  def get(key)
    result = @store[key]

    return nil unless result
    return result unless result.next_node

    if result.prev_node
      result.prev_node.next_node = result.next_node
      result.next_node.prev_node = result.prev_node
    else
      @head = result.next_node
      @head.prev_node = nil
    end

    @tail.next_node = result
    result.prev_node = @tail
    result.next_node = nil
    @tail = result

    result
  end
end


# 8 queens

class Board
  DEFAULT_SIZE = 4
  attr_accessor :board

  def initialize
    @board = Array.new(DEFAULT_SIZE) { Array.new(DEFAULT_SIZE, 0) }
  end

  def safe?(row, col)
    safe_horizontally?(row) && 
    safe_vertically?(col) &&
    safe_diagonally?(col, row)
  end

  private

  def safe_horizontally?(row)
    @board[row].none? { |val| val == 1 }
  end

  def safe_vertically?(col)
    @board.each do |row|
      return false if row[col] == 1
    end

    true
  end

  def safe_diagonally?(row, col)
    @board.each_with_index do |r, r_index|
      r.each do |c|
        return false if (@board[r_index][c] == 1 && (r_index - row).abs == (c - col).abs) 
      end
    end

    return true
  end
end

def eight_queens
  board = Board.new
  solution_found = false
  place_queen_in_col(board, 0, solution_found)
  # print board.board
end

def place_queen_in_col(board, row, solution_found)
  Board::DEFAULT_SIZE.times do |col|
    if board.safe?(row, col)
      board.board[row][col] = 1
      if row == Board::DEFAULT_SIZE - 1
        print 'solved'
        solution_found = true
      else
        place_queen_in_col(board, row + 1, solution_found)
      end
    end
    # print board.board
    break if solution_found
    board.board[row][col] = 0
  end
end

eight_queens


# Problem 1
# You have the daily prices of gold for a interval of time. You want
# to find two days in this interval such that if you had bought then
# sold gold at those dates, you’d have made the maximum possible profit.

def max_profit(prices)
  return 0 if prices.length == 1
  mid = prices.length / 2
  former = prices[0..(mid-1)]
  latter = prices[mid..-1]
  diff = latter.max - former.min

  [diff, max_profit(former), max_profit(latter)].max
end

prices = [5,1,20,2,4,19]

p max_profit(prices)

# 1775 (or: 11011101111) => 8
def flip_bit(integer)
  binary = integer.to_s(2)

  max = 0
  current = 0
  prev = 0
  gap = 0

  binary.each_char do |char|
    if char == '1'
      current += 1
      gap = 0
    else char == '0'
      prev = current unless gap > 1
      gap += 1
      current = 0
    end

    max = [max, prev + 1 + current].max
  end

  max
end

p flip_bit(1775)
p flip_bit(1767)