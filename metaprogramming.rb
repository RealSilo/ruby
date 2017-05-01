module Greeter
  def greet
    "hi there"
  end
end

class Person
  include Greeter
end

class Dog
  extend Greeter
end


class Person
end

#class_eval is a method of the Module class, meaning that the receiver will be a module or a class.
Person.class_eval do
  def say_hello
   "Hello!"
  end
end

jimmy = Person.new
jimmy.say_hello # "Hello!"

#instance_eval, on the other hand, is a method of the Object class, meaning that the receiver will be an object
Person.instance_eval do
  def human?
    true
  end
end

Person.human? # true

#This could be useful when the class you want to add this method to is not known until runtime.


#class reopening vs instance_eval

class String
  def hello
    "world"
  end
end


my_world = "world"

String.class_eval do
  define_method(hello) do
    my_world
  end
end

#with class eval dynamic things also can be executed
met = "hello" #=> "hello"
String.class_eval "def #{met} ; 'world' ; end" #=> nil
"foo".hello #=> "hello"

#inside class_eval block outer local variables are visible
#inside reopened class outer local variables are NOT visible
#inside class_eval you CANNOT assign constants and class variables scoped to the class
#inside reopened class you CAN


#pure ruby module implementation
module M
  def some_instance_method
  end

  def self.included(base)
    base.extend ClassMethods

    base.class_eval do
      attr_accessor :foo
    end
  end

  module ClassMethods
    def some_class_method
    end
  end
end

class P
  include M

  some_instance_method
  self.some_class_method
end

#same with active support
require 'active_support/concern'
module M
  extend ActiveSupport::Concern

  def some_instance_method
  end

  included do
    scope :disabled, -> { where(disabled: true) }
    attr_accessor :foo
  end

  class_methods do
    def some_class_method
    end
  end
end

# real active support
# EXTRAS
# module dependency (u can include one concern into another one and it would extend
#                    only the top level class)

module MyModule
  include Custom::Concern

  def instance_method
    "instance_method"
  end

  in_class do # name must be changed
    attr_accessor :foo
  end

  class_methods do
    def class_method
      "class_method"
    end
  end
end

class MyClass
  include MyModule
end

# custom active support
module Custom
  module Concern
    def self.included(base)
      base.extend ClaassMethods
    end

    module Classmethods
      def in_class(&block)
        @included_block = block
      end

      def included(base)
        base.class_eval &@included_block

        const_set :ClassMethods, Module.new
        const_get(:ClassMethods).module_eval &@class_methods_block
        base.extend const_get :ClassMethods
      end

      def class_methods(&block)
        @class_methods_block = block
      end
    end
  end
end

# instance_eval

class MyClass
  def initialize
    @v = 1
  end
end

obj = MyClass.new

obj.instance_eval do
  self #=> #<MyClass:0x3440dc @v = 1
  @v #=> 1
end

v = 2
obj.instance_eval { @v = v }
obj.instance_eval { @v } #=> 2

#class eval

#When you don't know the name of the class you want to open

def add_method_to(klass)
  klass.class_eval do
    def greet; "hi"; end
  end
end

add_method_to(String)
"abc".greet #=> "hi"

# You can use class_eval on any variable that references the class,
# while class requires a constant. Also, class opens a new scope,
# losing sight of the current bindings

# you use instance_eval to open an object that is not a class,
# and class_eval to open a class definition and define methods with def.
# But what if you want to open an object that happens to be a class (or module)
# to do something other than using def? Should you use instance_eval or
# class_eval then? If all you want is to change self, then both instance_eval
# and class_eval will do the job nicely. However, you should pick the method
#that best communicates your intentions. If you’re thinking,
#“I want to open this object, and I don’t particularly care that it’s a class,”
# then instance_eval is fine. If you’re thinking, “I want an Open Class”
# then class_eval is almost certainly a better match.

# attr accessor implementation

class Class
  def attr_accessor(*args)

    #We simply iterate through each passed in argument...
    args.each do |arg|   
      #self will be an instance of the Class class

      #Here's the getter
      self.class_eval("def #{arg};@#{arg};end")

      self.class_eval do
        define_method(arg) do
          instance_variable_get(arg)
        end
      end
      
      #Here's the setter
      self.class_eval("def #{arg}=(val);@#{arg}=val;end")                                           
    end
  end
end



#dynamic methods

#FIRST EXAMPLE
#pry implementation

#setup
pry = Pry.new
pry.memory_size = 101
pry.memory_size # => 101
pry.quiet = true

#For each instance method like Pry#memory_size, there is a corresponding 
#class method (Pry.memory_size) that returns the default value of the attribute
Pry.memory_size # => 100


#To configure a Pry instance, you can call a method named Pry#refresh. 
#This method takes a hash that maps attribute names to their new values:
pry.refresh(:memory_size => 99, :quiet => false)
pry.memory_size # => 99
pry.quiet # => false

#Pry#refresh has a lot of work to do: it needs to go through each attribute (such as self.memory_size);
#initialize the attribute with its default value (such as Pry.memory_size); 
#and finally check whether the hash argument contains a new value for the same attribute, and if it does, set the new value.

