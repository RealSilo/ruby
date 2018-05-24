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

def max_profit_2(arr)
  min = arr.first
  diff = 0

  arr.each do |element|
    diff = [element - min, diff].max
    min = [element, min].min
  end

  diff
end

def max_profit_sell_more_times(prices)
  local_diff = 0
  local_min = prices.first
  local_max = prices.first

  prices.each do |price|
    if price > local_max
      local_max = price
    end

    if price < local_max
      local_diff += (local_max - local_min) if local_max - local_min > 0
      local_max = price
      local_min = price
    end
  end

  local_diff += (local_max - local_min) if local_max - local_min > 0

  local_diff
end


prices = [5,1,20,15,2,4,19]

p max_profit(prices)
p max_profit_2(prices)
p max_profit_sell_more_times(prices)

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

states = ['AZ', 'CA', 'CO', 'ID', 'NM', 'NV', 'OR', 'UT', 'WA', 'WY']
stations = {
  'station1': ['CA', 'NV'],
  'station2': ['CA', 'ID', 'OR', 'WA'],
  'station3': ['AZ', 'NM'],
  'station4': ['AZ', 'NV', 'UT'],
  'station5': ['ID', 'MT', 'WY'],
  'station6': ['CO', 'UT', 'WY'],
  'station7': ['ID', 'NV', 'UT']
}

def cover_states(stations, states)
  states_to_cover = states
  # print states_to_cover
  remaining_stations = stations
  picked_station_names = []

  while states_to_cover.any?
    strongest_station_name = nil
    max_covered_states = 0

    remaining_stations.each do |station_name, covered_stats_by_station|
      covered_states =  covered_stats_by_station & states_to_cover

      if covered_states.length > max_covered_states
        max_covered_states = covered_states.length
        strongest_station_name = station_name
      end
    end

    return false unless strongest_station_name
    picked_station_names.push(strongest_station_name)
    states_to_cover -= stations[strongest_station_name]
    remaining_stations.delete(strongest_station_name)
  end

  picked_station_names
end

cover_states(stations, states)

rectangle = {
  left_x: 1,
  bottom_y: 1,
  width: 6,
  height: 3,
}

rectangle2 = {
  left_x: 5,
  bottom_y: 2,
  width: 3,
  height: 6,
}

rectangle3 = {
  left_x: -5,
  bottom_y: -5,
  width: 2,
  height: 2,
}

# Find a method to find the rectangular intersection of two given love rectangles.
def intersection(rectangle, rectangle2)
  x_range = (rectangle[:left_x]..(rectangle[:left_x] + rectangle[:width])).to_a
  y_range = (rectangle[:bottom_y]..(rectangle[:bottom_y] + rectangle[:height])).to_a
  x_range_2 = (rectangle2[:left_x]..(rectangle2[:left_x] + rectangle2[:width])).to_a
  y_range_2 = (rectangle2[:bottom_y]..(rectangle2[:bottom_y] + rectangle2[:height])).to_a

  x_intersection = x_range & x_range_2
  y_intersection = y_range & y_range_2

  return 'No intersection' if x_intersection.length <= 1 || y_intersection.length <= 1

  {
    left_x: x_intersection[0],
    bottom_y: y_intersection[0],
    width: x_intersection[-1] - x_intersection[0],
    height: y_intersection[-1] - y_intersection[0],
  }
end

p intersection(rectangle, rectangle2)

def intersection2(rectangle, rectangle2)
  if rectangle[:left_x] < rectangle2[:left_x]
    intersection_left = rectangle2[:left_x]
  else
    intersection_left = rectangle[:left_x]
  end

  if rectangle[:left_x] + rectangle[:width] < rectangle2[:left_x] + rectangle2[:width]
    intersection_right = rectangle[:left_x] + rectangle[:width]
  else
    intersection_right = rectangle2[:left_x] + rectangle2[:width]
  end

  return 'No intersection' if intersection_right <= intersection_left

  if rectangle[:bottom_y] < rectangle2[:bottom_y]
    intersection_bottom = rectangle2[:bottom_y]
  else
    intersection_bottom = rectangle[:bottom_y]
  end

  if rectangle[:bottom_y] + rectangle[:height] < rectangle2[:bottom_y] + rectangle2[:height]
    intersection_top = rectangle[:bottom_y] + rectangle[:height]
  else
    intersection_top = rectangle2[:bottom_y] + rectangle2[:height]
  end

  return 'No intersection' if intersection_top <= intersection_bottom

  {
    left_x: intersection_left,
    bottom_y: intersection_bottom,
    width: intersection_right - intersection_left,
    height: intersection_top - intersection_bottom,
  }
