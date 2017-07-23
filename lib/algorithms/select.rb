# Select the nth largest element

# Quick select is an in-place algorithm with 2N = > O(N) average (if the
# partition is always halfing the number of elements for next call) and
# 1/2 N^2 => O(N^2) worst (if the array is sorted and next call will include
# N-1 elements) complexity. Like with quick sort the worst time case occurs
# pretty rarely and we usually can achieve linear time.

class Quickselect
  def select(array, nth)
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
end

arr = [1,4,56,7,77,32,2,11,8,19,33,54,0]
p Quickselect.new.select(arr, 13)
