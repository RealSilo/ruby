# You have a complex bit of code — perhaps with an involved
# algorithm or just some complex system code or maybe something
# just hard enough that you want to code it once, write some unit
# tests, and leave it alone. The trouble is that right in the
# middle of your complex code is a part that needs to vary.
# Sometimes this bit of code should to do this and sometimes it should
# to do that. Even worse, you are sure that in the future the
# code will need to something else.

# Solution:
# Define an abstract base class with a master method that performs
# the basic steps listed above, but leaves the details (implementation)
# of each step to the subclasses.

# The basic idea of the Template Method pattern is to create an abstract
# base class with a skeletal method. This skeletal method (also called a
# template method) leads the bit of the processing that needs to vary
# (serves as an outline of the steps needed to complete the task),
# but it does so by making calls to abstract methods, which are then
# implemented in the concrete subclasses. We pick the variation that we
# want by calling one of those concrete subclasses.

# If we do all the tasks correctly, we will end up separating the stuff
# that stays the same (the basic algorithm implemented in the template
# method) from the things that changes (the details implemented in the
# subclasses).

# Base class can supply a default implementation of the methods for the
# convenience of its subclasses. These non-abstract methods that can be
# overridden in the concrete classes of the Template Method pattern are
# called hook methods. Hook methods allow the concrete classes to choose
# to override the base implementation and do something different or to
# simply use the default implementation. Usually, the base class will
# define hook methods to let the subclass know what is going on.

# This pattern is useful anytime you have an algorithm that has one or
# more steps that need to vary, or when you have a couple algorithms that
# are very nearly the same but differ by just a step or two.

# The worst mistake you can make is to overdo things in to cover every
# unforseen possibility. The Template Method pattern is great when it is
# at its leanest—that is, when every abstract method and hook is there
# for a reason. Avoid creating a template class that requires each
# subclass to override a huge number of obscure methods just to cover
# every conceivable option. You also do not want to create a templateclass
# that is encrusted with a bunch of hook methods that no one will ever
# override. Don’t use this pattern just because you think part of an
# algorithm might one day need to change (that day never comes). Just
# start with a concrete class and, if a new requirement ever actually
# arrives, only then consider breaking out the implementation into abstract
# and concrete classes.

# The Template Method helps us seperate code that changes from code that
# doesn’t. It helps us keep our concerns cleanly separated, and makes
# future change easier and safer. On the other hand, the inheritance on
# which this pattern relies can be a sledge hammer. Be cautious about
# exactly when you use this pattern, especially in cases where composition
# is available instead. Additionally, if there are multiple parts of the
# algorithm that need to change the number of concrete subclasses can
# quickly get out of hand.

# WRAP UP

# The Template Method pattern is simply a fancy way of saying that if you
# want to vary an algorithm, one way to do so is to code the invariant part
# in a base class and to encapsulate the variable parts in methods that are
# defined by a number of subclasses. The base class can simply leave the
# methods completely undefined—in that case, the subclasses must supply the
# methods. Alternatively, the base class can provide a default implementation
# for the methods that the subclasses can override if they want.

# The Template Method pattern is a basic OO technique that it pops up in
# other patterns. For example, the Factory Method pattern is simply
# the Template Method pattern applied to creating new objects. The problem
# that the Template Method pattern tackles is also widely pervasive.
# The Strategy pattern which offers a different solution to the same
# problem is a solution that does not use inheritance in the same way
# that the Template Method pattern does.

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

class ReportTemplate
  def generate_report!
    retrieve_financial_data
    format_report
    send_report
  end

  private

  def retrieve_financial_data
    # Grab relevant data from our database
  end

  def format_report
    raise NotImplementedError
  end

  def send_report
    # email this report to interested parties
  end
end

class TextReport < ReportTemplate
  def format_report
    # arrange financial data into plain text report
  end
end

class HTMLReport < ReportTemplate
  def format_report
    # arrange financial data into HTML report
  end
end

report = TextReport.new
# or
report = HTMLReport.new
# then
report.generate_report!
