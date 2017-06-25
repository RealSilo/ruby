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

  # PROBLEM 3
end
