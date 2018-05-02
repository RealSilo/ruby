puts 3.class
puts 'a'.class
puts nil.class
puts false.class

class MyClass
  def double(n)
    n * 2
  end
end

m = MyClass.new.method(:double)
puts m.class
puts m.is_a?(Object)
puts m.call(2)

double = Proc.new { |n| n * 2 }
puts double.class
puts double.call(2)

# Operators implemented as methods
class String
  def +(string)
    "myplus: #{self}#{string}"
  end
end

puts 'a' + 'b'
