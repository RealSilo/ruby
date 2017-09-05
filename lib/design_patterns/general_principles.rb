# GoF general principles:

# Separate out the things that change from those that stay the same.
# Program to an interface, not an implementation.
# Prefer composition over inheritance.
# Delegate, delegate, delegate.

# SEPARATE OUT THE THINGS THAT CHANGE FROM THOSE THAT STAY THE SAME.

# A key goal of software engineering is to build systems that allow us to
# contain the damage. In an ideal system, all changes are local: You should
# never have to comb through all of the code because A changed, which required
# you to change B, which triggered a change in D, which rippled all the way
# down to X. So how do you achieve — or at least get closer to — that ideal
# system, the one where all changes are local? You get there by separating the
# things that are likely to change from the things that are likely to stay the
# same. If you can identify which parts of your system design are likely to
# change, you can isolate those from the more stable parts. When requirements
# change you will still have to modify your code, but perhaps, the changes can
# be confined to those separated, change-prone areas and the rest of your code
# can live on in peace.

# PROGRAM TO AN INTERFACE NOT AN IMPLEMENTATION.

class MyCar
  def drive(speed)
    speed
  end
end

class MyAirplane
  def fly(speed)
    speed
  end
end

# Clearly, this bit of code is married to the Car class. It will work
# as long as the requirement is that we need to deal with exactly one
# type of vehicle: a car.

my_car = MyCar.new
my_car.drive(200)

# Of course, if the requirement changes and the code needs to deal with
# a second type of transport (such as an airplane), we suddenly have a
# problem. With only two flavors of vehicle to deal with, we might be
# able to get away with the following code:

vehicle = MyCar.new

if vehicle.is_a?(MyCar)
  vehicle.drive(200)
else
  vehicle.fly(200)
end

# Not only is this code messy, but it is now also coupled to both cars
# and airplanes. This fix may just about hold things together until a boat
# comes along. Or a train. Or a bike. A better solution, of course, is to
# return to Object-Oriented Programming 101 and apply a good dose of
# polymorphism. If cars and planes and boats all implement a common
# interface, we could improve things by doing something like the following:

class CarImproved
  def travel(speed)
    speed
  end
end

class AirplaneImproved
  def travel(speed)
    speed
  end
end

my_vehicle = CarImproved.new
my_vehicle.travel(200)

# In addition to being good, straightforward object-oriented programming,
# this second example illustrates the principle of programming to an interface.
# The original code worked with exactly one type of vehicle but the new and
# improved version will work with any Vehicle. The idea here is to program to
# the most general type you cannot to call a car a car if you can get away
# with calling it a vehicle, regardless of whether Car and Vehicle are real
# classes or abstract interfaces. And if you can get away with calling your car
# something more general still, such as a movable object, so much the better.
# As we shall see in the pages that follow, Ruby (a language that lacks
# interfaces in the built-in syntax sense) actually encourages you to program
# to your interfaces in the sense of programming to the most general types.
# By writing code that uses the most general type possible (for example, by
# treating all of our planes and trains and cars like vehicles whenever we can)
# we reduce the total amount of coupling in our code.

# PREFER COMPOSITION OVER INHERITANCE

# Inheritance sometimes seems like the solution to every problem. Need to model
# a car? Just subclass Vehicle, which is a kind of MovableObject. Similarly, as
# an AirPlane might branch off to the right under Vehicle while MotorBoat might
# go off to the left. At each level we have succeeded in taking advantage of all
# the workings of the higher-level superclasses. The trouble is that inheritance
# comes with some unhappy strings attached. When you create a subclass of an
# existing class, you are not really creating two separate entities: Instead,
# you are making two classes that are bound together by a common implementation
# core. Inheritance, by its very nature, tends to marry the subclass to the
# superclass. Change the behavior of the superclass, and there is an excellent
# chance that you have also changed the behavior of the subclass. Besides that
# subclasses have a unique view into the guts of the superclass. Any of the
# interior workings of the superclass that are not carefully hidden away are
# clearly visible to the subclasses. If inheritance has so many problems, what
# is the alternative? We can assemble the behaviors we need through composition.
# Instead of creating classes that inherit most of their talents from a superclass,
# we can assemble functionality from the bottom up. To do so, we equip our objects
# with references to other objects—namely, objects that supply the functionality
# that we need. Because the functionality is encapsulated in these other objects,
# we can call on it from whichever class needs that functionality. In short, we
# try to avoid saying that an object is a kind of something and instead say that it
# has something.

class Vehicle
  def start_engine
    'Engine started'
  end

  def stop_engine
    'Engine stopped'
  end
end

class Car < Vehicle
  def drive
    start_engine
    # go somewhere
    stop_engine
  end
end

