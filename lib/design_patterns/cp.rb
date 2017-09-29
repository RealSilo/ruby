class PurchaseApprover
  # Implements the chain of responsibility pattern. Does not know anything
  # about the approval process, merely whether the current handler can approve
  # the request, or must pass it to a successor.
  attr_reader :successor

  def initialize successor
    @successor = successor
  end

  def process_request request
    if approve_request request
      return
    elsif successor
      successor.process_request request
    else
      deny_request request
    end
  end

  # This may be overridden by a handler if it wants to provide a custom action
  # when it is the last member of the chain
  def deny_request request
    puts "Your request for $#{request.amount} needs a board meeting!"
  end
end

class AmountApprover < PurchaseApprover
  # Base class for approvers who only consider whether the request amount is
  # allowable
  BASE = 500

  def approve_request request
    if request.amount < self.class::ALLOWABLE
      print_approval request
      return true
    else
      return false
    end
  end
end

class Manager < AmountApprover
  ALLOWABLE = 10 * BASE

  def print_approval request
    puts "Manager will approve $#{request.amount}"
  end
end

class Director < AmountApprover
  ALLOWABLE = 20 * BASE

  def print_approval request
    puts "Director will approve $#{request.amount}"
  end
end

class VicePresident < AmountApprover
  ALLOWABLE = 40 * BASE

  def print_approval request
    puts "VicePresident will approve $#{request.amount}"
  end
end

class President < AmountApprover
  ALLOWABLE = 60 * BASE

  def print_approval request
    puts "President will approve $#{request.amount}"
  end
end

class CFO < PurchaseApprover
  # An example of a handler that does not inherit from AmountApprover
  #
  # Try adding it to the chain by implementing an annual budget that tracks the
  # total of all approved requests so far and whether we can afford one more.
  def approve_request request
    if within_annual_budget? request
      puts "CFO will approve $#{request.amount}"
      return true
    else
      return false
    end
  end

  def within_annual_budget? request
    # ...
  end
end

class PurchaseRequest
  attr_reader :amount

  def initialize(number, amount, purpose)
    @number = number
    @amount = amount
    @purpose = purpose
  end
end

class CLP
  def initialize(*approvers)
    approvers = build_approvers(approvers)
    @authority = approvers.first
  end

  def process_request request
    @authority.process_request request
  end

  private

  def build_approvers(approver_classes)
    hey = [].tap do |approvers|
      approver_classes.reverse.inject(nil) do |successor, approver|
        approver.new(successor).tap {|approver| approvers.unshift approver }
      end
    end
    print hey
    hey
  end
end

# main program
# ------------

approvers = CLP.new(Manager, Director, VicePresident, President)

loop do
  $stdout.flush
  puts
  puts "Enter the amount to check who should approve your expenditure."
  print ">> "
  amount = gets.to_i
  approvers.process_request PurchaseRequest.new(0, amount, 'General')
end
