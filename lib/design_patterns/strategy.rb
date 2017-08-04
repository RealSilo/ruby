# This pattern is useful for varying parts of an algorithm at runtime,
# similarly to the Template Method pattern. Unlike the Template Method,
# which uses inheritance to change part of the algorithm, Strategy uses
# Dependency Injection.

# It’s a powerful tool for keeping code maintainable by adhering to the
# “D” in SOLID, the Dependency Inversion Principle. DIP states that
# concretions (details) should depend on abstractions, rather than the
# other way around. By injecting a dependency at runtime we decouple our
# abstraction from the concrete implementations of its algorithm.

# Unfortunately, the Template Method pattern has some drawbacks, most of
# which come from the fact that this pattern is using inheritance. Basing
# your design on inheritance has some serious disadvantages. No matter
# how carefully you design your code, your subclasses are tangled up with
# their superclass: It is in the nature of the relationship. Besides this,
# inheritance-based techniques such as the Template Method pattern limit
# our runtime flexibility. Once we have chosen a particular variation
# of the algorithm changing our mind is hard. With the Template Method
# pattern, if we change our mind about which subclass to use, we need to
# create a whole new subclass object just to switch to a different solution.

# The GoF call this “pull the algorithm out into a separate object” technique
# the Strategy pattern. The basic idea is to define a family of objects, the
# strategies, which all do the same thing — in our example, format the report.
# Not only each strategy object performs the same job, but all of them
# support exactly the same interface. In our example, both of the strategy
# objects support the output_report method. Given that all of the
# strategy objects look the same from the outside, the user of the strategy —
# called the context class by the GoF — can treat the strategies like
# interchangeable parts. Thus, it does not matter which strategy you use,
# because they all look the same and they use the same function.

# The Strategy pattern has some real pros. We can achieve better separation of
# concerns by pulling out a the strategies from a class. By using the Strategy
# pattern, we relieve the Report class of any responsibility for or knowledge
# of the report file format.

# When to Consider the Pattern
# - The only difference between related classes is behavior.
# - Behavior can be defined at runtime.
# - You find yourself using conditional statements to do “type checking”.
# - You want to get rid of hard-coded dependencies.

# The easiest way to go wrong with the Strategy pattern is to get the interface
# between the context and the strategy object wrong. Keep in mind that you are
# trying to tease an entire, consistent, and more or less self-contained job out
# of the context object and delegate it to the strategy. You need to pay
# attention to the details of the interface between the context and the strategy as
# well as to the coupling between them. Remember, the Strategy pattern will do you
# little good if you couple the context and your first strategy so tightly
# together that you cannot wedge a second or a third strategy into the design.

# Wrap up

# The Strategy pattern is a delegation-based approach to solving the same problem as
# the Template Method pattern. Instead of extracting the variable parts of your
# algorithm and pushing them down into subclasses, you simply implement each version
# of your algorithm as a separate object. You can then vary the algorithm by supplying
# different strategy objects to the context. We have more choices regarding how
# we get the data from the context object over to the strategy object. We can pass all
# of the data as parameters as we call methods on the strategy object, or we can simply
# pass a reference to the whole context object to the strategy.
# The Strategy pattern is similar to a few other patterns. For example, in the Strategy
# pattern we have an object — the context — that is trying to get something done.
# But to get that thing done, we need to supply the context with a second object — the
# strategy object — that helps get the thing done. Superficially, the Observer pattern
# works pretty much the same way: An object does something, but along the way it calls
# a second object, which we need to supply. The difference between these two patterns
# lies in their intent. The motivation behind the Strategy pattern is to supply the
# context with an object that knows how to perform some variation on an algorithm.
# The intent of the Observer pattern is pretty different.

# FIRST IMPLEMENTATION
class Report
  attr_reader :name, :text
  attr_accessor :formatter

  def initialize(formatter)
    @name = 'Weekly Report'
    @text = ['Things', 'are', 'going', 'well.']
    @formatter = formatter
  end

  def output_report
    @formatter.output_report(@name, @text)
  end
end

class Formatter
  def output_report(name, text)
    raise 'Abstract method called'
  end
end

class HTMLFormatter < Formatter
  def output_report(name, text)
    puts "<h1>#{name}</h1>"
    text.each do |line|
      puts "<p>#{line}<p>"
    end
  end
end

class PlainTextFormatter < Formatter
  def output_report(name, text)
    puts name
    text.each do |line|
      puts line
    end
  end
end

report = Report.new(HTMLFormatter.new)
report.output_report
# Because the Strategy pattern is based on composition and delegation,
# rather than on inheritance, it is easy to switch strategies at runtime.
# We simply swap out the strategy object:
report.formatter = PlainTextFormatter.new
report.output_report

# Second implemenation

# The first implementation is, however, is not Rubylike implementation,
# because the Formatter class does not actually do anything: It is simply
# there to define the common interface for the formatter subclasses. There is
# nothing wrong with this approach but this code runs counter to Ruby’s
# duck typing philosophy. The ducks would argue that HtmlFormatter and
# PlainTextFormatter already share a common interface because both
# implement the output_report method. Thus there is no need to artificially
# create a superclass which essentially does nothing.

# Passing data to strategies

# A real advantage of the Strategy pattern is that because the context and
# the strategy code are in different classes, a nice wall of data separation
# divides the two. The bad news is that we now need to figure a way to get
# the information that the context has but the strategy needs up and over that
# wall. We have essentially two choices here.

# First, we can continue with the approach that we have used so far—that is,
# pass in everything that the strategy needs as arguments when the context
# calls the methods on the strategy object. Passing in all of the data has
# the advantage of keeping the context and the strategy objects crisply
# separated. The strategies have their interface; the context simply uses
# that interface. The downside of doing things this way is that if there is
# a lot of complex data to pass between the context and the strategy, then,
# well, you are going to be passing a lot of complex data around without any
# guarantee that it will get used.

# Second, we can get the data from the context to the strategy by having the
# context object pass a reference to itself to the strategy object. The strategy
# object can then call methods on the context to get at the data it needs.
# Although this technique of passing the context to the strategy does simplify
# the flow of data, it also increases the coupling between the context and
# the strategy. This magnifies the danger that the context class and the strategy
# classes will get tangled up with each other.

class ReportImproved
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(formatter)
    @name = 'Weekly Report'
    @text = ['Things', 'are', 'going', 'well.']
    @formatter = formatter
  end

  def output_report
    # Here we are passing the object instead of name and text.
    formatter.output_report(self)
  end
end

class HTMLFormatterImproved
  def output_report(context)
    puts context.name
    context.text.each do |line|
      puts line
    end
  end
end

class PlainTextFormatterImproved < Formatter
  def output_report(context)
    puts context.name
    context.text.each do |line|
      puts line
    end
  end
end
