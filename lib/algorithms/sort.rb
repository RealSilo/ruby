class Sort
  # time comp -> best: O(N), avg: O(N2), worst: O(N2); space: O(1)
  def bubble_sort(array)
    n = array.length

    loop do
      swapped = false

      (n - 1).times do |i|
        if array[i] > array[i + 1]
          array[i], array[i + 1] = array[i + 1], array[i]
          swapped = true
        end
      end

      break unless swapped
    end

    array
  end

  def bubble_sort_2(array)
    (array.length - 1).downto(1) do |n|
      n.times do |k|
        if array[k] > array[k + 1]
          array[k], array[k + 1] = array[k + 1], array[k]
        end
      end
    end

    array
  end

  # merge sort is a divine and conquer algorithm that uses recursion
  # the base case is if the list is empty or has one item
  # if the list has more than one item we split the list and recursively
  # invoke a merge sort on both halves
  # Once the 2 halves are sorted the merge is performed. Merging is the process
  # of taking two smaller sorted lists and combining them together into a
  # single, sorted, new list.
  def merge_sort(array)
    return array if array.length <= 1

    mid = array.length / 2
    left = merge_sort(array[0..mid - 1])
    right = merge_sort(array[mid..-1])
    merge(left, right)
  end

  def merge(left, right)
    return right if left.empty?
    return left if right.empty?

    if left.first < right.first
      [left.first] + merge(left[1..left.length], right)
    else
      [right.first] + merge(left, right[1..right.length])
    end
  end

  # quick sort is a divide and conquer algorithm like merge sort without
  # using additional space
  def quick_sort(array)
    return [] if array.empty?

    pivot = array.delete_at(0)
    # partition -> [2, 9, 7, 1, 4, 8] with pivot 6 -> [[2, 1, 4], [9, 7, 8]]
    left_array, right_array = array.partition { |element| pivot > element }

    quick_sort(left_array) + [pivot] + quick_sort(right_array)
  end

  def quick_sort_2(array)
    quick_sort_helper(array, 0, array.length - 1)
  end

  def quick_sort_helper(array, first, last)
    if first < last
      # split_point is the moved random pivot value
      # after calling partition the smaller values are on the lef side
      # of the split_point and the larger ones on the right
      split_point = quick_partition(array, first, last)
      quick_sort_helper(array, first, split_point - 1)
      quick_sort_helper(array, split_point + 1, last)
    end
    array
  end

  def quick_partition(array, first, last)
    # rearranging the array and returning splitpoint
    # after rearranging the smaller values go the left side of the splitpoint
    # and the greater values go to the right

    # selecting pivot value, could be random
    pivot_value = array[first]

    left_mark = first + 1
    right_mark = last

    done = false

    loop do
      while left_mark <= right_mark && array[left_mark] <= pivot_value
        left_mark += 1
      end

      while left_mark <= right_mark && array[right_mark] >= pivot_value
        right_mark -= 1
      end

      if right_mark < left_mark
        done = true
      else
        array[left_mark], array[right_mark] = array[right_mark], array[left_mark]
      end

      break if done
    end

    array[first], array[right_mark] = array[right_mark], array[first]

    right_mark
  end

  # QUICK SORT VS MERGE SORT

  # Even though quicksort has O(n^2) in worst case, it can be easily avoided
  # with high probability by choosing the right pivot.

  # If Quick sort is implemented well, it will be around 2-3 times faster than
  # merge sort and heap sort. This is mainly because that the operations in
  # the innermost loop  are simpler.

  # Quick sort is in place. You need very little extra memory.
  # Which is extremely important.

  # Quick sort is typically faster than merge sort when the data is stored
  # in memory. However, when the data set is huge and is stored on external
  # devices such as a hard drive, merge sort is the clear winner in terms of speed.
  # It minimizes the expensive reads of the external drive.

  # Quicksort is fast when the data fits into memory and can be addressed directly.
  # Mergesort is faster when data won't fit into memory or when it's expensive to get
  # to an item.
end
