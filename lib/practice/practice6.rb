class RollableStack
	attr_reader :stack, :rollback_stack, :buffer
	def initialize
		stack = []
		rollback_stack = []
		buffer = []
	end

	def begin_transaction(value)
		buffer.push(value)
	end

	def rollback
		rollback_stack.push(stack.pop) if stack.any?
	end

	def roll_forward
		stack.push(rollback_stack.pop) if rollback_stack.any?
	end

	def commit
		stack.push(buffer.shift) while buffer.any?
	end
end

def push_zeros_to_right(arr)
	last_zero_index = arr.length - 1

	arr.each_with_index do |element, i|
		break if i >= last_zero_index
		next unless element == 0
		arr[i], arr[last_zero_index] = arr[last_zero_index], arr[i]
		last_zero_index -= 1
	end

	arr
end

p push_zeros_to_right([2, 0, 1, 4, 0, 3, 5, 5])
