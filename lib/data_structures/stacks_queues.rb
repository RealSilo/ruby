require 'byebug'

class StacksQueues
  class Stack
    # collection of items where the addition of new items and the
    # removal of existing items always takes place at the same end
    # LIFO (last-in first-out)

    # code stack -> code execution happens like this
    # web browser -> while navigating from web page to web page,
    #                those pages are placed on a stack (URL);
    #                clicking on back button wil move in reverse order
    #                through the pages

    def initialize
      @store = []
    end

    def pop
      @store.pop
    end

    def push(element)
      @store.push(element)
      self
    end

    def size
      @store.size
    end

    def peek
      @store.last
    end

    def empty?
      @store.empty?
    end
  end

  # stack = Stack.new
  # stack.push(1)
  # stack.push(2)
  # puts stack.push(3)
  # stack.pop
  # stack.empty?
  # puts stack.inspect

  class Queue
    # collection of items where the addition of new items and the
    # removal of existing items always takes place at the opposite end
    # FIFO (first-in first-out)

    # message queue

    def initialize
      @store = []
    end

    def enqueue(element)
      @store.unshift(element)
      self
    end

    def dequeue
      @store.pop
    end

    def empty?
      @store.empty?
    end

    def size
      @store.size
    end
  end

  # queue = Queue.new
  # queue.enqueue(1)
  # queue.enqueue(2)
  # queue.enqueue(3)
  # queue.dequeue
  # puts queue.inspect

  class Deque
    def intialize
      @store = []
    end

    def add_front(element)
      @store.unshift(element)
      self
    end

    def add_end(element)
      @store.push(element)
      self
    end

    def remove_front
      @store.shift
    end

    def remove_end
      @store.pop
    end

    def empty?
      @store.empty?
    end

    def size
      @store.size
    end
  end

  # PROBLEM 1: Balanced parantheses check
  # {{()}}{()} should return true
  # [][]{()}( should return false

  def balanced_parantheses?(string)
    return false if string.length.odd?

    openings = ['{', '(', '[']
    matches = [['{', '}'], ['(', ')'], ['[', ']']]

    stack = []

    string.each_char do |char|
      if openings.include?(char)
        stack.push(char)
      else
        return false if stack.empty?

        last_open = stack.pop

        return false unless matches.include?([last_open, char])
      end
    end

    stack.empty? ? true : false
  end

  # PROBLEM 2: Implement a Queue with 2 Stacks
  class QueueWithTwoStacks
    attr_reader :stack1, :stack2

    def initialize
      @stack1 = []
      @stack2 = []
    end

    def enqueue(element)
      stack1.push(element)
    end

    def dequeue
      if stack2.empty?
        stack2 << stack1.pop until stack1.empty?
      end

      stack2.pop
    end
  end

  # PROBLEM 3: Implement a Stack with 2 Queues
  class StackWithTwoQueues
    attr_reader :queue1, :queue2

    def initialize
      @queue1 = []
      @queue2 = []
    end

    def push(element)
      queue1.push(element)
    end

    def pop
      queue2.push(queue1.shift) while queue1.length > 1

      value = queue1.shift
      
      @queue1, @queue2 = @queue2, @queue1

      value
    end
  end

  # PROBLEM 4: Implement a Stack with a LinkedList
  module LinkedList
    class Node
      attr_accessor :value, :next_node

      def initialize(value, next_node = nil)
        @value = value
        @next_node = next_node
      end
    end

    class Stack
      attr_reader :first

      def initialize
        @first = nil
      end

      def push(value)
        @first = Node.new(value, @first)
      end

      def pop
        raise 'Stack is empty' if empty?
        value = @first.value
        @first = @first.next_node
        value
      end

      def empty?
        @first.nil?
      end
    end

    # s = Stack.new
    # s.push(1)
    # s.push(2)
    # s.push(3)
    # s.pop
    # p s.first.inspect

    # PROBLEM 5: Implement a Queue with a LinkedList
    # we don't need doubly linked list as we always remove
    # the first element
    class Queue
      def initialize
        @first = nil
        @last = nil
      end

      def enqueue(value)
        # @first = Node.new(value, @first)
        node = Node.new(value, nil)
        @last&.next_node = node
        @last = node
        @first = node unless @first
      end

      def dequeue
        raise 'Queue is empty' if empty?
        value = @first.value
        @last = nil unless @first.next_node
        @first = @first.next_node
        value
      end

      def empty?
        @first.nil?
      end

      def iterate
        result = []
        current = @first
        while current.next_node
          result << current.value
          current = current.next_node
        end
        result << current.value
        result
      end
    end

    # q = Queue.new
    # q.enqueue(1)
    # q.enqueue(2)
    # q.enqueue(3)
    # q.enqueue(4)
    # p q.iterate
    # q.dequeue
    # q.dequeue
    # q.dequeue
    # p q.inspect
  end

  # PROBLEM 6: Stack min method with O(1)
  module StackMin
    class Node
      attr_accessor :value, :next_node, :prev_min

      def initialize(value, next_node = nil)
        @value = value
        @next_node = next_node
        @prev_min = nil
      end
    end

    class Stack
      attr_reader :min

      def initialize
        @first = nil
        @min = nil
      end

      def push(val)
        @first = Node.new(val, @first)
        @min = @first unless @first.next_node
        if @first.value < @min.value
          @first.prev_min = @min
          @min = @first
        end
      end

      def pop
        raise 'Stack is empty' if empty?
        value = @first.value
        @min = @first.prev_min if @min == @first
        @first = @first.next_node
        value
      end

      def empty?
        @first.nil?
      end

      def min
        @min.value
      end
    end
  end

  # PROBLEM 7: Sort Stack: Write a program to sort a stack such that the smallest
  # items are on the top. You can use an additional temporary stack, but you may
  # not copy the elements into any other data structure (such as an array). The
  # stack supports the following operations: push, pop, peek, and isEmpty.

  # This algorithm is O(N2) time and O(N) space.
  # If we have the opportunity to have one more stack we could create 2 temp
  # stacks and use modified merge/quick sort.
  def sort_stack(stack)
    temp_stack = Stack.new

    until stack.empty?
      temp = stack.pop

      # while the top element in the temp_stack is greater than temp we push
      # those elements to the stack and push the temp to the temp stack, so
      # temp is always gets to the right place
      while !temp_stack.empty? && temp_stack.peek > temp
        stack.push(temp_stack.pop)
      end

      temp_stack.push(temp)
    end

    stack.push(temp_stack.pop) until temp_stack.empty?

    stack
  end

  # PROBLEM 8: An animal shelter, which holds only dogs and cats, operates on a
  # strictly "FIFO" basis. Peoplemustadopteitherthe"oldest"(based on arrival
  # time) of all animals at the shelter, or they can select whether they would
  # prefer a dog or a cat (and will receive the oldest animal of that type).
  # They cannot select which speci c animal they would like. Create the data
  # structures to maintain this system and implement operations such as enqueue,
  # dequeueAny, dequeueDog, and dequeueCat.

  module AnimalQueueProblem
    class Node
      attr_accessor :value, :next_node, :time

      def initialize(value, next_node = nil)
        @value = value
        @next_node = next_node
        @time = Time.now
      end
    end

    class Queue
      attr_reader :first, :last

      def initialize
        @first = nil
        @last = nil
      end

      def enqueue(value)
        node = Node.new(value, nil)
        @last&.next_node = node
        @last = node
        @first = node unless @first
      end

      def dequeue
        raise 'Queue is empty' if empty?
        value = @first.value
        @last = nil unless @first.next_node
        @first = @first.next_node
        value
      end

      def empty?
        @first.nil?
      end
    end

    class Animal
      def initialize(name, age)
        @name = name
        @age = age
      end
    end

    class Dog < Animal
    end

    class Cat < Animal
    end

    class AnimalQueue
      attr_reader :dogs, :cats

      def initialize
        @dogs = Queue.new
        @cats = Queue.new
      end

      def enqueue(animal)
        if animal.is_a?(Dog)
          @dogs.enqueue(animal)
        else
          @cats.enqueue(animal)
        end
      end

      def dequeue_any
        return @dogs.dequeue if @cats.empty?
        return @cats.dequeue if @dogs.empty?
        @dogs.last.time < @cats.last.time ? @dogs.dequeue : @cats.dequeue
      end

      def dequeue_cat
        @cats.dequeue
      end

      def dequeue_dog
        @dogs.dequeue
      end
    end

    # animal_queue = AnimalQueue.new
    # dog = Dog.new('Jack', 5)
    # animal_queue.enqueue(dog)
    # p animal_queue.dogs.inspect
    # p animal_queue.dequeue_any
  end
end
