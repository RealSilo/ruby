class Dynamic
  # PROBLEM 1: The knapsack problem:
  # You wanna take a few item (value, weight) You can carry 4lbs.
  # What items should you put ing the bag o maximize the value?

  # Stereo $3000 3lbs
  # Laptop $2000 2lbs
  # Guitar $1500 1lbs
  # Your limit is 4lbs -> Correct solution guitar + laptop = $3500

  # This also could be solved with a greedy solution which doesn't give
  # you the right answer but it's pretty close to it. Greedy solution would
  # be to take the most expensive item that fits your bag then take the next
  # most expensive one...

  # PROBLEM 2
  # Count the number of ways you can get the amount with the given coins.
  # def possible_set_of_coins_for_sum(amount, coins)
  #   arr = [1] + [0] * amount

  #   # Number of ways you can get amount is the sum of numbers you can get
  #   # (amount - coin)
  #   # In case of 'A', 'B', 'C'
  #   # ways[i] => ways[i - 'A'] + ways[i - 'B'] + ways[i - 'C']

  #   # basic solution would be to find all the sets of coin combinations (2^N)
  #   # where N is the number of amount

  #   # O(k * n) time complexity where k is coin number and n is the amount
  #   coins.each do |coin|
  #     for i in (coin..amount + 1)
  #       arr[i] += arr[i - coin]
  #     end
  #   end

  #   arr[amount]
  # end

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
          elsif i == 0 &&  j > 0  #First ith element
             num[i][j] = [0,  num[i][j - 1]].max
          elsif j == 0 && i > 0  #First jth element
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

  # PROBLEM3: Common longest substring
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
end

puts Dynamic.new.common_longest_subsequence('houseboat', 'computer')
puts Dynamic.new.common_longest_substring('houseboat', 'coumputer')
