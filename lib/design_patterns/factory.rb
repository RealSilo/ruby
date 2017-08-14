# GOF definition

# The key detail that I have been glossing over until now is the one where your
# code magically knows which class to pick at some critical point. Picking the
# right class usually requires very little brain power: If I need a String or a
# Date or even a PersonnelRecord, I generally just call new on the String or
# Date or PersonnelRecord class and I am done. But sometimes the choice of which
# class to use is a critical decision. Examples of this kind of situation are
# easy to come by. For example, think about the Template Method pattern. When you
# use the Template Method pattern, you need to pick one of the subclasses, and
# the subclass that you pick determines which variation of the algorithm you will
# end up using. Will you be using a PlainReport or an HTMLReport today? Similarly,
# with the Strategy pattern, you must pick the correct strategy to feed to your
# context object: Do you need the CATaxCalculator or the NYTaxCalculator? Likewise,
# if you plan to proxy an object, you need to select the proxy class that does what
# you want. There are a number of ways to deal with the problem of picking the right
# class for the circumstances, including two of the original GoF patterns. One is
# the Factory Method pattern and the otfer is the Abstract Factory pattern. Thanks
# to some dynamic Ruby techniques we can build factories more effectively.

class Duck
  def initialize(name)
    @name = name
  end

  def eat
    puts("Duck #{@name} is eating.")
  end

  def speak
    puts("Duck #{@name} says Quack!")
  end
end

class FirstPond
  def initialize(number_ducks)
    @ducks = []
    number_ducks.times do |i|
      duck = Duck.new("Duck#{i}")
      @ducks << duck
    end
  end

  def simulate_one_day
    @ducks.each(&:speak) # shortened version of @ducks.each { |d| d.speak }
    @ducks.each(&:eat)
  end
end

pond = FirstPond.new(3)
pond.simulate_one_day

# What if we also have a Frog class?
# We can use template method:
class Frog
  def initialize(name)
    @name = name
  end

  def eat
    puts("Frog #{@name} is eating.")
  end

  def speak
    puts("Frog #{@name} says Crooooaaaak!")
  end
end

class SecondPond
  attr_reader :animals

  def initialize(number_animals)
    @animals = []
    number_animals.times do |i|
      animal = new_animal("Animal#{i}")
      @animals << animal
    end
  end

  def simulate_one_day
    @animals.each(&:speak)
    @animals.each(&:eat)
  end
end

class DuckPond < SecondPond
  def new_animal(name)
    Duck.new(name)
  end
end

class FrogPond < SecondPond
  def new_animal(name)
    Frog.new(name)
  end
end

pond = FrogPond.new(3)
pond.simulate_one_day

# Using Ruby's metaprogramming capabilites
class MetaSecondPond
  attr_reader :animals

  def initialize(number_animals, animal_type)
    @animals = []
    number_animals.times do |i|
      animal = Object.const_get(animal_type).new("#{animal_type}#{i}")
      @animals << animal
    end
  end

  def simulate_one_day
    @animals.each(&:speak)
    @animals.each(&:eat)
  end
end

pond = MetaSecondPond.new(3, 'Duck')
pond.simulate_one_day

# The GoF called this technique of pushing the “which class” decision down on a
# subclass the Factory Method pattern. Factory Method pattern is not really a new
# pattern at all. This pattern is really just the Template Method pattern applied
# to the problem of creating new objects. In both the Factory Method pattern and
# the Template Method pattern, a generic part of the algorithm (in our pond example,
# its day-to-day aquatic existence) is coded in the generic base class, and
# subclasses fill in the blanks left in the base class. With the factory method,
# those filled-in blanks determine the class of objects that will be living in the
# pond.

# But what if you also have to add some plants as well?

class Algae
  def initialize(name)
    @name = name
  end

  def grow
    puts("The Algae #{@name} soaks up the sun and grows")
  end
end

class WaterLily
  def initialize(name)
    @name = name
  end

  def grow
    puts("The water lily #{@name} floats, soaks up the sun, and grows")
  end
end

