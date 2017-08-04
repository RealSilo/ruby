# GOF DEFINITION:

# Define a one-to-many dependency between objects so that when one object
# changes state, all of its dependents are notified and updated automatically.

# THE OBSERVER PATTERN

# One of the hardest design challenges is the problem of building a system
# that is highly integrated—that is, a system where every part is aware of
# the state of the whole. For instance buliding a personnel system that
# needs to let the payroll department know when someone’s salary changes?
# Building this kind of system is tough enough, but adding the requirement
# that the system be maintainable and now you are talking truly hard.
# How can you tie the different parts of a large software system together
# without increasing the coupling between classes to the point where the
# whole thing becomes a tangled mess? How can you make the Employee object
# tell the news about salary changes without coupling it to the payroll system?

# One way to solve this problem is to focus on the fact that the Employee
# object is acting as a source of news. Peter gets a raise and his Employee
# record tells the world (or at least to anyone who is interested),
# “Hello! I’ve got some changes here!” Any object that is interested in
# the state of Peters’s finances need simply register with his Employee object
# ahead of time. Once registered, that object would receive the updates
# about the ups and downs of Peter’s payroll.

# What should we do if we need to keep other objects — maybe some
# accounting-related classes — informed about Peters’s financial state?
# To change the Employee class in this situation would be pretty
# unfortunate because nothing in the Employee class is really changing.
# It is the other classes — the payroll and accounting classes — that are
# actually driving the changes to Employee. We can  solve this notification
# problem in clearly general way. We can separate out the thing that is
# changing — who gets the news about salary changes — from the real guts of
# the Employee object. What we need is a list of objects that are interested
# in hearing about the latest news from the Employee object. We can set up
# an array (@observers) for just that purpose in the initialize method and
# we inform all of the observers when something has changed.

# The GoF called this idea of building a clean interface between the source
# of the news that some object has changed and the consumers of that news the
# Observer pattern. The GoF called the class with the news the subject class.
# In our example, the subject is the Employee class. The observers are the
# objects that are interested in getting the news. In our employee example,
# we have two observers: Payroll and TaxMan. When an object is interested in
# being informed of the state of the subject, it registers as an observer on
# that subject.

# While the observer object gets top billing it is actually the subject that
# does most of the work. It is the subject that is responsible for keeping
# track of the observers. It is also the subject that needs to inform the
# observers when something has changed.

# WRAP UP

# The Observer pattern helps you build components that know about the
# activities of other components without tight coupling. By creating an
# interface between the source of the news (the observable object) and
# the consumer of that news (the observers), the Observer pattern moves the
# news without tangling things up.

# Most of the work occurs in the subject or observable class. In Ruby, we
# can extract that mechanism out into either a superclass or rather a module.
# The interface between observer and observable can be a complex as you like,
# but if you are building a simple observer, code blocks work well.

# The Observer pattern and the Strategy pattern look alike: Both feature
# an object (called the observable in the Observer pattern and the context in
# the Strategy pattern) that makes calls to some other objects (either the
# observer or the strategy). The difference is the intent. In the case of
# the observer, we are informing the other object of the events occurring back
# at the observable. In the case of the strategy, we are getting the strategy
# object to do some computing.

# The Observer pattern also serves more or less the same function as hook
# methods in the Template Method pattern; both keep some object informed of
# current events. The difference is that the Template Method pattern will only
# talk to its relatives: If you are not a subclass, you will not get any news
# from a Template Method pattern hook.

# FIRST IMPLEMENTATION

# Implementing the Observer pattern in Ruby is usually no more complex than
# our Employee example suggested: just an array to hold the observers and a
# couple of methods to manage the array, plus a method to notify everyone
# when something changes. But surely we can do better than to repeat this code
# every time we need to make an object observable, so we extract the observer
# specific code to a separate module.

module Subject
  def initialize
    @observers = []
  end

  def add_observer(observer)
    @observers << observer
  end

  def delete_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each do |observer|
      observer.update(self)
    end
  end
end

class Employee
  include Subject

  attr_reader :name, :salary, :position

  def initialize(name, position, salary)
    super()
    @name = name
    @position = position
    @salary = salary
  end

  def salary=(salary)
    @salary = salary
    notify_observers
  end

  def position=(position)
    @salary = salary
    notify_observers
  end
end

class Payroll
  def update(changed_employee)
    puts("Cut a new check for #{changed_employee.name}!")
    puts("His salary is now #{changed_employee.salary}!")
  end
end

class Accountant
  def update(changed_employee)
    puts("Send #{changed_employee.name} a new tax bill!")
  end
end

peter = Employee.new('Peter', 'Operations Manager', 85_000)
payroll = Payroll.new
peter.add_observer(payroll)
accountant = Accountant.new
peter.add_observer(accountant)
peter.salary = 135_000

# IMPROVED IMPLEMENTATIONS

# Most of the problems that come up in using the Observer
# pattern revolve around the frequency and timing of the updates.
# Sometimes the sheer volume of updates can be a problem. For
# example, an observer might register with a subject, unaware that
# the subject is going to spew out thousands of updates each second.
# The subject class can help with all of this by avoiding
# broadcasting redundant updates.

# 1. consideration:
# Just because someone updates an object, it does not mean that
# the value has changed. We should not notify the observers if
# nothing has actually changed.

class EmployeeImproved
  include Subject

  attr_reader :name, :position, :salary

  def initialize(name, position, salary)
    super()
    @name = name
    @position = position
    @salary = salary
  end

  def salary=(new_salary)
    old_salary = @salary
    @salary = new_salary
    notify_observers unless old_salary == new_salary
  end

  def position=(new_position)
    old_position = @position
    @position = new_position
    notify_observers unless old_position == new_position
  end
end

# 2. consideration:
# Another potential problem lies in the consistency of the subject
# as it notifies its observers of changes. For instance we enhance our
# employee example a bit so that it notifies its observers of changes
# in an employee’s position as well as his or her salary. If Peter gets a
# big promotion and a big raise to go along with it. We might code that
# as:

peter = Employee.new('Peter', 'Operations Manager', 90_000)
peter.salary = 140_000
# But here we have an inconsistent state!
peter.position = 'COO'

# The problem with this is that because he receives his raise before his new
# position takes effect, Peter will briefly become the highest-paid
# operations manager. This would not matter, except that all of our observers
# are listening and experiencing that inconsistent state.

class EmployeeImproved
  include Subject

  attr_reader :name
  attr_accessor :salary, :position

  def initialize(name, position, salary)
    super()
    @name = name
    @position = position
    @salary = salary
  end

  def changes_complete
    notify_observers
  end
end

peter = EmployeeImproved.new('Peter', 'Operations Manager', 90_000)
payroll = Payroll.new
peter.add_observer(payroll)
accountant = Accountant.new
peter.add_observer(accountant)
peter.salary = 140_000
peter.position = 'COO'
peter.changes_complete
