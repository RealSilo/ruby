# PROBLEM

# Having ncompatible objects—objects that want to talk to each other but
# cannot because their interfaces do not match.

# GOF definition

# The Adapter design pattern allows otherwise incompatible classes to work
# together by converting the interface of one class into an interface
# expected by the clients.

# ADAPTER PATTERN

# Adapters allow us to bridge the gap between mismatching software interfaces
# by converting the interface of a class into another interface that the
# clients expect.

# In Ruby the ability to modify objects and classes on the fly at runtime can
# give use an optional solution so we don't have to create a separate adapter
# class.

# Modifying a class or a single instance to support the interface that you
# need makes the code simple than creating an adapter. If you modify
# the original class or object, you do not need the additional adapter class,
# nor do you need to worry about wrapping the adapter around the adaptee.
# Yet the modification technique violates encapsulation: You just dive in and
# start changing things. So when should you use an adapter, and when is it
# okay to rearrange the class? Adapters preserve encapsulation at the cost of
# some complexity. Modifying a class may buy you some simplification, but at
# the cost of tinkering with the plumbing.

# Use modification if:
# - The modifications are simple and clear. The method aliasing we did earlier
# is a prime example of a simple, clear modification
# - You understand the class you are modifying and the way in which it is used.

# Use adapter class if:
# - The interface mismatch is extensive and complex. For example, you probably
# would not want to modify a string to look like a Fixnum object.
# - You have no idea how this class works.

# WRAP UP
# Adapters exist to soak up the differences between the interfaces that we
# need and the objects that we have. An adapter supports the interface that
# we need on the outside, but it implements that interface by making calls to
# an object hidden inside — an object that does everything we need it to do,
# but does it via the wrong interface.
# In Ruby we can also  simply modify the object with the wrong interface at
# runtime so that it has the right interface. If you know how the thing
# works and your interface changes are relatively minor, perhaps modifying
# the object is the way to go. If the object is complex or if you simply do
# not understand it fully, use a classic adapter.

class Renderer
  def render(text_object)
    text = text_object.text
    size = text_object.size_inches
    color = text_object.color

    puts "Text: #{text}, size: #{size}, color: #{color}"
  end
end

class TextObject
  attr_reader :text, :size_inches, :color

  def initialize(text, size_inches, color)
    @text = text
    @size_inches = size_inches
    @color = color
  end
end

text_object = TextObject.new('hi', 5, 'blue')
p Renderer.new.render(text_object)

# The interface of this class doesn't match

class BritishTextObject
  attr_reader :string, :size_mm, :colour

  def initialize(string, size_mm, colour)
    @string = string
    @size_mm = size_mm
    @colour = colour
  end
end

# 1. Solution
# Creating adapter class

class BritishTextObjectAdapter < BritishTextObject
  def initialize(bto)
    @bto = bto
  end

  def text
    @bto.string
  end

  def size_inches
    @bto.size_mm / 25.4
  end

  def color
    @bto.colour
  end
end

british_text_object = BritishTextObject.new('hello', 300, 'green')
to = BritishTextObjectAdapter.new(british_text_object)
p Renderer.new.render(to)

# 2. Solution
# Extend the BritishTexObject to include the methods that the Renderer
# class requires with reopening the class

class BritishTextObject
  def text
    string
  end

  def size_inches
    size_mm / 25.4
  end

  def color
    colour
  end
end

british_text_object = BritishTextObject.new('haha', 200, 'red')
p Renderer.new.render(british_text_object)

# 3. Solution
# Modify class instances at run-time

bto = BritishTextObject.new('hihi', 100, 'yellow')

def bto.size_inches
  size_mm / 25.4
end

def bto.color
  colour
end

def bto.text
  string
end

p Renderer.new.render(bto)