class ThirdPond
  def initialize(number_animals, animal_class, number_plants, plant_class)
    @animal_class = animal_class
    @plant_class = plant_class

    @animals = []
    number_animals.times do |i|
      animal = new_organism(:animal, "Animal#{i}")
      @animals << animal
    end

    @plants = []
    number_plants.times do |i|
      plant = new_organism(:plant, "Plant#{i}")
      @plants << plant
    end
  end

  def simulate_one_day
    @plants.each(&:grow)
    @animals.each(&:speak)
    @animals.each(&:eat)
  end

  def new_organism(type, name)
    if type == :animal
      @animal_class.new(name)
    elsif type == :plant
      @plant_class.new(name)
    else
      raise "Unknown organism type: #{type}"
    end
  end
end

pond = ThirdPond.new(3, Duck, 2, WaterLily)
pond.simulate_one_day

class MetaThirdPond
  def initialize(number_animals, animal_type, number_plants, plant_type)
    @animal_class = animal_class
    @plant_class = plant_class

    @animals = []
    number_animals.times do |i|
      animal = Object.const_get(animal_type).new("#{animal_type}#{i}")
      @animals << animal
    end

    @plants = []
    number_plants.times do |i|
      plant = Object.const_get(plant_type).new("#{plant_type}#{i}")
      @plants << plant
    end
  end

  def simulate_one_day
    @plants.each(&:grow)
    @animals.each(&:speak)
    @animals.each(&:eat)
  end
end

pond = ThirdPond.new(3, Duck, 2, WaterLily)
pond.simulate_one_day

# Suppose even more success has befallen your pond simulator, and new requirements
# are pouring in faster than ever. The most pressing request is to extend this
# program to model other types of habitats besides ponds. In fact, a jungle
# simulation seems to be the next order of business.

class Tree
  def initialize(name)
    @name = name
  end

  def grow
    puts("The tree #{@name} grows tall")
  end
end

class Tiger
  def initialize(name)
    @name = name
  end

  def eat
    puts("Tiger #{@name} eats anything it wants.")
  end

  def speak
    puts("Tiger #{@name} Roars!")
  end

  def sleep
    puts("Tiger #{@name} sleeps anywhere it wants.")
  end
end

# You also need to change your Pond class’s name to something more appropriate for
# jungles as well as ponds. Habitat seems like a good choice:

class FirstHabitat
  def initialize(number_animals, animal_class, number_plants, plant_class)
    @animal_class = animal_class
    @plant_class = plant_class

    @animals = []
    number_animals.times do |i|
      animal = new_organism(:animal, "Animal#{i}")
      @animals << animal
    end

    @plants = []
    number_plants.times do |i|
      plant = new_organism(:plant, "Plant#{i}")
      @plants << plant
    end
  end

  def simulate_one_day
    @plants.each(&:grow)
    @animals.each(&:speak)
    @animals.each(&:eat)
  end

  def new_organism(type, name)
    if type == :animal
      @animal_class.new(name)
    elsif type == :plant
      @plant_class.new(name)
    else
      raise "Unknown organism type: #{type}"
    end
  end
end

jungle = FirstHabitat.new(1, Tiger, 4, Tree)
jungle.simulate_one_day
pond = FirstHabitat.new(2, Duck, 4, WaterLily)
pond.simulate_one_day

# One problem with our new Habitat class is that it is possible to create incoherent
# combinations of fauna and flora. For instance, nothing in our current habitat
# implementation tells us that tigers and lily pads do not go together:
# unstable = Habitat.new( 2, Tiger, 4, WaterLily)
# This may not seem like much of a problem when you are dealing with just two kinds
# of things (plants and animals, in this case), but what if our simulation was much
# more detailed, extending to insects and birds and mollusks and fungi? We certainly
# don’t want any mushrooms growing on our lily pads or fish floundering away in the
# boughs of some jungle tree.
# We can deal with this problem by changing the way we specify which creatures live
# in the habitat. Instead of passing the individual plant and animal classes to Habitat,
# we can pass a single object that knows how to create a consistent set of products.
# We will have one version of this object for ponds, a version that will create frogs
# and lily pads. We will have a second version of this object that will create the
# tigers and trees for the jungle. An object dedicated to creating a compatible set of
# objects is called an abstract factory.

