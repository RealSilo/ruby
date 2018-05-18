# SINGLE RESPONSIBILITY PRINCIPLE

# Design your classes so, that they only have one reason to change.
# Gather together the things that change for the same reasons and separate
# things that change for different reasons.

# Readability, Reusability, Easier to test

# What is a reason to change? For instance you have an invitation class with
# token generation.

# Also you check how often the class changes

# Open Closed principle

# Follows polymorphism

# To follow this rule you have to use some form of dependency injection.

# Either there are different options to do the same action based on type (so action
# just happens once) or you have to notify MORE objects that a change happend and
# those have to trigger some action. The second one can be nicely solved with the
# observer pattern.

module OpenClosed
  module Problem1
    class Vehicle
      attr_reader :type

      def initialize(type)
        @type = type
      end

      def start_engine
        # if you add a new Vehicle type you have to modify the Vehicle class
        if type.is_a? Car
          type.start_car
        elsif type.is_a? Moto
          type.start_moto
        end
      end
    end

    class Car
      def start_car
        puts 'start car'
      end
    end

    class Moto
      def start_moto
        puts 'start moto'
      end
    end

    Vehicle.new(Car.new).start_engine
    Vehicle.new(Moto.new).start_engine
  end

  module Solution1
    class Vehicle
      attr_reader :type

      def initialize(type)
        @type = type
      end

      def start_engine
        type.start_engine
      end
    end

    class Car
      def start_engine
        puts 'start car'
      end
    end

    class Moto
      def start_engine
        puts 'start moto'
      end
    end

    Vehicle.new(Car.new).start_engine
    Vehicle.new(Moto.new).start_engine
  end
end

# LISKOV SUBSTITUION PRINCIPLE
# Subclasses should add to base class's behavior, not replace it.

# Example1
# While a Bike technically is a vehicle, the Vehicle class makes the assumption
# that all vehicles have an engine. Because the Bike subclass has no engine it
# does not satisfy the Liskov Substitution Principle for the Vehicle superclass.

module Example1
  # This is where composition makes sense.
  class Engine
    def start
      puts 'start'
    end
  end

  class Vehicle
    def start_engine
      @engine.start
    end
  end

  class Car < Vehicle
    def initialize
      @engine = Engine.new
    end
  end

  class Moto < Vehicle
    def initialize
      @engine = Engine.new
    end
  end

  class Bike < Vehicle
  end

  Car.new.start_engine
  Moto.new.start_engine
  # Bike.new.start_engine This is not working!!!!!!!!
  # If you wanna make it work you have to use if else statements.
end

# Example2
module Example2
  class Vehicle
    attr_reader :details

    def initialize(weight, length)
      @details = { weight: weight, length: length }
    end
  end

  class Car < Vehicle
    def initialize(weight, length)
      # Child implements details in a way that doesn't make sense for Vehicle
      @details = [weight, length]
    end
  end

  vehicle = Vehicle.new(2500, 175)
  car = Car.new(3000, 200)

  vehicles = [vehicle, car]

  # vehicles.each {|v| p v.details[:weight] }
end

module Example3
  class Bird
    def walk
      puts 'walk'
    end

    def fly
      puts 'fly'
    end
  end

  class Eagle < Bird
  end

  class Cardinal < Bird
  end

  class Penguing < Bird
    # penguin cannot fly
  end

  # bird.fly

  # solution 1
  class Bird
    def walk
      puts 'walk'
    end
  end

  class FlyingBird < Bird
    def fly
      puts 'fly'
    end
  end

  class Eagle < FlyingBird
  end

  class Cardinal < FlyingBird
  end

  class Penguin < Bird
  end

  # flying_bird.fly

  # solution 2 => module
  class Bird
    def walk
      puts 'walk'
    end
  end

  module Flying
    def fly
      puts 'fly'
    end
  end

  class Eagle < Bird
    include Flying
  end

  class Cardinal < Bird
    include Flying
  end

  class Penguin < Bird
  end
end

# DEPENDENCY INVERSION PRINCIPLE

# Polymorphism

# High level modules should not depend on low level modules. Both should depend
# on abstractions. Systems tend to exhibit the dependency inversion principle
# as a natural result of using OCP.

# Dependencies should not be hardcoded but injected in the class

# Module vs Decorator
# Testing easier, you can swap things are runtime, follows SRP
# Mental overhead
