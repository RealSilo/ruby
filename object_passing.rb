a = 1
b = a
b += 1

puts a
puts b

def increment(int)
  int += 1
end

c = 3
increment(c)
puts c

def strincrement(str)
  str += "hihi"
end

d = "haha"
strincrement(d)
puts d

def change_string(str)
  str << "huhu"
  str = "why?"
end

e = "hoho"
change_string(e)
puts e

def print_id(int)
  puts "In method object id: #{int.object_id}"
end

f = 10
puts "Outside method object id: #{f.object_id}"
print_id f


def change_string_with_id(str)
  puts str.object_id
  puts str
  str << "old"
  puts str.object_id
  puts str
  str = "new"
  puts str.object_id
  puts str
end

g = "hoho"
puts "Outside method object id #{g.object_id}"
change_string_with_id(g)
puts g

def zero(x)
  x = 0
end

def set_number
  x = 5
  zero(x)
  puts x
end

set_number

# RUBY VARIABLES AND CONSTANTS AREN’T OBJECTS, BUT ARE REFERENCES TO OBJECTS.
# Assignment merely changes which object is bound to a particular variable.

# RUBY IS PASS BY REFERENCE VALUE, pass by reference of the value, or pass by value of the reference.
# It’s a little muddy, but the 3 terms mean the same thing: RUBY PASSES AROUND COPIES OF THE REFERENCES.
# In short, ruby is neither pass by value nor pass by reference,
# but instead employs a third strategy that blends the two strategies.

# The method can use the references to modify the referenced object (if mutable),
# but since the reference itself is a copy, the original reference cannot be changed.


