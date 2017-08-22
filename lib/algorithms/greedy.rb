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

    classes.each_with_index do |object, index|
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
  # can fit in your knapsack.

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
    { name: 'necklace', value: 2000, space: 0.1 },
    { name: 'laptop', value: 1500, space: 1 },
    { name: 'tv', value: 1000, space: 2.5 },
    { name: 'phone', value: 800, space: 0.5 }
  ]

  p Greedy.new.knapsack(items, 4)  
end
