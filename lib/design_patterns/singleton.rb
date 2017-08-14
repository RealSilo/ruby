# The motivation behind the Singleton pattern is very simple: There are some things
# that are unique. Programs frequently have a single configuration file. It is not
# unusual for a program to let you know how it is doing via a single log file. Many
# applications need to talk to exactly one database. If you only ever have one
# instance of a class and a lot of code that needs access to that instance, it seems
# silly to pass the object from one method to another. In this kind of situation,
# the GoF suggest that you build a singleton—a class that can have only one instance
# and that provides global access to that one instance.

class SimpleLogger
  attr_accessor :level
  ERROR = 1
  WARNING = 2
  INFO = 3

  @@instance = SimpleLogger.new

  # We make the new class method private, preventing any
  # other class from creating new instances of our logger.
  private_class_method :new

  def self.instance
    @@instance
  end

  def initialize
    @log = File.open('log.txt', 'w')
    @level =  WARNING
  end

  def error(msg)
    @log.puts(msg)
    @log.flush
  end

  def warning(msg)
    @log.puts(msg) if @level >= WARNING
    @log.flush
  end

  def info(msg)
    @log.puts(msg) if @level >= INFO
    @log.flush
  end
end

logger1 = SimpleLogger.instance   # Returns the logger
logger2 = SimpleLogger.instance   # Returns exactly the same logger
p logger1
p logger2

# Our singleton implementation does appear to have one problem, however. What if we
# want to build a second singleton class, perhaps for our configuration data? It
# seems that we will need to go through the whole exercise again: create a class
# variable for the singleton instance along with a class method to access it. Oh,
# and don’t forget to make the new method private. If we need a third instance, we
# need to do it all again a third time. This seems like a lot of duplicated effort.

require 'singleton'
class SimpleLogger
  include Singleton
  # Lots of code omitted...
end

# The Singleton module does all of the heavy lifting of creating the class variable
# and initializing it with the singleton instance, creating the class-level instance
# method, and making new private. All we need to do is include the module. From the
# outside, this new Singleton module-based logger looks exactly like our previous
# implementation. With the first implementation though the  instance is created before
# any client code ever gets a chance to call SimpleLogger.instance (eager instantiation).
# The Singleton module, by contrast, waits until someone calls instance before it
# actually creates its singleton (lazy instantiation).

# Alternatives

# Global variables
# $redis = Redis.new
$logger = SimpleLogger.new
LOGGER = SimpleLogger.new

# Both global variables and constants share a number of deficiencies as singletons.
# First, if you use a global variable or a constant for this purpose, there is no way
# to delay the creation of the singleton object until you need it. The global variable
# or constant is there from the moment we first set it. Second, neither of these
# techniques does anything to prevent someone from creating a second or third instance
# of your suppos- edly singleton class. You could, of course, deal with that issue
# separately. For example, you might create the singleton instance and then change the
# class so that it will refuse to create any more instances—but all of this is beginning
# to feel rather ad hoc and messy.

# Doesn't matter if you implement your singleton with the GoF class-managed technique or
# as a bunch of class level methods and variables, you are creating a single object with
# global scope. Create a singleton, and you have just made it possible for widely
# separated parts of your program to use that singleton as a secret channel to communicate
# with each other and tightly couple themselves to each other. The horrible consequences
# of this coupling are why software engineering got out of the global variable business
# in the first place. There is only one solution to this problem: Don’t do that. Properly
# used singletons are not global variables. They are meant to model things that occur
# exactly once. Yes, because it occurs only once, you can use a singleton as a unique
# communications channel between parts of your program, but it's a terrible idea.

# WRAP UP

# The Singleton pattern can help us deal with the cases where there is only one of
# something. There are two characteristics that make a singleton a singleton: A singleton
# class has exactly one instance, and access to that one instance is available globally.
# Using class methods and variables, we can easily build the classic implementation of the
# singleton, the one recommended by the GoF.
