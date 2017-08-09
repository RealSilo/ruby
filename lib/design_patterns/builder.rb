class Computer
  attr_accessor :display # :crt or :lcd
  attr_accessor :motherboard
  attr_reader :drives

  def initialize(display = :crt, motherboard = Motherboard.new, drives = [])
    @motherboard = motherboard
    @drives = drives
    @display = display
  end
end

class CPU
  # Common CPU stuff...
end
class BasicCPU < CPU
  # Lots of not very fast CPU-related stuff...
end
class TurboCPU < CPU
  # Lots of very fast CPU stuff...
end

class Motherboard
  attr_accessor :cpu, :memory_size

  def initialize(cpu = BasicCPU.new, memory_size = 1000)
    @cpu = cpu
    @memory_size = memory_size
  end
end

class Drive
  attr_reader :type # either :hard_disk, :cd or :dvd
  attr_reader :size # in MB
  attr_reader :writable # true if this drive is writable

  def initialize(type, size, writable)
    @type = type
    @size = size
    @writable = writable
  end
end

# Even with this somewhat simplified model of, constructing a new instance of Computer
# is painfully tedious:

motherboard = Motherboard.new(TurboCPU.new, 4000)
drives = []
drives << Drive.new(:hard_drive, 200000, true)
drives << Drive.new(:cd, 760, true)
drives << Drive.new(:dvd, 4700, false)

computer = Computer.new(:lcd, motherboard, drives)
puts computer.inspect

# The very simple idea behind the Builder pattern is that you take this kind of
# construction logic and encapsulate it in a class all of its own. The builder class
# takes charge of assembling all of the components of a complex object. Each builder has
# an interface that lets you specify the configuration of your new object step by step.
# In a sense, a builder is sort of like a multipart new method, where objects are created
# in an extended process instead of all in one shot. A builder for our computers might
# look something like this:

class ComputerBuilder
  attr_reader :computer
  
  def initialize
    @computer = Computer.new
  end

  def turbo
    @computer.motherboard.cpu = TurboCPU.new
  end

  def display=(display)
    @computer.display = display
  end

  def memory_size=(size_in_mb)
    @computer.motherboard.memory_size = size_in_mb
  end

  def add_cd(writer = false)
    @computer.drives << Drive.new(:cd, 760, writer)
  end

  def add_dvd(writer = false)
    @computer.drives << Drive.new(:dvd, 4000, writer)
  end

  def add_hard_disk(size_in_mb)
    @computer.drives << Drive.new(:hard_disk, size_in_mb, true)
  end
end

builder = ComputerBuilder.new
builder.display = :lcd
builder.turbo
builder.add_cd(true)
builder.add_dvd
builder.add_hard_disk(100000)
computer = builder.computer
puts computer.inspect

# The GOF called the client of the builder object the director because it directs the
# builder in the construction of the new object (called the product). Builders not only
# ease the burden of creating complex objects, but also hide the implementation details.
# The director does not have to know the specifics of what goes into creating the new
# object. When we use the ComputerBuilder class, we can stay blissfully ignorant of
# which classes represent the DVDs or the hard disks; we just ask for the computer
# configuration that we need.

# We said that the Builder pattern unlike the Factory pattern is less concerned about
# picking the right class and more focused on helping you configure your object.
# Extracting out all of the painful construction code is the main motivation behind
# builders. Nevertheless, given that builders are involved in object construction,
# they also are useful to make those “which class” decisions.

# Let's say that our computer business expands into selling laptops besides traditional
# desktop machines. Thus we now have two basic kinds of products: desktop computers and
# laptops.

class DesktopComputer < Computer
end

class Laptop < Computer
  def initialize(motherboard = Motherboard.new, drives = [])
    super(:lcd, motherboard, drives)
  end
end

class LaptopDrive
  attr_reader :type # either :hard_disk, :cd or :dvd
  attr_reader :size # in MB
  attr_reader :writable # true if this drive is writable

  def initialize(type, size, writable)
    @type = type
    @size = size
    @writable = writable
  end
end

