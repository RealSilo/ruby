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
        puts "N is #{n}; K is #{k}"
        if array[k] > array[k + 1]
          array[k], array[k + 1] = array[k + 1], array[k]
        end
        p array
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

  end

  def quick_sort(array)
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
end
