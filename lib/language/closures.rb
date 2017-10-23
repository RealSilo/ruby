# closures

# Closures are functions that are bound to the environment that they were defined in.
# They retain access to variables that were in scope when they were created,
# but that might no longer be in scope when the closure is called.

# A closure is a first-class function that has lexical scope

# Advantages over methods:

# If you want to return more than one variables, you fail with methods,
# while you can easily yield multiple variables to a block.

# The methods dont’t have access to the surrounding variables
# at the point of its definition (scope gate).

# In practice closures may create elegant designs,
# allowing customization of various calculations.

# procs/lambdas ===========================

# first difference is the response to the number of arguments

number_lambda = lambda do |a,b,c|
  puts "The lambda numbers are #{a}, #{b} and #{c}"
end

# number_lambda.call(2,4,6)
## number_lambda.call(2) => this throws wrong arg number error

letter_lambda = -> (a,b,c) { puts "The lambda letters are #{a}, #{b} and #{c}" }

# letter_lambda.call('d', 'e', 'f')

closing_text = 'Last line of block'

number_proc = proc do |a,b,c|
  puts "c class: #{c.class}"
  puts "The proc numbers are #{a}, #{b} and #{c}"
  puts closing_text
end

# number_proc.call(3,5,7)
# number_proc.call(3)

#second difference is how they return from function call

def run_this_proc(p)
  puts "Start to run"
  p.call
  puts "Finished"
end

# run_this_proc lambda { puts "I am a lambda"; return }
# run_this_proc proc { puts "I am a proc"; return } # => unexpected return


# how to invoke procs

my_proc =  Proc.new do |n|
  puts "This is #{n}"
end

# my_proc.call(10)
# my_proc.(20)
# my_proc[30]
# my_proc === 40

few = Proc.new { |n| 0 < n && n < 3 }

0.upto(4) do |number|
  case number
  when few  # number === few
    # puts "few"
  else
    # puts "not few"
  end
end

# closure are bound to local vars around them
# methods are always bound to objects they are sent to

# ruby enumerable implementations

my_array = [2,3,4,5,88,99]

class Array
  def my_each(&block)
    i = 0
    while i < size
      block.call(self[i])
      i += 1
    end
  end
end

p my_array.my_each { |x| p "This is #{x}" }

class Array
  def my_map(&block)
    array = []
    i = 0
    while i < size
       array << block.call(self[i])
       i += 1
    end
    array
  end
end

p my_array.my_map { |x| x * 2 }

class Array
  def advanced_my_map(&block)
    array = []
    my_each { |x| array << block.call(x) }
    array
  end
end

p my_array.advanced_my_map { |x| x * 3 }

def my_select(array, &block)
  array.reduce([]) do |selected, val|
    selected << val if block.call(val)
    selected
  end
end

def random_limit
  rand(100)
end

p my_select(my_array) {|x| x < random_limit }

# bc = [1,2,3].reduce([]) { |sum,val| sum << val }
class Array
  def my_select_on_array(&block)
    reduce([]) do |selected, val|
      block.call(val) ? selected << val : selected
    end
  end
end

p my_array.my_select_on_array {|x| x > random_limit }

greater_proc = Proc.new { |x,y| x > y }

p my_array.my_select_on_array { |x| greater_proc.call(x, random_limit) }

# This is like IIFE in JS

lambda {
  letters = %w(a b)

  def print_letters(letters)
    p letters
  end

  print_letters(letters)
}.call

letters

# class Array
#   def my_filter(&block)
#     result = []
#     self.each do |element|
#       result << element if block.call(element)
#     end
#     result
#   end
# end

# def pos_odd_by7_by19(n)
#   return true if n > 0 && n.odd? && n % 7 == 0 && n % 19 == 0
#   false
# end

# lam_pos_odd_by7_by19 = -> (n) { n > 0 && n.odd? && n % 7 == 0 && n % 19 == 0 }

# c = [2, 133, 931].my_filter { |i| lam_pos_odd_by7_by19.call(i) }
# b = [2, 133, 931].my_filter(&lam_pos_odd_by7_by19)
# a = [2, 133, 931].my_filter { |i| pos_odd_by7_by19(i) }

# p a
# p b
# p c

# class Array
#   def my_filter2(condition)
#     result = []
#     self.each do |element|
#       result << element if condition.call(element)
#     end
#     result
#   end
# end

# first_check = 7
# second_check = 19

# lam_pos_odd_by_first_by_second = -> (n) do
#   n > 0 && n.odd? && n % first_check == 0 && n % second_check == 0
# end

# d = [2, 133, 931].my_filter2(lam_pos_odd_by_first_by_second)
# p d

