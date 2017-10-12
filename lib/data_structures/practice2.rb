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

class LinkNode
  attr_reader :key, :value

  def initialize(key, value, next_node = nil)
    @key = key
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  attr_reader :head

  def initialize(value)
    @head = LinkNode.new(key, value)
  end
end

class HashMap
  attr_reader :storage, :storage_limit

  def initialize(storage_limit = 10)
    @storage = Array.new(storage_limit)
    @storage_limit = storage_limit
  end

  def hash(key)
    hash_value = 0

    key.each_char { |char| hash_value += char.ord }

    hash_value % storage_limit
  end

  def add(key, val)
    i = hash(key)

    if storage[i]
      current = storage[i].head

      while current.next_node
        if current.key == key
          current.value = value
          return current.value
        end

        current = current.next_node
      end

      if current.key == key
        current.value = value
        return current.value
      end

      current.next_node = LinkNode.new(key, value)
      return current.next_node.value
    else
      storage[i] = LinkedList.new(key, value)
      storage[i].head
    end
  end

  def find(key)
    i = hash(key)

    return nil unless storage[i]

    current = storage[i].head

    while current
      return current.value if current.key == key
        
      current = current.next_node
    end

    nil
  end

  def remove(key)
    i = hash(key)

    return nil unless storage[index]

    current = storage[i].head

    if current.key == key
      if current.next_node
        storage[i].head = current.next_node
        return current.data
      else
      end
    else
    end
  end
end

p HashMap.new.hash('aa')