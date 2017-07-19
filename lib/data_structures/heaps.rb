require 'byebug'

class BinaryHeap
  # like binary search tree except:
  # 1.
  # if min heap:
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

  def initialize
    @heap_list = [0]
    @current_size = 0
  end

  def insert(k)
    @heap_list.push(k)
    @heap_list.current_size += 1
    perc_up(current_size)
  end

  def perc_up(i)
    while i / 2 > 0
      if @heap_list[i] < @heap_list[i / 2]
        @heap_list[i], @heap_list[i / 2] = @heap_list[i / 2], @heap_list
      end
      i /= 2
    end
  end

  # ......
end

class MinHeap
  attr_accessor :heap

  def initialize
    @heap = [nil]
  end

  def add(value)
    heap.push(value)

    idx = heap.length - 1

    return if heap.length < 3

    while idx > 1 && heap[idx] < heap[idx / 2]
      heap[idx], heap[idx / 2] = heap[idx / 2], heap[idx]

      idx = idx / 2
    end
  end

  def remove
    smallest = heap[1]

    if heap.length > 2
      heap[1] = heap.pop

      if heap.length == 3
        heap[1], heap[2] = heap[2], heap[1] if heap[1] > heap[2]
        return smallest
      end

      return smallest if heap.length == 2

      i = 1
      left = 2 * i
      right = 2 * i + 1

      while heap[i] > heap[left] || heap[i] > heap[right]
        if heap[left] < heap[right]
          heap[i], heap[left] = heap[left], heap[i]
          i = 2 * i
        else
          heap[i], heap[right] = heap[right], heap[i]
          i = 2 * i + 1
        end

        left = 2 * i
        right = 2 * i + 1

        break if heap[left].nil? || heap[right].nil?
      end

    elsif heap.length == 2
      return heap.pop
    else
      return nil
    end
    smallest
  end

  def heap_sort
    result = []

    while heap.length > 1
      result << remove
    end

    result
  end
end

min_heap = MinHeap.new
min_heap.add(20)
min_heap.add(30)
min_heap.add(25)
min_heap.add(40)
min_heap.add(10)
p min_heap.heap
min_heap.remove
p min_heap.heap
min_heap.remove
p min_heap.heap
min_heap.remove
p min_heap.heap
min_heap.remove
p min_heap.heap
min_heap.remove
p min_heap.heap

min_heap.add(20)
min_heap.add(30)
min_heap.add(25)
min_heap.add(40)
min_heap.add(10)

p min_heap.heap_sort

