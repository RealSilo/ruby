#GOF

# A proxy, in its most general form, is a class functioning as an interface
# to something else. The proxy could interface to anything: a network connection,
# a large object in memory, a file, or some other resource that is expensive or
# impossible to duplicate. In short, a proxy is a wrapper or agent object that
# is being called by the client to access the real serving object behind the
# scenes. Use of the proxy can simply be forwarding to the real object, or can
# provide additional logic (for example caching when operations on the real
# object are resource intensive, or checking preconditions before operations 
# on the real object are invoked). For the client, usage of a proxy object is
# similar to using the real object, because both implement the same interface.

# PROXY PATTERN

# When the client asks us for an object—perhaps the object we do indeed give the
# client back an object. However, the object that we give back is not quite the
# object that the client expected. What we hand to the client is an object that
# looks and acts like the object the client expected, but is actually an
# imposter. The proxy has a reference to the real object, the subject, that is
# hidden inside. Whenever the client code calls a method on the proxy, the proxy
# simply forwards the request to the real object.

# WARP UP

# Proxies are the con artists of the programming world: They pretend to be some
# other object when they are not, in fact, that object. Inside the proxy is hidden
# a reference to the other, real object — an object that the GoF referred to as
# the subject.

# Nevertheless, the proxy does not just act as a method call conduit for the subject.
# Instead, it serves as a pinch point between the client and the subject in other
# words the proxy controls access to the subject.

# Superficially, the proxy is very similar to the adapter: One object stands in for
# another. But the proxy does not change the interface; the interface of the proxy is
# exactly the same as the interface of its subject. Instead of trying to transform
# the interface of that inner object in the same way that an adapter does, the proxy
# tries to control access to it.

class BankAccount
  attr_reader :balance
  def initialize(starting_balance = 0)
    @balance = starting_balance
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end
end

# Implementation for authorization

# Clearly, we could have included the checking code in the BankAccount object itself.
# The advantage of using a proxy for protection is that it gives us a nice separation
# of concerns: The proxy worries about who is or is not allowed to do what. The only
# thing that the real bank account object need be concerned with is, well, the bank
# account. By implementing the security in a proxy, we make it easy to swap in a
# different security scheme (just wrap the subject in a different proxy) or eliminate
# the security all together (just drop the proxy). For that matter, we can also change
# the implementation of the BankAccount object without messing with our security scheme.

class BankAccountProtectionProxy
  def initialize(bank_account, owner)
    @bank_account = bank_account
    @owner = owner
  end

  def balance
    check_access
    @bank_account.balance
  end

  def deposit(amount)
    check_access
    @bank_account.deposit(amount)
  end
  
  def withdraw(amount)
    check_access
    @bank_account.withdraw(amount)
  end

  private

  def check_access
    raise 'No access granted' unless @owner[:status] === :valid
  end
end

ba = BankAccountProtectionProxy.new(BankAccount.new(100), { name: 'Peter Jones', status: :valid })
ba.withdraw(20)
puts ba.balance

# We can use a proxy to delay creating expensive objects until
# we really need them. We do not want to create the real
# BankAccount until the user is ready to do something with it,
# such as making a deposit. But we also do not want to spread
# the complexity of that delayed creation out over all the
# client code. The answer is to use yet another flavor of proxy,
# the virtual proxy.

# First Implementation to delay creating expensive objects.

# One drawback of the VirtualAccountProxy implementation is that
# the proxy is responsible for creating the bank account object.
# That approach tangles the proxy and the subject up a little
# more than we might like.

class VirtualBankAccountProxy
  def initialize(starting_balance)
    @starting_balance = starting_balance
  end

  def balance
    subject.balance
  end

  def deposit(amount)
    subject.deposit(amount)
  end
  
  def withdraw(amount)
    subject.withdraw(amount)
  end

  private

  def subject
    @subject ||= BankAccount.new(@starting_balance)
  end
end

acc = VirtualBankAccountProxy.new(100)
acc.deposit(50)
puts acc.balance

# Second Implementation to delay creating expensive objects.

# Metaprogramming (define methd / method missing) could be
# used to clean up the class. 

class VirtualBankAccountProxyImproved
  def initialize(&bank_account_block)
    @bank_account_block = bank_account_block
  end

  def balance
    subject.balance
  end

  def deposit(amount)
    subject.deposit(amount)
  end
  
  def withdraw(amount)
    subject.withdraw(amount)
  end

  private

  def subject
    @subject ||= @bank_account_block.call
  end
end

account = VirtualBankAccountProxyImproved.new { BankAccount.new(300) }
account.withdraw(50)
puts account.balance