# The components of a laptop computer are not the same as the ones you find in a desktop
# computer. Fortunately, we can refactor our builder into a base class and two subclasses
# to take care of the differences. The abstract base builder deals with all of the details
# that are common to the two kinds of computers:

class AbstractComputerBuilder
  attr_reader :computer

  def turbo
    @computer.motherboard.cpu = TurboCPU.new
  end

  def memory_size=(size_in_mb)
    @computer.motherboard.memory_size = size_in_mb
  end
end

class DesktopComputerBuilder < AbstractComputerBuilder
  def initialize
    @computer = DesktopComputer.new
  end

  def display=(display)
    @display = display
  end

  def add_cd(writer = false)
    @computer.drives << Drive.new(:cd, 760, writer)
  end

  def add_dvd(writer = false)
    @computer.drives << Drive.new(:dvd, 4000, writer)
  end

  def add_hard_disk(size_in_mb)
    @computer.drives << Drive.new(:hard_disk, size_in_mb, true)
  end
end

class LaptopBuilder < AbstractComputerBuilder
  def initialize
    @computer = Laptop.new
  end

  def display=(display)
    raise "Laptop display must be lcd" unless display == :lcd
  end

  def add_cd(writer = false)
    @computer.drives << LaptopDrive.new(:cd, 760, writer)
  end

  def add_dvd(writer = false)
    @computer.drives << LaptopDrive.new(:dvd, 4000, writer)
  end

  def add_hard_disk(size_in_mb)
    @computer.drives << LaptopDrive.new(:hard_disk, size_in_mb, true)
  end
end

builder = LaptopBuilder.new
builder.display = :lcd
builder.turbo
builder.add_cd(true)
builder.add_dvd
builder.add_hard_disk(100000)
computer = builder.computer
puts computer.inspect

# Besides making object construction easier, builders can make object construction
# safer. That final computer method makes an ideal place to check that the
# configuration requested by the client really makes sense and that it adheres to the
# appropriate business rules. For example, we might enhance our computer method to make
# sure that it has a sane hardware configuration:

class AbstractComputerBuilder
  def computer
    raise "Not enough memory" if @computer.motherboard.memory_size < 512
    raise "Too many drives" if @computer.drives.size > 3
    @computer
  end

  def turbo
    @computer.motherboard.cpu = TurboCPU.new
  end

  def memory_size=(size_in_mb)
    @computer.motherboard.memory_size = size_in_mb
  end
end

# An important thing to consider when writing and using builders is if you can use a
# single builder instance to create multiple objects. For instance, you might expect that
# you could use a LaptopBuilder to create a couple of identical computers in one go:

builder = LaptopBuilder.new
builder.add_hard_disk(100000)
builder.turbo
computer1 = builder.computer
computer2 = builder.computer

# The trouble is, because the computer method always returns the same computer, both
# computer1 and computer2 end up being references to the same computer, which is probably
# not what you expected here.

# One way to deal with this issue is to equip your builder with a reset method, which
# reinitializes the object under construction but it also means that you have to start
# the configuration process all over again for each computer.:

class LaptopBuilder
  # Rest of the code omitted...
  def reset
    @computer = LaptopComputer.new
  end
end

# As with factories, the main way that you can abuse the Builder pattern is by using it when
# you don’t need it. It is not a good idea to anticipate the need for a builder. Instead,
# let MyClass.new be your default way of creating new objects. Add in a builder only when
# requirements force you to do so.

# WRAP UP

# The idea behind the Builder pattern is that if your object is hard to build, if you
# have to write a lot of code to configure each object, then you should factor all of
# that creation code into a separate class, the builder.

# The Builder pattern suggests that you provide an object — the builder — that takes the
# specifications of your new object and deals with all the complexity of creating
# that object. Builders can also prevent you from constructing an invalid object and tell
# the client (weight can't be negative, etc.)
# When you create a builder, and especially when you use one, you need to think about the
# reusability issue. Can you use a single instance of a builder to create multiple
# instances of the product? It is certainly easier to write one-shot builders, or builders
# that need to be reset before reuse, than it is to create completely reusable builders.
# The question is this: Which kind of builder are you creating or using?
