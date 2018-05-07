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
    # we split the array into 1 element long arrays
    return array if array.length <= 1

    mid = array.length / 2
    left = merge_sort(array[0..mid - 1])
    right = merge_sort(array[mid..-1])
    # once we have 1 element long arrays we start merging them
    if left.last <= right.first
      left + right
    else
      merge(left, right)
    end
  end

  def merge(left, right)
    # left and right are already sorted they just have to be merged
    return right if left.empty?
    return left if right.empty?

    if left.first < right.first
      [left.first] + merge(left[1..-1], right)
    else
      [right.first] + merge(left, right[1..-1])
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
    return array unless first < last
    # split_point is the moved random pivot value
    # after calling partition the smaller values are on the lef side
    # of the split_point and the larger ones on the right
    split_point = quick_partition(array, first, last)
    quick_sort_helper(array, first, split_point - 1)
    quick_sort_helper(array, split_point + 1, last)
  end

  def quick_partition(array, first, last)
    # rearranging the array and returning splitpoint
    # after rearranging the smaller values go the left side of the splitpoint
    # and the greater values go to the right

    # selecting pivot value, could be random
    pivot_value = array[first]
    left_mark = first + 1
    right_mark = last

    # looping and swappsing the elements until there are smaller values on the
    # left and larger values on the right compared to the pivot
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

    # changing the pivot with the right mark => left from the right mark the
    # vals are smaller; right from the value the vals are larger
    array[first], array[right_mark] = array[right_mark], array[first]

    # right mark returned as split point, new quick sort on both sides
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
  # For disk quicksort would have to seek and read every item it wants to compare.

  # Quicksort is fast when the data fits into memory and can be addressed directly.
  # Mergesort is faster when data won't fit into memory or when it's expensive to get
  # to an item.

  # Quicksort average case is 1.39 N log(N) which is 39% more compares than in case of
  # mergesort. Still quicksort is faster because it only moves the pointer and changes
  # the array values in-place while mergesort moves the data to new arrays.

  # Quicksort is not stable unlike mergesort.

  # Merge sort is often preferred for sorting a linked list. The slow random-access
  # performance of a linked list makes some other algorithms (such as quicksort)
  # perform poorly, and others (such as heapsort) completely impossible.

  # HEAP SORT
  # In-place sorting algorithm with N * log(N) worst case time complexity
  # Not really used because:
  #  - inner loop is longer than quicksort's (more things to do)
  #  - poor usage of cache memory (one huge array)
  #  - not stable (stable sort preserves the relative order of items with equal keys)

  # Things to consider when choosing sorting algorithm:
  # - stability!!! is important?
  # - are there duplicate keys?
  # - randomly ordered array?
  # - large or small items?
  # - memory!!! consumption?
  # - does it have to be parallel?
  # - guaranteed performance is required?

  # Counting sort: buckets hold only a single value
  # Bucket sort: buckets hold a range of values
  # Radix sort: buckets hold values based on digits within their values

  # COUNTING SORT
  # Time-complexity: O(n+k), Auxiliary-space:O(n+k), Not In-place, Not stable
  # n is number of elements and k is the range of input
  # Counting sort is efficient if the range of input data is not significantly greater
  # than the number of objects to be sorted.
  # It is often used as a sub-routine to another sorting algorithm like radix sort.

  def counting_sort(arr, min, max)
    output = Array.new(arr.length) { 0 }

    count = Array.new(max - min + 1) { 0 }

    arr.each { |element| count[element] += 1 }

    count.each_with_index { |_element, i| count[i] += count[i - 1] }

    arr.each do |element|
      output[count[element] - 1] = element
      count[element] -= 1
    end

    output
  end

  p new.counting_sort([1, 4, 1, 2, 7, 5, 2], 0, 9)

  # RADIX SORT

  # What if the elements are in range from 1 to n^2? We can’t use counting sort because
  # counting sort will take O(n^2) which is worse than comparison based sorting algorithms.
  # Can we sort such an array in linear time? Radix Sort is the answer. The idea of Radix
  # Sort is to do digit by digit sort starting from least significant digit to most
  # significant digit. Radix sort uses counting sort as a subroutine to sort.
  def radix_counting_sort(arr, exp)
    output = Array.new(arr.length) { 0 }
    count = Array.new(10) { 0 }

    arr.each do |element|
      idx = element / exp
      count[idx % 10] += 1
    end

    count.each_with_index { |_element, j| count[j] += count[j - 1] }

    (arr.length - 1).downto(0) do |k|
      idx = arr[k] / exp
      output[count[idx % 10] - 1] = arr[k]
      count[idx % 10] -= 1
    end

    arr.length.times { |i| arr[i] = output[i] }
  end

  def radix_sort(arr)
    max = arr.max
    exp = 1

    while max / exp > 0
      Sort.new.radix_counting_sort(arr, exp)
      exp *= 10
    end

    arr
  end

  p new.radix_sort([170, 45, 75, 90, 802, 24, 2, 66])

  # BUCKET SORT
  # We must know in advance that the integers are fairly well distributed over
  # an interval (i, j). Then we can divide this interval in N equal sub-intervals
  # (or buckets). We’ll put each number in its corresponding bucket. Finally for every
  # bucket that contains more than one number we’ll use some linear sorting algorithm.

  # The complexity of bucket sort isn’t constant depending on the input. However in
  # the average case the complexity of the algorithm is O(n + k) where n is the length
  # of the input sequence, while k is the number of buckets.

  # The problem is that its worst-case performance is O(n^2)
  # The main thing we should be aware of is the way the input data is dispersed over
  # an interval.
  def bucket_sort(arr, min, max, size)
    bucket_count = ((max - min) / size) + 1
    buckets = Array.new(bucket_count) { [] }

    arr.each do |element|
      bucket_index = (element - min) / size
      buckets[bucket_index] << element
    end

    output = []

    buckets.each do |bucket|
      bucket.sort!
      bucket.each do |value|
        output << value
      end
    end

    output
  end

  p new.bucket_sort([3, 13, 4, 20, 3, 24, 1], 0, 29, 10)
end

# Implement a document scanning function word_count_engine, which receives a string
# document and returns a list of all unique words in it and their number of occurrences,
# sorted by the number of occurrences in a descending order. Assume that all letters are
# in English alphabet.

# input:  document = "Practice makes perfect. you'll only get Perfect by practice. just practice!"

# output: [["practice", "3"], ["perfect", "2"], ["makes", "1"], ["get", "1"], ["by", "1"],
# ["just", "1"], ["youll", "1"], ["only", "1"]]

# The trick here is that we know the max value so we can use bucket sort.
def word_count_engine(document)
  document = document.gsub(/[^ 0-9A-Za-z]/, '').downcase.split(' ')

  store = {}
  max = 0

  document.each do |element|
    if store[element]
      store[element] += 1
      max = [store[element], max].max
    else
      store[element] = 1
      max = 1 if max == 0
    end
  end

  buckets = Array.new(max) { [] }

  store.each do |key, value|
    buckets[max - value].push([key, value.to_s])
  end

  buckets.flatten(1)
end

p word_count_engine("Practice makes perfect. you'll only get Perfect by practice. just practice!")
