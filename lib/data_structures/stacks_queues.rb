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

  # qwts = QueueWithTwoStacks.new
  # qwts.enqueue(1)
  # qwts.enqueue(2)
  # qwts.enqueue(3)
  # qwts.dequeue
  # puts qwts.inspect
  # qwts.dequeue
  # qwts.enqueue(4)
  # qwts.dequeue
  # puts qwts.inspect
  # qwts.dequeue
  # puts qwts.inspect

  # PROBLEM 3: Implement a Stack with a LinkedList
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

  # PROBLEM 4: Implement a Queue with a LinkedList
    class Queue
      def initialize
        @first = nil
        @last = nil
      end

      def enqueue(value)
        # @first = Node.new(value, @first)
        node = Node.new(value, nil)
        @last.next_node = node if @last
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

    q = Queue.new
    q.enqueue(1)
    q.enqueue(2)
    q.enqueue(3)
    q.enqueue(4)
    p q.iterate
    q.dequeue
    q.dequeue
    q.dequeue
    p q.inspect
  end
end


