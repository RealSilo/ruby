class Class
  def haha
    "hihi"
  end
end

module M
  def self.included(base)
    base.class_eval do
      haha #this is a method INVOCATION not DEFINITION so it must be in class_eval
    end
  end
end

class MyClass
  include M
end

# puts MyClass.new.respond_to?(:haha)
# puts MyClass.respond_to?(:haha)



module Custom
  module Concern
    def self.included(base) #MyModule #this trick took place in our modules before
      base.extend ClassMethods
    end

    module ClassMethods
      def class_methods(&block)
        @class_methods_block = block #saving it to be able to execute later
      end

      def in_class(&block) #name clash with the next method
        @instance_methods_block = block #block must run in class where we include MyModule
      end

      def included(base) # CustomClass #when MyModule included in the class this will be executed
        base.class_eval(&@instance_methods_block) # code runs in class body(instance methods in class)

        const_set(:ClassMethods, Module.new) # module Classmethods;end
        const_get(:ClassMethods).module_eval(&@class_methods_block) # Classmethods.module_eval(&@class_methods_block)
        base.extend const_get :ClassMethods
      end
    end
  end
end

module MyModule
  include Custom::Concern

  def instance_method
    "instance_method"
  end

  in_class do
    attr_accessor :foo
  end

  class_methods do
    def class_method
      "class method"
    end
  end
end

class CustomClass
  include MyModule
end

puts CustomClass.new.instance_method
puts CustomClass.instance_methods(false).inspect
puts CustomClass.class_method
