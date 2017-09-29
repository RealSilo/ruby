# It's pretty similar to the decorator pattern, but while the decorator pattern
# is a structural pattern, the COR is a behavioral pattern. Structural design
# patterns generally deal with the structure of the entities and the relationships
# between them, making it easier for these entities to work together. Behavioral
# design patterns focus on communication. How do we let the interested parties
# know any changes to the object. Sort of publisher to subscriber. Does not care
# about the data structure, but forces on implementing methods, i.e. channels of
# communications. The key difference is that a decorator adds new behavior, while
# COR pattern can modify an existing behavior. Decorator is used when you want to
# add functionality to an object. COR is used when one of many actors might take
# action on an object.

# GoF definition:
# Avoid coupling the sender of a request to its receiver by giving more than one
# object a chance to handle the request. Chain the receiving objects and pass the
# request along the chain until an object handles it.

# The object that made the request has no explicit knowledgeof who will handle
# it—we say the request has an implicit receiver.
class PurchaseRequest
  attr_reader :amount

  def initialize(amount)
    @amount = amount
  end
end

class PurchaseApprover
  attr_reader :successor

  def initialize(successor: nil)
    @successor = successor
  end

  def process_request(request)
    if approve_request?(request)
      return
    elsif successor
      successor.process_request(request)
    else
      deny_request(request)
    end
  end

  def deny_request(request)
    puts 'This purchase cannot be approved'
  end
end

class AmountApprover < PurchaseApprover
  attr_reader :members
  BASE_AMOUNT = 100

  def initialize(members: [], successor: nil)
    @members = members
    @successor = successor
  end

  def approve_request?(request)
    members.each do |member|
      if request.amount < member.max_amount
        puts "#{member.class} approved the amount."
        return true
      else
        puts "#{member.class} didn't approve the amount."
      end
    end
    false
  end
end

class Employee < AmountApprover
  def max_amount
    BASE_AMOUNT
  end
end

class Manager < AmountApprover
  def max_amount
    BASE_AMOUNT * 10
  end
end

class Director < AmountApprover
  def max_amount
    BASE_AMOUNT * 100
  end
end

class VP < AmountApprover
  def max_amount
    BASE_AMOUNT * 1000
  end
end

class BudgetApprover < PurchaseApprover
  CURRENT_MONEY = 300_000

  def approve_request?(request)
    if request.amount < CURRENT_MONEY
      puts 'Your request is within the budget but you need to ask the CFO.'
      true
    else
      puts 'Your request is more than the current budget.'
      false
    end
  end
end

chain_of_responsibility = AmountApprover.new(
  members: [
    Employee.new,
    Manager.new,
    Director.new,
    VP.new
  ],
  successor: BudgetApprover.new
)

chain_of_responsibility.process_request(PurchaseRequest.new(200_000))
