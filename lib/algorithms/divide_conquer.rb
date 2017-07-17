class DivideConquer
  # Once an enemy is divided in smaller problems, it’s easier to conquer.
  # You can crack problems using the same strategy, especially those with
  # optimal substructure. Problems with optimal substructure can be divided
  # into similar but smaller subproblems. They can be divided over and over
  # until subproblems become easy. Then subproblem solutions are combined
  # for obtaining the original problem’s solution.

  # Examples: binary search, mergesort (divide and conquer often uses recursion)

  # Problem 1
  # You have the daily prices of gold for a interval of time. You want
  # to find two days in this interval such that if you had bought then
  # sold gold at those dates, you’d have made the maximum possible profit.

  # O(N * log(N)) time complexity -> See dynamic.rb for O(N) solution.
  def trade(prices)
    return 0 if prices.length == 1

    mid = prices.length / 2

    former = prices[0..(mid - 1)]
    latter = prices[mid..-1]
    max_diff = latter.max - former.min

    [max_diff, trade(former), trade(latter)].max
  end
end
