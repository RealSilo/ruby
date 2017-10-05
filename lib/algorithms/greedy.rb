require 'byebug'
class Greedy
  # PROBLEM1: You want to hold as many classes as possible in the classroom. How
  # do you pick what set of classes to hold, so that you get the biggest set of
  # classes possible?

  # A greedy algorithm is simple: at each step, pick the optimal move. In this
  # case, each time you pick a class, you pick the class that ends the soonest.
  # In technical terms: at each step you pick the locally optimal solution, and
  # in the end you have the globally optimal solution. This simple algorithm
  # finds the optimal solution to this scheduling problem!

  # If class not sorted it could be O(N2), but for now we have it sorted so it
  # is O(N)
  def schedule_classroom(classes)
    picked_classes = []

    classes.each do |object|
      if picked_classes.empty?
        picked_classes.push(object)
        next
      end

      if picked_classes.last[:end_time] <= object[:start_time]
        picked_classes.push(object)
      end
    end

    picked_classes
  end

  classes = [
    { name: 'english', start_time: 900, end_time: 1100 },
    { name: 'biology', start_time: 1000, end_time: 1200 },
    { name: 'math', start_time: 1100, end_time: 1300 },
    { name: 'cs', start_time: 1200, end_time: 1400 },
    { name: 'music', start_time: 1300, end_time: 1500 }
  ]

  p Greedy.new.schedule_classroom(classes)

  # PROBLEM2: Suppose you’re a greedy thief. You’re in a store with a knapsack,
  # and there are all these items you can steal. But you can only take what you
  # can fit in your knapsack. How can you maximize the value stolen?

  # Clearly, the greedy strategy doesn’t give you the optimal solution here. But
  # it gets you pretty close. With the algoritm and the data below you would
  # steal the porcelain, the necklace and the phone, instead of the guitar, the
  # necklace, the laptop, and the phone.
  # To find the correct solution see dynamic solutions.

  def knapsack(items, space)
    stolen_items = []
    remaining_space = space

    items.each do |item|
      if remaining_space - item[:space] > 0
        stolen_items << item
        remaining_space -= item[:space]
      end
    end

    stolen_items
  end

  items = [
    { name: 'porcelain', value: 3000, space: 3 },
    { name: 'guitar', value: 2500, space: 2 },
    { name: 'necklace', value: 2000, space: 0.5 },
    { name: 'laptop', value: 1500, space: 1 },
    { name: 'tv', value: 1000, space: 2.5 },
    { name: 'phone', value: 800, space: 0.5 }
  ]

  p Greedy.new.knapsack(items, 4)

  def knapsack2(items, space)
    stolen_items = []
    remaining_space = space

    while items.any?
      max_value_item = nil

      items.each do |name, values|
        unless max_value_item
          max_value_item = name
          next
        end

        max_value_item = name if values[:value] > items[max_value_item][:value]
      end

      if remaining_space - items[max_value_item][:space] > 0
        stolen_items << max_value_item
        remaining_space -= items[max_value_item][:space]
      end

      items.delete(max_value_item)
    end

    stolen_items
  end

  items2 = {
    'porcelain': { value: 3000, space: 3 },
    'guitar': { value: 2500, space: 2 },
    'necklace': { value: 2000, space: 0.5 },
    'laptop': { value: 1500, space: 1 },
    'tv': { value: 1000, space: 2.5 },
    'phone': { value: 800, space: 0.5 }
  }

  p Greedy.new.knapsack2(items2, 4)

  # PROBLEM3: The set-covering problem. Let's say you’re starting a radio show.
  # You want to reach people in all the 50 states. You have to decide what
  # stations to play on to reach all of those listeners, while trying to minimize
  # the number of stations you play on. You have a list of stations that are
  # covering a region, and there’s overlap. How do you figure out the smallest
  # set of stations you can play on to cover all the states?

  # Brute force solution:
  # 1. List every possible subset of stations. his is called the power set. Here
  # are 2^n possible subsets. => O(2^N) time complexity
  # 2. From these, pick the set with the smallest number of stations that covers
  # all 50 states.
  # This is of course not managable if you have more than 15 stations.

  # Greedy solution:
  # 1. Pick the station that covers the most states that haven’t been covered yet.
  # It’s OK if the station covers some states that have been covered already.
  # 2. Repeat until all the states are covered.
  # This solution is O(N2) which is way better compared to the prev solution.

  # Here is the greedy solution if we wanna cover 8 states
  def set_cover(states, stations)
    states_to_cover = states
    picked_stations = []

    while states_to_cover.any?
      strongest_station = nil
      max_covered_states = 0

      stations.each do |station|
        covered_states = station[:covered_states] & states_to_cover

        if covered_states.length > max_covered_states
          strongest_station = station
          max_covered_states = covered_states.length
        end
      end

      return false unless strongest_station
      picked_stations << strongest_station
      states_to_cover -= strongest_station[:covered_states]
    end

    picked_stations
  end

  states = ['AZ', 'CA', 'CO', 'ID', 'NM', 'NV', 'OR', 'UT', 'WA', 'WY']
  stations = [
    { name: 'station1', covered_states: ['CA', 'NV'] },
    { name: 'station2', covered_states: ['CA', 'ID', 'OR', 'WA'] },
    { name: 'station3', covered_states: ['AZ', 'NM'] },
    { name: 'station4', covered_states: ['AZ', 'NV', 'UT'] },
    { name: 'station5', covered_states: ['ID', 'MT', 'WY'] },
    { name: 'station6', covered_states: ['CO', 'UT', 'WY'] },
    { name: 'station7', covered_states: ['ID', 'NV', 'UT'] }
  ]

  p Greedy.new.set_cover(states, stations)

  def set_cover2(states, stations)
    states_to_cover = states
    picked_stations = []

    while states_to_cover.any?
      strongest_station = nil
      max_covered_states = 0

      stations.each do |name, covered_states_by_station|
        covered_states = covered_states_by_station & states_to_cover

        if covered_states.length > max_covered_states
          strongest_station = name
          max_covered_states = covered_states.length
        end
      end

      return false unless strongest_station
      picked_stations << strongest_station
      states_to_cover -= stations[strongest_station]
    end

    picked_stations
  end

  stations2 = {
    'station1': ['CA', 'NV'],
    'station2': ['CA', 'ID', 'OR', 'WA'],
    'station3': ['AZ', 'NM'],
    'station4': ['AZ', 'NV', 'UT'],
    'station5': ['ID', 'MT', 'WY'],
    'station6': ['CO', 'UT', 'WY'],
    'station7': ['ID', 'NV', 'UT']
  }

  p new.set_cover2(states, stations2)

  # You buy stocks and you wanna maximize your profit. You have to sell later
  # than you bought.

  # [5, 10, 4, 6, 12] should return 12 - 4 = 8

  # This greedy solution uses O(N) time and O(1) space.
  def max_profit(arr)
    min = arr.first
    diff = 0

    arr.each do |element|
      diff = [element - min, diff].max
      min = [element, min].min
    end

    diff
  end

  p new.max_profit([5, 10, 4, 6, 12])
end
