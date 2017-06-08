module Greeter
  def greet
    "hi there #{self.class} #{object_id} #{self.class.ancestors}"
  end

  def self.greet
    "huhu #{self.class} #{object_id} ancestors: #{self.ancestors}"
  end
end

module Farewell
  def greet
    "bye #{self.class.ancestors}"
  end
end

class Person
  def greet
    "bye from #{self.class}"
  end
  prepend Farewell
  prepend Greeter
end

class Dog
  extend Greeter
end

# puts Person.new.greet
# puts Dog.greet
# puts Greeter.greet

# puts Person.new.greet
# puts Dog.greet
# puts Greeter.greet


class Dog
  def self.all
    "all"
  end

  class << self
    def find
      "find"
    end
  end
end

# puts Dog.all
# puts Dog.find
class Class
  def my_attr_accessor(*args)

    #We simply iterate through each passed in argument...
    args.each do |arg|   
      #self will be an instance of the Class class

      #Here's the getter
      self.class_eval("def #{arg};@#{arg};end")

      # self.class_eval do
      #   define_method(arg) do
      #     instance_variable_get(arg)
      #   end
      # end
      
      #Here's the setter
      self.class_eval("def #{arg}=(val);@#{arg}=val;end")                                           
    end
  end
end



module MyModule
  def some_instance_method
    "instance method from #{self.class.name}"
  end

  def self.included(klass) #could be extended or prepended
    klass.extend ClassMethods

    klass.class_eval do
      puts "class eval"
      puts self
      puts object_id
      puts self.object_id
    end

    klass.instance_eval do
      my_attr_accessor(:haha, :hihi)
      #   scope :disabled, -> { where(disabled: true) }
    end
  end

  module ClassMethods
    def some_class_method
      puts "class method: #{self.class.name}"
    end
  end
end

class MyClass
  include MyModule
  # extend MyModule
  # extend MyModule::ClassMethods
  # self.my_attr_accessor(:haha, :hihi)
end

class YourClass
  include MyModule
  # self.my_attr_accessor(:haha, :hihi)
end

MyClass.new.some_instance_method
MyClass.some_class_method
my_class_instance = MyClass.new
my_class_instance.haha = "haha"
# puts my_class_instance.haha