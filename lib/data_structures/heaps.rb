require 'byebug'
# like binary search tree except:
# 1.
# if min store:
# values of child nodes must be greater than parent node's value
# if max hep:
# values of child nodes must be smaller than parent node's value
# 2.
# all levels of the tree, except possibly the last one (deepest) are FULLY FILLED,
# and, if the last level of the tree is not complete, the nodes of that level
# are filled from left to right

# in order to guarantee log performance we must keep our tree balanced
# a balanced binary tree has roughly the same number of nodes in the
# left and the right subtrees of the root. (in definition -> fully filled, so this
# is not a problem here)
class MinHeap
  attr_accessor :store

  def initialize
    @store = [nil]
  end

  def add(value)
    store.push(value)

    idx = store.length - 1

    return if store.length < 3

    while idx > 1 && store[idx] < store[idx / 2]
      store[idx], store[idx / 2] = store[idx / 2], store[idx]

      idx /= 2
    end
  end

  def remove
    smallest = store[1]

    if store.length > 2
      store[1] = store.pop

      if store.length == 3
        store[1], store[2] = store[2], store[1] if store[1] > store[2]
        return smallest
      end

      return smallest if store.length == 2

      i = 1
      left = 2 * i
      right = 2 * i + 1

      while store[i] > store[left] || store[i] > store[right]
        if store[left] < store[right]
          store[i], store[left] = store[left], store[i]
          i = 2 * i
        else
          store[i], store[right] = store[right], store[i]
          i = 2 * i + 1
        end

        left = 2 * i
        right = 2 * i + 1

        break if store[left].nil? || store[right].nil?
      end

    elsif store.length == 2
      return store.pop
    else
      return nil
    end
    smallest
  end

  def heap_sort
    result = []

    result << remove while store.length > 1

    result
  end
end

min_store = MinHeap.new
min_store.add(20)
min_store.add(30)
min_store.add(25)
min_store.add(40)
min_store.add(10)
p min_store.store
min_store.remove
p min_store.store
min_store.remove
p min_store.store
min_store.remove
p min_store.store
min_store.remove
p min_store.store
min_store.remove
p min_store.store

min_store.add(20)
min_store.add(30)
min_store.add(25)
min_store.add(40)
min_store.add(10)

# p min_store.heap_sort

class MaxHeap
  attr_reader :store

  def initialize
    @store = [nil]
  end

  def add(element)
    store << element

    return if store.length < 3

    idx = store.length - 1

    while idx > 1 && store[idx] > store[idx / 2]
      store[idx], store[idx / 2] = store[idx / 2], store[idx]
      idx /= 2
    end
  end

  def remove
    largest = store[1]

    if store.length > 2
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
    elsif store.length == 2
      return store.pop
    else
      return nil
    end

    largest
  end
end

max_store = MaxHeap.new
max_store.add(20)
max_store.add(30)
max_store.add(25)
max_store.add(40)
max_store.add(10)
p max_store.store
max_store.remove
p max_store.store
max_store.remove
p max_store.store
max_store.remove
p max_store.store
max_store.remove
p max_store.store
max_store.remove
p max_store.store

max_store.add(20)
max_store.add(30)
max_store.add(25)
max_store.add(40)
max_store.add(10)

# PROBLEM1: Find the RUNNING median for an unsorted list.

def calc_median(array)
  min_store = MinHeap.new
  max_store = MaxHeap.new
  medians = []

  array.each_with_index do |element, i|
    i.even? ? max_store.add(element) : min_store.add(element)
    
    if i == 0
      medians << max_store.store[1].to_f
      next
    end

    if max_store.store[1] > min_store.store[1]
      temp1 = max_store.remove
      temp2 = min_store.remove

      max_store.add(temp2)
      min_store.add(temp1)
    end

    if i.even? 
      medians << max_store.store[1].to_f
    else
      sum = max_store.store[1].to_f + min_store.store[1].to_f
      medians << sum / 2
    end
  end

  medians
end

puts calc_median([2,6,4,10,8,11,13,15,17,33,44,55])
