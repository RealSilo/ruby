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
end