class Bycicle < Vehicle
  # This class does not need engine
end

# Our car needs to start and stop its engine, but so will a lot of other vehicles, so
# let’s abstract out the engine code and put it up in the common Vehicle base class.
# That is great, but now all vehicles are required to have an engine. If we come across
# an engineless vehicle (for example, a bicycle or a sailboat), we will need to perform
# some serious surgery on our classes. Further, unless we take extraordinary care in
# building the Vehicle class, the details of the engine are probably exposed to the Car
# class. This is hardly the stuff of separating out the changeable from the static.

# We can avoid all of these issues by putting the engine code into a class all of its
# own, a completely standalone class, not a superclass of Car:

class Engine
  def start
    'Engine started'
  end

  def stop
    'Engine stopped'
  end
end

class DieselEngine < Engine
end

class GasolineEngine < Engine
end

class ComposedCar
  def initialize
    @engine = GasolineEngine.new
  end

  def drive
    @engine.start
    # go somewhere
    @engine.stop
  end

  def switch_to_diesel
    @engine = DieselEngine.new
  end
end

# Assembling functionality with composition offers a whole buch of advantages: The engine
# code is extracted into its own class, ready for reuse. As a bonus, by untangling the
# engine-related code from Vehicle, we have simplified the Vehicle class. We have also
# increased encapsulation. Separating out the engine-related code from Vehicle ensures that
# a steady wall of interface exists between the car and its engine. In inheritance-based
# version, all of the details of the engine implementation were exposed to all of the
# methods in Vehicle. In the new version, the only way a car can do anything to its engine
# is by using the public interface of the Engine class. We have also opened up
# the possibility of other kinds of engines. The Engine class itself could actually be an
# abstract type and we might have a few types of engines, all available for use by our car.
# On top of that, our car is not stuck with one engine implementation for its whole life.
# We can now swap our engines at runtime.

# Another example

# A is the base class
# B inherits from A
# C inherits from B
# D inherits from B

# C calls super, which runs code in B. B calls super which runs code in A. A and B contain
# unrelated features needed by both C & D. D is a new use case, and needs slightly different
# behavior in A’s init code than C needs. So the newbie dev goes and tweaks A’s init code.
# C breaks because it depends on the existing behavior, and D starts working. What we have
# here are features spread out between A and B that C and D need to use in various ways. C
# and D don’t use every feature of A and B… they just want to inherit some stuff that’s
# already defined in A and B. But by inheriting and calling super, you don’t get to be
# selective about what you inherit. With compositon let's say you have features:
# feat1, feat2, feat3, feat4. C needs feat1 and feat3, D needs feat1, feat2 and feat4:
# C => compose(feat1, feat3)
# D => compose(feat1, feat2, feat4)
# Now, imagine you discover that D needs slightly different behavior from feat1. It doesn’t
# actually need to change feat1, instead, you can make a customized version of feat1 and use
# that, instead. You can still inherit the existing behaviors from feat2 and feat4 with no
# changes:
# D => compose(custom1, feat2, feat4)
# And C remains unaffected. The reason this is not possible with class inheritance is because
# when you use class inheritance, you buy into the whole existing class taxonomy. If you want
# to adapt a little for a new use-case, you either end up duplicating parts of the existing
# taxonomy (the duplication by necessity problem), or you refactor everything that depends on
# the existing taxonomy to adapt the taxonomy to the new use case due to the fragile base
# class problem. Composition is immune to both.

# DELEGATE, DELEGATE, DELEGATE

# The original Car class exposed the start_engine and stop_engine methods to the world.
# Of course, we can do the same thing in our latest implementation of Car by simply
# foisting off the work onto the Engine object: This simple “pass the buck” technique goes
# by the name of delegation. Someone calls the start_engine method on our Car. The car
# object says, “Not my responsibility” and passes the problem off to the engine. The
# combination of composition and delegation is a powerful and flexible alternative to
# inheritance. We get most of the benefits of inheritance, much more flexibility, and none
# of the unpleasant side effects. Of course, nothing comes for free.
# Delegation requires an extra method call, as the delegating object passes the buck along.
# This extra method call will have some performance cost (but usually it will be minor).
# Another cost of delegation is the boilerplate code you need to write (all of those
# delegating methods such as start_engine and stop_engine) that do nothing except
# pass the buck on to the object that knows what to do. Fortunately, in Ruby we don’t
# have to write all of those boring methods.

class ComposedDelegateCar
  def initialize
    @engine = GasolineEngine.new
  end

  def drive
    start_engine
    # go somewhere
    stop_engine
  end

  def start_engine
    @engine.start
  end

  def stop_engine
    @engine.stop
  end

  def switch_to_diesel
    @engine = DieselEngine.new
  end
end