end

p intersection2(rectangle, rectangle2)

class HashNode
  attr_accessor :key, :val, :next_node

  def initialize(key, val, next_node = nil)
    @key = key
    @val = val
    @next_node = next_node
  end
end

class HashLinkedList
  attr_accessor :head

  def initialize(key, val)
    @head = HashNode.new(key, val)
  end
end

class MyHash
  def initialize(storage_limit = 10)
    @storage_limit = storage_limit
    @storage = []
  end

  def hash(key)
    hash_value = 0

    key.each_char do |char|
      hash_value += char.ord
    end

    hash_value % storage_limit
  end

  def []=(key, val)
    idx = hash(key)

    if @storage[idx]
      current = @storage[idx].head

      while current.next_node
        if current.key == key
          current.val = val
          return current.val
        end

        current = current.next_node
      end

      if current.key == key
        current.val = val
        return current.val
      end

      current.next_node = HashNode.new(key, val)
      current.next_node.val
    else
      @storage[idx] = HashLinkedList.new(key, val)
      @storage[idx].head.val
    end
  end

  def [](key)
    idx = hash(key)

    return nil unless @storage[idx]

    current = @storage[idx].head

    while current
      return current.value if current.key = key
      current = current.next_node
    end

    nil
  end

  def remove(key)
    idx = hash(key)

    return nil unless @storage[idx]

    current = @storage[idx].head

    if current.key == key
      if current.next_node
        @storage[idx].head = current.next_node
      else
        @storage[idx] =nil
      end

      return current.val
    end

    prev = nil

    while current
      if current.key == key
        prev&.next_node = current.next_node
        return current.val
      end  

      prev = current
      current = current.next_node
    end

    nil
  end
end

def merge_sort(array)
  return array if array.length <= 1

  mid = array.length / 2
  left = merge_sort(array[0..mid-1])
  right = merge_sort(array[mid..-1])

  if left.last <= right.first
    left + right
  else
    merge(left, right)
  end
end

def merge(left, right)
  return right if left.empty?
  return left if right.empty?

  if left.first < right.first
    [left.first] + merge(left[1..-1] + right)
  else
    [right.first] + merge(left, right[1..-1])
  end
end

def quick_sort(array)
  quick_sort_helper(array, 0, array.length - 1)
end

def quick_sort_helper(array, first_idx, last_idx)
  return array unless first_idx < last_idx
  split_point = quick_partition(array, first_idx, last_idx)
  quick_sort_helper(array, first_idx, split_point - 1)
  quick_sort_helper(split_point + 1, last_idx)
end

def quick_partition(array, first_idx, last_idx)
  pivot_value = array[first_idx]
  left_mark = first_idx + 1
  right_mark = last_idx

  loop do
    while left_mark <= right_mark && array[left_mark] <= pivot_value
      left_mark += 1
    end

    while left_mark <= right_mark && array[right_mark] >= pivot_value
      right_mark -= 1
    end

    break if right_mark < left_mark
    array[left_mark], array[right_mark] = array[right_mark], array[left_mark]
  end

  array[first], array[right_mark] = array[right_mark], array[first]
  right_mark
end

def bubble_sort(array)
  (array.length - 1).downto(1) do |n|
    n.times do |k|
      if array[k] > array[k + 1]
        array[k], array[k + 1] = array[k + 1], array[k]
      end
    end
  end

  array
end

def quickselect_nth(array, nth)
  return 'Array is not long enought' if array.length - 1 < nth
  quickselect_partition(array, nth, 0, array.length - 1)
end

def quickselect_partition(array, nth, first_idx, last_idx)
  pivot_value = array[first_idx]
  left_mark = array[first_idx + 1]
  right_mark = array[last_idx]

  loop do
    while left_mark <= right_mark && array[left_mark] <= pivot_value
      left_mark += 1
    end

    while left_mark <= right_mark && array[right_mark] >= pivot_value
      right_mark -= 1
    end
    
    break if right_mark < left_mark
    array[left_mark], array[right_mark] = array[right_mark], array[left_mark]
  end

  if right_mark > nth
    quickselect_partition(array, nth, first, right_mark - 1)
  elsif right_mark < nth
    quickselect_partition(array, nth, right_mark + 1, last)
  else
    array[nth]
  end
end

