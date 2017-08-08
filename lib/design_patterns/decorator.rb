# Decorator pattern enables you to easily add an enhancement to an existing
# object. The Decorator pattern also allows you to layer features atop one
# another so that you can construct objects that have exactly the right set
# of capabilities that you need for any given situation.

# WRAP UP

# The Decorator pattern is a straightforward technique that you can use to
# assemble exactly the functionality that you need at runtime. It offers an
# alternative to creating a monolithic “kitchen sink” object that supports
# every possible feature or a whole forest of classes and subclasses to cover
# every possible combination of features. Instead, with the Decorator pattern,
# you create one class that covers the basic functionality and a set of
# decorators to go with it. Each decorator supports the same core interface,
# but adds its own twist on that interface. The key implementation idea of the
# Decorator pattern is that the decorators are essentially shells: Each takes
# in a method call, adds its own special twist, and passes the call on to the
# next component in line. That next compo- nent may be another decorator, which
# adds yet another twist, or it may be the final, real object, which actually
# completes the basic request.

# The Decorator pattern lets you start with some basic functionality and layer
# on extra features, one decorator at a time. Because the Decorator pattern builds
# these lay- ers at runtime, you are free to construct whatever combination you
# need, at runtime.


# Let's say you have some text that needs to be written to a file. Sounds simple
# enough, but in your system sometimes you want to write out just the plain,
# unadorned text, but other times you want to number each line as it gets printed
# out. Sometimes you want to add a time stamp to each line as it goes out into the
# file. Sometimes you need a checksum from the text so that later on you can ensure
# that it was written and stored properly.

# The naive solution could be:

class EnhancedWriter
  attr_reader :check_sum
  
  def initialize(path)
    @file = File.open(path, "w")
    @check_sum = 0
    @line_number = 1
  end
  
  def write_line(line)
    @file.print(line)
    @file.print("\n")
  end

  def checksumming_write_line(data)
    data.each_byte { |byte| @check_sum = (@check_sum + byte) % 256 }
    write_line(data)
  end

  def timestamping_write_line(data)
    write_line("#{Time.new}: #{data}")
  end

  def numbering_write_line(data)
    write_line("#{@line_number}: #{data}")
    @line_number += 1
  end

  def close
    @file.close
  end
end

writer = EnhancedWriter.new('out.txt')

writer.write_line("A plain line")
# or
writer.checksumming_write_line('A line with checksum')
puts("Checksum is #{writer.check_sum}")
# or
writer.timestamping_write_line('with time stamp')
# or
writer.numbering_write_line('with line number')

# The problems with this approach: First, every client that uses EnhancedWriter
# will need to know whether it is writing out numbered, checksummed, or
# time-stamped text. And the clients do not need to know this just once, perhaps
# to set things up—no, they need to know it continuously, with every line of data
# that they write out. If a client gets things wrong just once — for example, if
# it uses timestamping_write_line when it meant to use numbering_write_line then
# the result is wrong. A less obvious problem with this “throw it all in one class”
# approach is that everything is thrown together in a one class. There is all of
# the line numbering code together with the checksum code, the time stamp code in
# the same class.

# Another silly solution could be using inheritance, but what if for example you
# want a checksum of your numbered output? What if you want to put line numbers
# on your output, but only after you add time stamps to it? You can still do it
# but the number of classes does seem to be getting out of hand. Now consider
# that even with the forest of classes, we still can’t get a checksum of that
# time-stamped text after we have line-numbered it. The trouble is that the
# inheritance-based approach requires you to come up with all possible combinations
# of features up-front, at design time. Chances are, you are not really going to
# need every single combination—you are just going to need the combinations that
# you need.

# A better solution would allow you to assemble the combination of features that
# you really need, dynamically, at runtime.

