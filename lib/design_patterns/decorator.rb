# GOF definition

# Attach additional responsibilities to an object dynamically. Decorators provide
# a flexible alternative to subclassing for extending functionality.

# DECORATOR PATTERN

# Decorator pattern enables you to easily add an enhancement to an existing
# object. The Decorator pattern also allows you to layer features atop one
# another so that you can construct objects that have exactly the right set
# of capabilities that you need for any given situation.

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

  def checksumming_write_line(line)
    line.each_byte { |byte| @check_sum = (@check_sum + byte) % 256 }
    write_line("#{line} and its checksum: #{@check_sum}")
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

writer = EnhancedWriter.new('template/out.txt')

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
# you really need, dynamically, at runtime. Let’s start over with a very simple
# object (SimpleWriter) that just knows how to write the plain text and do a few
# other file-related actions. If you want your lines numbered, insert an object
# (NumberingWriter) between your SimpleWriter and the client, an object that adds
# a number to each line and forwards the whole thing on to the basic SimpleWriter,
# which then writes it to disk. NumberingWriter adds its own contribution to the
# abilities of SimpleWriter (decorates SimpleWriter); hence the name of the pattern.

class SimpleWriter
  def initialize(path)
    @file = File.open(path, 'w')
  end

  def write_line(line)
    @file.print(line)
    @file.print("\n")
  end

  def pos
    @file.pos
  end

  def rewind
    @file.rewind
  end

  def close
    @file.close
  end
end

# Since we have a few of these decorators let’s factor out the generic code into a
# common base class:
class WriterDecorator
  def initialize(real_writer)
    @real_writer = real_writer
  end

  def write_line(line)
    @real_writer.write_line(line)
  end

  def pos
    @real_writer.pos
  end

  def rewind
    @real_writer.rewind
  end

  def close
    @real_writer.close
  end
end

class NumberingWriter < WriterDecorator
  def initialize(real_writer)
    super(real_writer)
    @line_number = 1
  end

  def write_line(line)
    @real_writer.write_line("#{@line_number}: #{line}")
    @line_number += 1
  end
end

class CheckSummingWriter < WriterDecorator
  attr_reader :check_sum

  def initialize(real_writer)
    @real_writer = real_writer
    @check_sum = 0
  end

  def write_line(line)
    line.each_byte { |byte| @check_sum = (@check_sum + byte) % 256 }
    @real_writer.write_line("#{line} and its checksum: #{@check_sum}")
  end
end

class TimeStampingWriter < WriterDecorator
  def initialize(real_writer)
    @real_writer = real_writer
  end

  def write_line(line)
    @real_writer.write_line("#{Time.new}: #{line}")
  end
end

# Because the NumberingWriter class presents the same core interface as the plain
# old writer, the client does not really have to worry about the fact that it is
# talking to a NumberingWriter instead of the SimpleWriter. From outside both
# flavors of writer look exactly the same.
writer = NumberingWriter.new(SimpleWriter.new('template/out2.txt'))
writer.write_line('Hello out there')

# Because all of the decorator objects support the same basic interface as the
#Coriginal, the “real” object that we supply to any one of the decorators does not
# actually have to be an instance of SimpleWriter — it can be any other decorator.
# Thanks to this we can build arbitrarily long chains of decorators, with each one
# adding its own secret ingredient to the whole. For instance we can finally get
# that checksum of that time-stamped text, after we have line-numbered it:
combined_writer = CheckSummingWriter.new(
  TimeStampingWriter.new(
    NumberingWriter.new(
      SimpleWriter.new('template/out3.txt')
    )
  )
)
combined_writer.write_line('Hello out there')

# The Decorator pattern takes one of GoF advices to heart: It incorporates a
# lot of delegation. We can see this in the WriterDecorator class, which consists
# almost entirely of boilerplate methods that do nothing except delegate to the next
# writer down the line. We could eliminate all of this boring code with metaprogramming
# or delegators. In Ruby we also could use alias method chain.

# With the Decorator pattern the annoying moment comes when someone tries to assemble
# all of these little building block classes into a working whole. Instead of being able
# to instantiate a single object with EnhancedWriter.new(path), the client has to put all
# of the pieces together itself. Of course, there are things that the author of a decorator
# implementation can do to ease the assembly burden. If there are common chains of
# decorators that your clients will need, by all means provide a utility (maybe Builder)
# to get that assembly done.
# One thing to remember when implementing the Decorator pattern is that you need to
# keep the component interface simple. You want to avoid making the component interface
# too complex, because a complex interface will make it that much harder to get each
# decorator right. Another potential drawback of the Decorator pattern is the performance
# overhead associated with a long chain of decorators. When you trade in that single,
# monolithic ChecksummingNumberingTimestampingWriter class for a chain of decorators, you
# are gaining a lot of programming compartmentalization and code clarity. Of course, the
# price you pay is that you are multiplying the number of objects floating around in your
# program.

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