class SecondHabitat
  def initialize(number_animals, number_plants, organism_factory)
    @organism_factory = organism_factory
    @animals = []
    number_animals.times do |i|
      animal = @organism_factory.new_animal("Animal#{i}")
      @animals << animal
    end

    @plants = []
    number_plants.times do |i|
      plant = @organism_factory.new_plant("Plant#{i}")
      @plants << plant
    end
  end

  def simulate_one_day
    @plants.each(&:grow)
    @animals.each(&:speak)
    @animals.each(&:eat)
  end
end

class PondOrganismFactory
  def new_animal(name)
    Frog.new(name)
  end

  def new_plant(name)
    Algae.new(name)
  end
end

class JungleOrganismFactory
  def new_animal(name)
    Tiger.new(name)
  end

  def new_plant(name)
    Tree.new(name)
  end
end

# We can now feed different abstract factories to our habitat, serene in the knowledge
# that there will be no unholy mixing of pond creatures with jungle denizens:
jungle = SecondHabitat.new(1, 4, JungleOrganismFactory.new)
jungle.simulate_one_day
pond = SecondHabitat.new(2, 4, PondOrganismFactory.new)
pond.simulate_one_day

# The Abstract Factory pattern really boils down to a problem and a solution. The problem
# is that you need to create sets of compatible objects. The solution is that you write a
# separate class to handle that creation. In the same way that the Factory Method pattern
# is really the Template Method pattern applied to object creation, so the Abstract
# Factory pattern is simply the Strategy pattern applied to the same problem.

# More improvement

# One way to look at the abstract factory is to see it as a sort of super class object.
# While general class objects know how to create only one type of object (like instances
# of themselves), the abstract factory knows how to create several different types of
# objects (like its products). This suggests a way to simplify our Abstract Factory pattern
# implementation: We can make it a bundle of class objects, with one class for each product.

class OrganismFactory
  def initialize(plant_class, animal_class)
    @plant_class = plant_class
    @animal_class = animal_class
  end

  def new_animal(name)
    @animal_class.new(name)
  end

  def new_plant(name)
    @plant_class.new(name)
  end
end

jungle_organism_factory = OrganismFactory.new(Tree, Tiger)
pond_organism_factory = OrganismFactory.new(WaterLily, Frog)
jungle = SecondHabitat.new(1, 4, jungle_organism_factory)
jungle.simulate_one_day
pond = SecondHabitat.new(2, 4, pond_organism_factory)
pond.simulate_one_day

# The important thing about the abstract factory is that it encapsulates the knowledge of which
# product types go together. You can express that encapsulation with classes and subclasses, or
# you can get to it by storing the class objects as we did in the code above. Either way, you
# end up with an object that knows which kind of things belong together.
# We can also simplify the implementation of abstract factories by relying on a consistent
# naming convention for the product classes and using Metaprogramming.

# The easiest way to go wrong with any of the object creation techniques that we have examined
# in this chapter is to use them when you don’t need them. Not every object needs to be produced
# by a factory. In fact, most of the time you will want to create most of your objects with a
# simple call to MyClass.new. Use the techniques discussed in this chapter when you have a choice
# of several different, related classes and you need to choose among them.

# WRAP UP

# The Factory Method pattern involves the application of the Template Method pattern to object
# creation. As the Template Method this pattern says to just leave the “which class” question
# to be answered by a subclass. We saw that we could use this pattern to build a generic Pond
# class that knows all about environmental simulations but leaves the choice of the specific
# plant and animal classes to its subclass. We therefore create subclasses with names like
# DuckWaterLilyPond and FrogAlgaePond, which in turn fill in the factory methods with
# implementations that create the appropriate kinds of objects.
# The Abstract Factory pattern comes into play when you want to create compatible sets of objects.
# If you want to ensure that your frogs and algae don’t end up in the same habitat as your tigers
# and trees, then create an abstract factory for each valid combination.
# While the GoF concentrated on inheritance-based implementations of their factories, we can get
# the same results with way less code by taking advantage Ruby's specifications. In Ruby we can
# look up classes by name, pass them around, and store them away for future use.

# The Builder pattern, which also produces new objects is more focused on constructing complex
# objects than on picking the right class.
