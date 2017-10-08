# Select the nth largest element

# Quick select is an in-place algorithm with 2N = > O(N) best (if the
# partition is always halfing the number of elements for next call) and
# 1/2 N^2 => O(N^2) worst (if the array is sorted and next call will include
# N-1 elements) complexity. Like with quick sort the worst time case occurs
# pretty rarely and we usually can achieve linear time ((2 + 2 log 2)N).

class Select
  def quickselect_nth(array, nth)
    partition(array, nth - 1, 0, array.length - 1)
  end

  def partition(array, nth, first, last)
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

    if right_mark > nth
      partition(array, nth, first, right_mark - 1)
    elsif nth > right_mark
      partition(array, nth, right_mark + 1, last)
    elsif nth == right_mark
      array[nth]
    end
  end

  arr = [1, 4, 56, 7, 77, 32, 2, 11, 8, 19, 33, 54, 0]
  # p new.quickselect_nth(arr, 13)

  # If one instead consistently chooses "good" pivots, this is avoided and one always
  # gets linear performance even in the worst case. A "good" pivot is one for which we
  # can establish that a constant proportion of elements fall both below and above it,
  # as then the search set decreases at least by a constant proportion at each step,
  # hence exponentially quickly, and the overall time remains linear. The median is a
  # good pivot – the best for sorting, and the best overall choice for selection –
  # decreasing the search set by half at each step. Thus if one can compute the median
  # in linear time, this only adds linear time to each step, and thus the overall
  # complexity of the algorithm remains linear.

  # Median of medians has a best and worst-case O(n) complexity for selecting the kth
  # order statistic (kth smallest number) in an unsorted array with length n.
  # Median of medians can also be used as a pivot strategy in quicksort
  def median_kth(arr, kth = 10, base = 5)
    return arr.sort[(arr.length - 1) / 2] if arr.length <= base

    medians = []
    left = []
    right = []

    arr.each_slice(base) do |base_arr|
      medians << base_arr.sort[(base_arr.length - 1) / 2]
    end

    # median number is found
    m = median_kth(medians, medians.length / 2)

    arr.each do |n|
      if n < m
        left << n
      elsif n > m
        right << n
      end
    end

    m_pos = left.length + 1

    if kth == m_pos
      m
    elsif kth < m_pos
      median_kth(left, kth)
    else
      median_kth(right, kth - m_pos)
    end
  end

  med_arr = [2, 88, 33, 17, 37, 19, 77, 53, 99, 7, 10, 48]
  p new.median_kth(med_arr, 8)

  def quickselect_nth_with_median(array, nth)
    partition(array, nth - 1, 0, array.length - 1)
  end

  def partition_with_median(array, nth, first, last)
    pivot_value = median_kth(array, nth)
    pivot_index = nil
    array.each_with_index { |e,i| pivot_index = i if pivot_value == e }
    array[pivot_index], array[0] = array[0], array[pivot_index]
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

    if right_mark > nth
      partition_with_median(array, nth, first, right_mark - 1)
    elsif nth > right_mark
      partition_with_median(array, nth, right_mark + 1, last)
    elsif nth == right_mark
      array[nth]
    end
  end

  arr = [1, 4, 56, 7, 77, 32, 2, 11, 8, 19, 33, 54, 0]
  p new.quickselect_nth_with_median(arr, 12)
end
