# SINGLE RESPONSIBILITY PRINCIPLE

# Design your classes so, that they only have one reason to change.
# Gather together the things that change for the same reasons and separate
# things that change for different reasons.


# Open Closed principle
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

# Example1
# While a Bike technically is a vehicle, the Vehicle class makes the assumption
# that all vehicles have an engine. Because the Bike subclass has no engine it
# does not satisfy the Liskov Substitution Principle for the Vehicle superclass.
module Example1
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

# DEPENDENCY INVERSION PRINCIPLE








