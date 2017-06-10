# provides powerful alternative when loops are not ideal
# a base case always has to be found
# O(n) space complexity

class Recursion
  # PROBLEM 1: Write the factorial function recursively
  # 4 -> 4 * 3 * 2 * 1 = 24
  def factorial(n)
    return 1 if n == 1

    n * factorial(n - 1)
  end

  # PROBLEM 2: Write a recursive function which takes an integer and computes
  # the cumulative sum of 0 to that integer
  # 4 -> 4 + 3 + 2 + 1 + 0 = 10
  def cumulative_sum(n)
    return 0 if n == 0

    n + cumulative_sum(n - 1)
  end

  # PROBLEM 3: Given an integer, create a recursive function that returns the  sum
  # of all individual digits in that integer.
  # 4321 - > 4 + 3 + 2 + 1 = 10
  def sum_digits(n)
    return n if n.to_s.length == 1

    digits = n.to_s.chars.map(&:to_i)

    digits[0] + sum_digits(digits[1..-1].join('').to_i)
  end

  def sum_digits_with_modulo(n)
    return n if n.to_s.length == 1

    n%10 + sum_digits_with_modulo(n/10)
  end

  # PROBLEM 4: Create a function which takes a string (phrase) and a list of strings (words).
  # Check if the phrase can made from any combination of the words.
  # themanran, ['the', 'ran', 'man', 'what'] -> true

  def phrase_split(phrase, words)
    words.each_with_index do |word, i|
      next unless phrase.include?(word)
      phrase.slice!(word)
      words.delete_at(i)
      phrase_split(phrase, words) unless phrase.empty?
    end

    return true if phrase.empty?
    false
  end

  # PROBLEM 5: Reverse a string using recursion
  # With 'abcde' as arg would return 'edcba'
  def recursive_reverse(string)
    return string if string.length == 1

    string[-1] + recursive_reverse(string[0..-2])
  end

  # PROBLEM 5: Given a string write a  recursive function that returns all
  # the permutations of that string
  # With 'abc' as arg would return ['abc', 'acb', 'bac', 'bca', 'cab', 'cba']
  # Duplicates are fine => 'xxx' would return [ 'xxx' * 6]
  # def string_permutation(string)
  #   output = []

  #   if string.length == 1
  #     output = [string]
  #   else
  #     string.each_char.with_index do |st, index|
  #       for perm in string_permutation((string[0..index] + string[(index + 1)..-1])) do
  #         debugger
  #         output += [st + perm]
  #       end
  #     end
  #   end
  #   output
  # end

  # PROBLEM 6: Implement Fibonacci sequence with and without memoization

  def fibonacci(n)
    return n if n == 0
    return n if n == 1

    fibonacci(n - 1) + fibonacci(n - 2)
  end

  def fibonacci_with_memo(n, memo = {})
    return n if n == 0
    return n if n == 1

    memo[n] ||=  fibonacci_with_memo(n - 1, memo) + fibonacci_with_memo(n - 2, memo)
  end

  @@memo = {}
  def fibonacci_with_memo_detailed(n)
    return n if n == 0
    return n if n == 1

    return @@memo[n] if @@memo[n]

    @@memo[n] = fibonacci_with_memo(n - 1) + fibonacci_with_memo(n - 2)
    @@memo[n]
  end

  def fibonacci_iteratively(n)
    array = [0, 1]
    i = 2

    until i == n + 1
      array[i] = array[i - 1] + array[i - 2]
      i += 1
    end

    array[-1]
  end

  def fibonacci_iteratively_2(n)
    a = 0
    b = 1

    n.times do
      a, b = b, a + b
    end

    a
  end

  # PROBLEM 7: Given a target amount n and a list of array of distinct coin
  # values [1,2,5,10], what is the fewest coins needed to make the change amount
  # For 10 -> 1 (1 10cents), 8 -> 3 1penny
  # This is a pretty inefficient in time/space
  def min_coin_number(target, coins)
    min_coins = target

    return 1 if coins.include?(target)

    # for every coin value that less than my target value
    coins.each do |c|
      skip if c <= target
      # add a coin count + recursive
      num_coins = 1 + min_coin_number(target - c, coins)
      # reset minimum if new min coins is less than current
      if num_coins < min_coins
        min_coins = num_coins
      end
    end

    min_coins
  end
end