#Pry#refresh could do all of those steps with code like this:
def refresh(options={})
  defaults[:memory_size] = Pry.memory_size
  self.memory_size = options[:memory_size] if options[:memory_size]

  defaults[:quiet] = Pry.quiet
  self.quiet = options[:quiet] if options[:quiet]

  # same for all the other attributes...
end

#with DYNAMIC methods

def refresh(options={})
  defaults = {}
  attributes = [ :input, :output, :commands, :print, :quiet,
                 :exception_handler, :hooks, :custom_completions,
                 :prompt, :memory_size, :extra_sticky_locals ]
  
  attributes.each do |attribute|
    defaults[attribute] = Pry.public_send(attribute)
  end

  defaults.merge!(options).each do |key, value|
    send("#{key}=", value) if respond_to?("#{key}=")
  end
  
  true
end

class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
  end

  def mouse
    info = @data_source.get_mouse_info(@id)
    price = @data_source.get_mouse_price(@id)
    result = "Mouse: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end

  def cpu
    info = @data_source.get_cpu_info(@id)
    price = @data_source.get_cpu_price(@id)
    result = "Cpu: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end

  # same for other parts....
end

#dynamic method version

class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
    #with the following line the invocations can be done during initialization
    data_source.methods.grep(/^get_(.*)_info$/) { Computer.define_component $1 }
  end

  def self.define_component(name)
    define_method(name) do
      info = @data_source.send "get_#{name}_info", @id
      price = @data_source.send "get_#{name}_price", @id
      result = "#{name.capitalize}: #{info} ($#{price})"
      return "* #{result}" if price >= 100
      result
    end
  end

  #the following method calls can be removed if are invoked during initialization
  # define_component :mouse
  # define_component :cpu
  # define_component :keyboard
end


#method missin version

class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
  end

  def method_missing(name)
    super if !@data_source.respond_to?("get_#{name}_info")
    info = @data_source.send("get_#{name}_info", @id)
    price = @data_source.send("get_#{name}_price", @id)
    result = "#{name.capitalize}: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end
end

#======================
# FIRST DSL
# FIRST STEP: Flat scope
# To be able to use the local vars everywhere we have to create
# flat scope by removing scope gates
#events.rb

def monthly_sales
  110 # TODO: read the real number from the database
end

target_sales = 100

event "monthly sales are suspiciously high" do
  monthly_sales > target_sales
end

event "an event that never happens" do
  monthly_sales <= target_sales
end

# NOW we have a flat scope => both events have access to the same local variable

#redflag.rb

def event(description)
  puts "ALERT: #{description}" if yield
end
load 'events.rb'

#IMPROVED DSL with setup

#events.rb

setup do
  puts "Setting up sky"
  @sky_height = 100
end

setup do
  puts "Setting up mountains"
  @mountains_height = 200
end

event "the sky is falling" do
  @sky_height < 300
end

event "it's getting closer" do
  @sky_height < @mountains_height
end

event "whoops... too late" do
  @sky_height < 0
end


#redflag.rb

def setup(&block)
  @setups << block
end

def event(description, &block)
  @events << { description: description, condition: block }
end

@setups = []
@events = [] #top level instance variable
load 'events.rb'

@events.each do |event|
  @setups.each do |setup|
    setup.call
  end
  puts "ALERT: #{event[:description]}" if event[:condition].call
end

#NEXT STEP: getting rid of top level ivars
# Top level ivars a bit better then global vars, but still easy
# to accidentally change them

#lambda {}.call is like IIFE in JS

#redflag.rb

lambda {
  setups = []
  events = []

  Kernel.send(:define_method, :setup) do |&block|
    setups << block
  end

  Kernel.send(:define_method, :event) do |description, &block|
    events << { description: description, condition: block }
  end

  Kernel.send(:define_method, :each_setup) do |&block|
    setups.each do |setup|
      block.call(setup)
    end
  end

  Kernel.send(:define_method, :each_event) do |&block|
    events.each do |event|
      block.call(event)
    end
  end
}.call

each_event do |event|
  each_setup do |setup|
    setup.call
  end
  puts "ALERT: #{event[:description]}" if event[:condition].call
end

# Kernel module is included by Object class, so Kernel gets into every
# object's ancestors chain. Every line of Ruby is always executed inside
# an object, so Kernel's instance methods are available from anywhere.

# Reason to use it: you want to share a variable among a few methods,
# and you don’t want anybody else to see that variable
# setups and events are shared by the defined Kernel methods and
# nobody else can see those vars, because they are local to lambda

#NEXT STEP: Independent Events (only if u need)
# At the moment events can change each other's shared top level ivars

event "define a shared var" do
  @x = 1
end

event "change the var" do
  @x = @x + 1
end

#Solution

each_event do |event|
  env = Object.new
  each_setup do |setup|
    env.instance_eval(&setup)
  end
  puts "ALERT: #{event[:description]}" if env.instance_eval(&(event[:condition]))
end



