# PROBLEM: There is a sorted array of non-negativ integers and another array
# that is formed by shuffling the elements of the first array and delete a
# random one. Find the missing element!
array_full = [1,3,5,5,5,6,7,7,7,7,7,8]
array_missing = array_full.clone.shuffle
array_missing.delete_at(rand(array_full.length - 1))
def find_missing(array_full, array_missing)
  unless array_full.length > 0 && array_full.length - 1 == array_missing.length
    raise 'Wrong args'
  end

  store = {}

  array_missing.each do |element|
    if store[element]
      store[element] += 1
    else
      store[element] = 1
    end
  end

  array_full.each do |element|
    return element if store[element].nil?
    store[element] -= 1
    return element if store[element] < 0
  end
end

# PROBLEM: Given an array find a pair in it that equals a number (return true if any)
# array is sorted and includes integers (can be negative)
# with args [1, 2, 3, 9], 8 returns false
# with args [1, 2, 4, 4], 8 returns true
arr = [4, 2, 5, 3, 1]
def unsorted_array_pair_sum(array, sum)
  return false if array.length < 2

  store = {}

  array.each do |element|
    return true if store[element]
    store[sum - element] = 1
  end

  false
end
p unsorted_array_pair_sum(arr, 9)

array = [1, 2, 2, 4, 4, 5]
def sorted_array_pair_sum(array, sum)
  length = array.length
  return false if length < 2
  i = 0
  k = length - 1

  until i == k
    current_sum = array[i] + array[k]
    if current_sum > sum
      k -= 1
    elsif current_sum < sum
      i += 1
    else
      return true
    end
  end 

  false
end
p sorted_array_pair_sum(array, 8)

graph_for_simple_dfs_and_bfs = {
  'A' => ['B', 'C'],
  'B' => ['A', 'D', 'E'],
  'C' => ['A', 'F'],
  'D' => ['B'],
  'E' => ['F'],
  'F' => []
}

def simple_bfs(graph, start_node)
  visited = {}
  queue = [start_node]

  while queue.any?
    vertex = queue.shift
    next if visited[vertex]
    visited[vertex] = 1

    graph[vertex].each do |node|
      queue.push(node) unless visited[node]
    end
  end

  visited.map { |k, _v| k }
end
p simple_bfs(graph_for_simple_dfs_and_bfs, 'A')

def simple_bfs_is_there_a_path(graph, start_node, end_node)
  visited = {}
  queue = [start_node]

  while queue.any?
    vertex = queue.shift
    next if visited[vertex]
    visited[vertex] = 1

    graph[vertex].each do |node|
      return true if node == end_node
      queue.push(node) unless visited[node]
    end
  end

  false
end
p simple_bfs_is_there_a_path(graph_for_simple_dfs_and_bfs, 'A', 'F')

def simple_bfs_shortest_path(graph, start_node, end_node)
  visited = {}
  queue = [[start_node]]

  while queue.any?
    path = queue.shift
    vertex = path[-1]
    visited[vertex] = 1

    graph[vertex].each do |node|
      next if visited[node]
      new_path = Array.new(path)
      new_path << node
      return new_path if node == end_node
      queue << new_path
    end
  end

  false
end
p simple_bfs_shortest_path(graph_for_simple_dfs_and_bfs, 'A', 'F')

def simple_dfs(graph, start_node)
  visited = {}
  stack = [start_node]

  while stack.any?
    vertex = stack.pop
    visited[vertex] = 1

    graph[vertex].each do |node|
      next if visited[node]
      stack.push(node)
    end
  end

  visited.map { |k, _v| k }
end
p simple_dfs(graph_for_simple_dfs_and_bfs, 'A')

def simple_dfs_with_recursion(graph, start_node, visited = {})
  dfs_helper(graph, start_node, visited)
  visited.map { |k, _v| k }
end

def dfs_helper(graph, vertex, visited)
  visited[vertex] = 1

  graph[vertex].each do |node|
    dfs_helper(graph, node, visited) unless visited[node]
  end
end
p simple_dfs_with_recursion(graph_for_simple_dfs_and_bfs, 'A')

graph_for_topological = {
  'A' => ['B', 'C'],
  'B' => ['D'],
  'C' => ['D'],
  'D' => ['E', 'F'],
  'E' => ['G'],
  'F' => ['G'],
  'G' => []
}

# TOPOLOGICAL_VISITED = {}
def topological_sort(graph, start_node, sorted = [])
  topological_sort_helper(graph, start_node, sorted)
  sorted
end

def topological_sort_helper(graph, vertex, sorted, visited = {})
  visited[vertex] = 1

  graph[vertex].each do |node|
    topological_sort_helper(graph, node, sorted, visited) unless visited[node]
  end

  sorted.unshift(vertex) unless sorted.include?(vertex)  
end
p topological_sort(graph_for_simple_dfs_and_bfs, 'A')

