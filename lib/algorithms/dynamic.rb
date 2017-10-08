require 'byebug'
class Dynamic
  # Dynamic programming is a method for solving a complex problem by breaking it
  # down into a collection of simpler subproblems, solving each of those
  # subproblems just once, and storing their solutions.

  # Dynamic programming is mostly just a matter of taking a recursive algorithm
  # and  finding the overlapping subproblems (that is, the repeated calls). You
  # then cache those results for future recursive calls. Alternatively, you can
  # study the pattern of the recursive calls and implement something iterative.
  # You still have to cache the previous steps.

  # Dynamic programming is useful when you’re trying to optimize something given
  # a constraint. In the knapsack problem, you have to maximize the value of the
  # goods you stole, constrained by the size of the knapsack.
  # You can use dynamic programming when the problem can be broken into discrete
  # subproblems, and they don’t depend on each other.

  # PROBLEM 1: Suppose you’re a greedy thief. You’re in a store with a knapsack,
  # and there are all these items you can steal. But you can only take what you
  # can fit in your knapsack. How can you maximize the value stolen?

  # This also could be solved with a greedy solution which doesn't give
  # you the right answer but it's pretty close to it. Greedy solution would
  # be to take the most expensive item that fits your bag then take the next
  # most expensive one...

  # The brute force solution would take O(2^N) steps as you have to find all
  # the subsets of the set.

  # O(MN) where M is the number of items and N is space/step.
  def knapsack(items, space, step)
    grid = Array.new(items.size) { Array.new(space / step, 0) }
    # stolen_items = []

    items.each_with_index do |(_name, value), i|
      (step..space).step(step).with_index do |size, j|
        if i == 0 && j >= 0
          grid[i][j] = value[:price] if value[:space] <= size
        elsif j == 0 && i > 0
          current_value = value[:space] <= size ? value[:price] : 0
          grid[i][j] = [grid[i - 1][j], current_value].max
        else
          if size >= value[:space]
            prev_max = grid[i - 1][j]
            remaining_space = size - value[:space]
            remaining_space_index = [0, remaining_space / step - 1].max
            remaining_space_value = grid[i - 1][remaining_space_index]
            current_value = value[:price] + remaining_space_value
            grid[i][j] = [prev_max, current_value].max
          else
            grid[i][j] = grid[i - 1][j]
          end
        end
      end
    end

    grid
  end

  items = {
    'porcelain': { price: 3000, space: 3 },
    'guitar': { price: 2500, space: 2 },
    'necklace': { price: 2000, space: 0.5 },
    'laptop': { price: 1500, space: 1 },
    'tv': { price: 1000, space: 2.5 },
    'phone': { price: 800, space: 0.5 }
  }

  # p Dynamic.new.knapsack(items, 4, 0.5)

  # PROBLEM 2
  # Count the number of ways you can get the amount with the given coins.

  # Basic solution would be to find all the sets of coin combinations (2^N)
  # With dynamic programming we can solve it with O(KN) time complexity where K
  # is coin number and N is the amount.
  def possible_set_of_coins_for_sum(amount, coins)
    # We need one at the arr[0] spot since if the coin is 5 and the amount too
    # then we have a solution.
    arr = [1] + [0] * amount

    # Number of ways you can get amount is the sum of numbers you can get
    # (amount - coin)
    # In case of 'A', 'B', 'C'
    # ways[i] => ways[i - 'A'] + ways[i - 'B'] + ways[i - 'C']
    coins.each do |coin|
      for i in (coin..amount)
        arr[i] += arr[i - coin]
        # p [arr, coin, i]
      end
    end

    return 0 if amount == 0
    arr[amount]
  end

  puts Dynamic.new.possible_set_of_coins_for_sum(5, [1, 2, 5])
  # puts Dynamic.new.possible_set_of_coins_for_sum(4, [1, 2, 3])

  # PROBLEM3: Common longest subsequence
  # 'abcdegfgh' and 'aqcezfg' => 'acefg'

  def common_longest_subsequence(s1, s2)
    return 0 if s1.empty? || s2.empty?

    num = Array.new(s1.size) { Array.new(s2.size) }

    chars  = []

    s1.each_char.with_index do |letter1, i|
      s2.each_char.with_index do |letter2, j|
        if letter1 == letter2
          if i == 0 || j == 0
            num[i][j] = 1
          else
            num[i][j] = 1 + num[i - 1][j - 1]
            chars << [letter1, i, j] unless chars.any? { |char| char[1] > i || char[2] > j }
          end
        else
          if i == 0 && j == 0
            num[i][j] = 0
          elsif i == 0 &&  j > 0  # First ith element
            num[i][j] = [0,  num[i][j - 1]].max
          elsif j == 0 && i > 0  # First jth element
            num[i][j] = [0, num[i - 1][j]].max
          else
            num[i][j] = [num[i - 1][j], num[i][j - 1]].max
          end
        end
      end
    end

    p num[s1.length - 1][s2.length - 1]
    chars.map(&:first).join
  end

  # PROBLEM4: Common longest substring
  # 'abcdegfgh' and 'aqcezfg' => 'fg'
  # O(MN) time and O(MN) complexity
  # Only the previous column of the grid storing the dynamic state is ever
  # actually used in computing the next column. Thus, these algorithm can be
  # altered to have only an O(N) storage requirement. By reassigning array
  # references between two 1D arrays, this can be done without copying the state
  # data from one array to another.
  # Suffix trees (not trie) can be used to achieve a O(N+M) run time at the cost
  # of extra storage and algorithmic complexity.
  def common_longest_substring(str1, str2)
    return '' if str1.empty? || str2.empty?

    array = Array.new(str1.length) { Array.new(str2.length) { 0 } }
    intersection_length = 0
    intersection_end    = 0

    str1.length.times do |x|
      str2.length.times do |y|
        # Go to next if letters are not the same
        next unless str1[x] == str2[y]
        if x == 0 && y == 0
          array[x][y] = 1
        else
          # If letters are the same add 1 to the previous letter's number
          array[x][y] = 1 + array[x - 1][y - 1]
        end
        # Go to next if length not greater than max
        next unless array[x][y] > intersection_length
        intersection_length = array[x][y]
        intersection_end = x
      end
    end
    intersection_start = intersection_end - intersection_length + 1

    str1.slice(intersection_start..intersection_end)
  end

  # puts new.common_longest_subsequence('houseboat', 'computer')
  # puts new.common_longest_substring('houseboat', 'coumputer')

  # PROBLEM5: Calculate the Levenshtein-distance of two strings with dynamic
  # programming.
  def levenshtein_distance(string1, string2)
    return string1 if string2.empty?
    return string2 if string1.empty?

    a = string1.downcase
    b = string2.downcase

    matrix = Array.new(a.length + 1) { Array.new(b.length + 1) { 0 } }

    (0..b.length).each { |i| matrix[0][i] = i }
    (1..a.length).each { |i| matrix[i][0] = i }

    (1..a.length).each do |i|
      (1..b.length).each do |j|
        subcost = a[i-1] == b[j-1] ? 0 : 1 # if the same substit. not needed
        matrix[i][j] = [
          matrix[i-1][j] + 1, # insertion
          matrix[i][j-1] + 1, # deletion
          matrix[i-1][j-1] + subcost # substitution
        ].min
      end
    end

    matrix.last.last
  end

  # p new.levenshtein_distance('greatest', 'grandest')
  # p new.levenshtein_distance('kitten', 'wkitten')

  # Start from the top-left corner of a grid and find a path to the bottom-right
  # corner if exists. Some cells can be blocked (0 is free cell, 1 is blocked).
  # Only can move to the right and down.
  def right_down_grid_path(arr)
    return nil if arr.nil? || arr.empty? || arr.first.empty?
    
    path = []
    return path if get_path(arr, arr.length - 1, arr.first.length - 1, path)

    nil
  end

  def get_path(arr, row, col, path, failed_points = {})
    return false if col < 0 || row < 0 || !arr[row][col] || arr[row][col] == 1

    return false if failed_points["#{row}#{col}"]

    start_point = (col == 0 && row == 0)

    if start_point ||
       get_path(arr, row - 1, col, path, failed_points) ||
       get_path(arr, row, col - 1, path, failed_points)
      path << [row, col]
      return true
    end

    failed_points["#{row}#{col}"]
    false
  end

  p new.right_down_grid_path([[0, 0, 0], [1, 1, 0], [0, 0, 0]])
  p new.right_down_grid_path([[0, 1, 0, 0], [0, 0, 1, 0], [1, 0, 0, 1], [1, 1, 0, 0]])
end
