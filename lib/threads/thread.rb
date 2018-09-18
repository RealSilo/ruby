# EXAMPLE 1
# puts 'first'
# thread = Thread.new do
#   puts 'second/third (from spawned thread)'
#   puts 'third/fourth (from spawned thread)'
# end
# puts 'second/third/fourth'
# thread.join
# puts 'last'


# EXAMPLE 2

# thread = Thread.new do
#   raise 'hell'
# end
# # simulate work, the exception is unnoticed at this point
# sleep 3
# # this will re-raise the exception in the current thread
# thread.join


# # EXAMPLE 3

# thread = Thread.new do
#   # Here this thread checks its own status. Thread.current.status #=> 'run'
#   2 * 3
# end

# puts thread.status #=> 'run'
# thread.join
# puts thread.status #=> false

# EXAMPLE 4

# shared_array = Array.new

# 10.times.map do
#   Thread.new do
#     1000.times do
#       shared_array << nil
#     end
#   end
# end.each(&:join)
# puts shared_array.size

# shared_counter = 0

# 100.times.map do
#   Thread.new do
#     sleep [0.01, 0.1].sample
#     shared_counter += 1
#   end
# end.each(&:join)
# puts shared_counter

# shared_counter_2 = 0

# 100.times.map do
#   Thread.new do
#     if shared_counter_2 == 50
#       shared_counter_2 += 2
#     else
#       shared_counter_2 += 1
#     end
#   end
# end.each(&:join)
# puts shared_counter_2

# EXAMPLE 5

Order = Struct.new(:amount, :status) do
  def pending?
    status == 'pending'
  end

  def collect_payment
    puts "Collecting payment..."
    self.status = 'paid'
  end
end

order1 = Order.new(100.00, 'pending')

5.times.map do
  Thread.new do
    if order1.pending?
      order1.collect_payment
    end
  end
end.each(&:join)

# order2 = Order.new(100.00, 'pending')
# mutex = Mutex.new
# puts 'Mutex version'

# 5.times.map do
#   Thread.new do
#     mutex.lock
#     if order2.pending?
#       order2.collect_payment
#     end
#     mutex.unlock
#   end
# end.each(&:join)


