require 'byebug'
# O1(insert, search, delete)
# internallay it's an array => uses hash function/ divison to fit data into an array

# good hash function is easy to compute and evenly distributes the items in the table

class Hashes
#   class Node
#     def initialize(value, next_node)
#       @value = value
#       @next_node = next_node
#       @first = nil
#     end
#   end

#   class MyHash
#     def initialize(length = 11)
#       @length = length
#       @store = Array.new(@length, [])
#       @store.first << nil
#     end

#     def [](key)
#       get(key)
#     end

#     def []=(key, value)
#       set(key, value)
#     end

#     def get(key)
#       hash_value = hash_function(key)
#       my_cell = @store[hash_value].select { |cell| cell[0] == key }
#       debugger
#       my_cell[0][-1]
#     end

#     def set(key, value)
#       debugger
#       hash_value = hash_function(key)
#       # ins_arr_length = @store[hash_value].length
#       @store[hash_value] << Node.new([key, value], @first)
#     end

#     def hash_function(key)
#       key.object_id % @length
#     end

#     hsh = MyHash.new
#     hsh[1] = 'haha'
#     puts hsh[1]
#     debugger
#   end
end
