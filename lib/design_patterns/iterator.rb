# GOF definition

# Provide a way to access the elements of an aggregate object
# sequentially without exposing its underlying representation.

# EXTERNAL ITERATOR
# This style of iterator is sometimes referred to as an external
# iterator because the iterator is a separate object from the
# aggregate.

class ArrayIterator
  def initialize(array)
    # We create a new array so it will be resistant to changes
    # during iteration.
    @array = Array.new(array)
    @index = 0
  end

  def has_next?
    @index < @array.length
  end

  def item
    @array[@index]
  end

  def next_item
    value = @array[@index]
    @index += 1
    value
  end
end

array = %w[red green blue]
i = ArrayIterator.new(array)
puts("item: #{i.next_item}") while i.has_next?

# With just a few lines of code, our ArrayIterator gives us just about
# everything we need to iterate over any Ruby array.
# Given how easy it was to build ArrayIterator, it is surprising that
# external iter- ators are so rare in Ruby. It turns out that Ruby has
# something better—and that this something better is based on our old
# friends the code block and the Proc object.

# INTERNAL ITERATOR

# The purpose of an iterator is to introduce your code to each subobject
# of an aggregate object. Traditional external iterators do so by
# providing the iterator object, that you can use to pull the subobjects
# out of the aggregate without getting messily involved in the aggregate
# details. But by using a code block, you can pass your logic down into
# the aggregate. The aggregate can then call your code block for each of
# its subobjects. Because all of the iterating action occurs inside the
# aggregate object, the code block-based iterators are called internal
# iterators.

# We don't need to use the following iterator as the array class already
# implements it.

def for_each(array)
  i = 0
  while i < array.length
    yield(array[i])
    i += 1
  end
end

def change_resistant_for_each(array)
  copy = Array.new(array)
  i = 0
  while i < copy.length
    yield(copy[i])
    i += 1
  end
end

for_each(array) { |element| puts("item: #{element}") }

# EXTERNAL ITERATORS VS INTERNAL ITERATORS

# External iterators certainly have some advantages. For instance, when
# you use an external iterator, the client drives the iteration. With
# an external iterator, you won’t call next until you are ready
# for the next element. With an internal iteator, by contrast, the
# aggregate relentlessly pushes the code block to accept item after item.
# Another advantage of external iterators is that, because they are external,
# you can share them—you can pass them around to other methods and objects.
# Of course, this is a double-edged sword: You get the flexibility but you
# also have to know what you are doing otherwise you run into some
# concurrency problems.
# The main pro of internal iterators is simplicity and code clarity.

def merge(arr1, arr2)
  merged = []
  iterator1 = ArrayIterator.new(arr1)
  iterator2 = ArrayIterator.new(arr2)

  while iterator1.has_next? && iterator2.has_next?
    if iterator1.item < iterator2.item
      merged << iterator1.next_item
    else
      merged << iterator2.next_item
    end
  end

  # Pick up the leftovers from arr1
  merged << iterator1.next_item while iterator1.has_next?

  # Pick up the leftovers from arr2
  merged << iterator2.next_item while iterator2.has_next?

  merged
end

p merge([1, 3, 5, 7], [2, 4, 6, 8])

# WRAP UP

# With he external iterator an object points down at a member of some
# collection. With an internal iterator, instead of passing some sort of
# pointer up, we pass the code that needs to deal with the subobjects down.