class BSTNode
  attr_accessor :data, :parent, :left, :right

  def initialize(data, parent = nil, left = nil, right = nil)
    @data = data
    @parent = parent
    @left = left
    @right = right
  end

  def leaf?
    left.nil? && right.nil?
  end

  def has_any_children?
    left || right
  end
end

class BST
  def initialize(root = nil)
    @root = root
    @size = size
  end

  def insert(data, node = @root)
    if @root
      insert_place(data, node)
    else
      @root = BSTNode.new(data)
    end
  end

  def find(data, node = @root)
    return nil unless node

    if node.data > data
      find(data, node.left)
    elsif node.data < data
      find(data, node.right)
    else
      return node
    end
  end

  private

  def insert_place(data, node)
    if data < node.data
      if node.left
        insert_place(data, node.left)
      else
        node.left = BSTNode.new(data, node)
      end
    else
      if node.right
        insert_place(data, node.right)
      else
        node.right = BSTNode.new(data, node)
      end
    end
    @size += 1
  end
end

# Write an efficient algorithm that searches for a value in an m x n matrix.
# This matrix has the following properties:

# Integers in each row are sorted from left to right.
# The first integer of each row is greater than the last integer of the previous row.
#Example 1:

#Input:
matrix1 = [
  [1, 3, 5, 7],
  [10, 11, 16, 20],
  [23, 30, 34, 50]
]
#target = 3
#Output: true
#Example 2:

#Input:
matrix2 = [
  [1, 3, 5, 7],
  [10, 11, 16, 20],
  [23, 30, 34, 50]
]
#target = 13
#Output: false
def find_in_nested_matrix(matrix, target)
  matrix_length = matrix.length
  from = 0
  to = matrix_length - 1

  while from <= to
    mid = (from + to) / 2
    row = matrix[mid]
    row_min = row[0]
    row_max = row[-1]

    return true if row_min == target
    return true if row_max == target

    if row_min < target && target < row_max
      bsearch_result = row.bsearch do |x|
        target <=> x
      end
      return  bsearch_result ? true : false
    elsif target < row_min
      to = mid -1
    elsif target > row_max
      from = mid + 1
    end
  end

  false
end
p find_in_nested_matrix(matrix2, 55)

def bsearch_rec(arr, value, from = 0, to = nil)
  to = arr.length - 1 unless to

  return false if from > to

  mid = (from + to) / 2

  if value < arr[mid]
    return bsearch_rec(arr, value, from, mid - 1)
  elsif value > arr[mid]
    return bsearch_rec(arr, value, mid + 1, to)
  else
    return true
  end
end

def find_in_nested_matrix_recursion(matrix, value, from = 0, to = nil)
  to = matrix.length - 1 unless to

  return false if from > to

  mid = (from + to) / 2
  row = matrix[mid]
  row_min = row[0]
  row_max = row[-1]

  return true if row_min == value
  return true if row_max == value

  if value < row_min
    return find_in_nested_matrix_recursion(matrix, value, from, mid - 1)
  elsif value > row_max
    return find_in_nested_matrix_recursion(matrix, value, mid + 1, to)
  else
    bsearch_rec(row, value)
  end
end
p find_in_nested_matrix_recursion(matrix2, 50)

def to_binary(number)
  return number.to_s if number == 0 || number == 1
  to_binary(number / 2) + (number % 2).to_s
end

p to_binary(11)

def base10_to_base2(num)
  rtn = ''

  31.downto(0) do |i|
    v = ((1 << i) & num);
    # puts v
    rtn << (v != 0 ? '1' : '0')
  end

  rtn
end

p base10_to_base2(11)

def new_simple_bfs_shortest_path(graph, start_node, end_node)
  visited = {}
  queue = [[start_node]]

  while queue.any?
    path = queue.shift
    vertex = path[-1]
    visited[vertex] = 1

    graph[vertex].each do |node|
      next if visited[node]
      new_path = Array.new(path)
      new_path << node
      return array if node == end_node
      queue << array
    end
  end
end
p simple_bfs_shortest_path(graph_for_simple_dfs_and_bfs, 'A', 'F')

def new_bfs(graph, start_node)
  visited = {}
  queue = [start_node]

  while queue.any?
    vertex = queue.shift
    visited[vertex] = 1

    graph[vertex].each do |node|
      queue.push(node) unless visited[node]
    end
  end

  visited.map { |k, _v| k }
end

def new_dfs(graph, start_node)
  visited = {}
  stack = [start_node]

  while stack.any?
    vertex = stack.pop
    visited[vertex] = 1

    graph[vertex].each do |node|
      stack.push(node) unless visited[node]
    end
  end
end

def new_dfs_recursion(graph, start_node, visited = {})
  new_dfs_helper(graph, start_node, visited)
  visited.map { |k, v| k }
end

def new_dfs_helper(graph, vertex, visited)
  visited[vertex] = 1

  graph[vertex].each do |vertex|
    new_dfs_helper(graph, vertex, visited) unless visited[vertex]
  end
end

def new_merge_sort(array)
  return array if array.length == 1

  mid = array.length / 2 
  first_half = new_merge_sort(array[0..mid-1])
  second_half = new_merge_sort(array[mid..-1])

  if first_half.last < second_half.first
    first_half + second_half
  else
    merge(first_half, second_half)
  end
end

def merge(array1, array2)
  return array1 if array2.empty?
  return array2 if array1.empty?

  if array1[0] < array2[0]
    [array1[0]] + merge(array1[1..-1], array2)
  else
    [array2[0]] + merge(array1, array2[1..-1])
  end
end

def new_quicksort(array)
  new_quicksort_helper(array, 0, array.length - 1)
end

def new_quicksort_helper(array, first_idx, last_idx)
  return array unless first_idx < last_idx
  splitpoint = new_quicksort_partition(first_idx, last_idx)
  new_quicksort_helper(array, first_idx, splitpoint - 1)
  new_quicksort_helper(array, last_idx, splitpoint + 1)
end

def new_quicksort_partition(array, first_idx, last_idx)
  pivot_value = array[first_idx]
  left_mark = array[first_idx + 1]
  right_mark = array[last_idx]

  loop do
    while left_mark <= right_mark && array[left_mark] < pivot_value
      left_mark += 1
    end

    while left_mark <= right_mark && array[right_mark] > pivot_value
      right_mark -= 1
    end

    break if right_mark < left_mark
    array[left_mark], array[right_mark] = array[right_mark], array[left_mark]
  end

  array[first_idx], array[right_mark] = array[right_mark], array[first_idx]
  right_mark
end

def new_bubble_sort(array)
  (array.length - 1).downto(0) do|i|
    0.upto(i) do |j|
      if j + 1 < array.length && array[j] > array[j + 1]
        array[j], array[j + 1] = array[j + 1], array[j]
      end
    end
  end
  array
end
p new_bubble_sort([1,5,9,4,2,11])


def new_insertion_sort(array)
  0.upto(array.length - 1) do |i|
    j = i
    while j - 1 > 0 && array[j - 1] > array[j]
      array[j], array[j - 1] = array[j - 1], array[j]
      j -= 1
    end
  end

  array
end
p new_insertion_sort([1,5,9,4,2,11])

# def permutations(string, l, r)
#   if l == r
#     return string
#   else
#     (l).upto(r) do |i|
#       string[l], string[i] = string[i], string[l]
#       permutations(string, l + 1, r)
#       string[l], string[i] = string[i], string[l]
#     end
#   end
# end

# p permutations('abc', 0, 2)

# assuming no duplication
def permutations_with_recursion(string, concatenated = '', output = {})
  raise 'Invalid input, pls provide a string' unless string.is_a?(String)
  return [] if string.length == 0
  permutations_with_recursion_helper(string, concatenated, output)
  output.map { |k, _v| k }
end

def permutations_with_recursion_helper(string, concatenated, output)
  if string.length == 1
    if output[concatenated + string]
      output[concatenated + string] += 1
    else
      output[concatenated + string] = 1
    end
    return
  end

  string.each_char.with_index do |_c, i|
    new_concatenated = concatenated.clone
    new_concatenated << string[i]

    new_string = string.clone
    new_string = new_string.tap {|s| s.slice!(i) }

    permutations_with_recursion_helper(new_string, new_concatenated, output)
  end
end
p permutations_with_recursion('abc')

def string_compressor(str)
  new_str = ''
  current_char = str[0]
  length = 1

  str.each_char.with_index do |char, i|
    if str[i] == str[i + 1]
      length += 1
    else
      new_str << "#{char}#{length}"
      length = 1
      current_char = char
    end
  end

  new_str
end

p string_compressor('aabccccaaa')

def is_rotation(str1, str2)
  return false unless str1.length == str2.length

  start_index = nil

  concatenated_str1 = str1 + str1
  
  concatenated_str1.each_char.with_index do |char, i|
    if char == str2[0]
      str2.each_char.with_index do |ch, j|
        break unless str2[j] == str1[i + j]
      end
      return true
    end
  end

  false
end

p is_rotation('waterbottle', 'erbottlewat')
p is_rotation('waterbottle', 'erbottlewa')
