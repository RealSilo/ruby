require 'byebug'
# O1(insert, search, delete)
# internallay it's an array => uses hash function/ divison to fit data into an array

# good hash function is easy to compute and evenly distributes the items in the table

# collision resolutions:
# - separate chaining (elements are put in an array / linked list if their key are
# mapped to the same hash key (integer))
# - linear probing (If the hash key (n) is already taken put the element to the n+1
# or n+2, etc. empty hash key)

# Main reason to use hash tables over red-black BST is better performance
# in practice on typical inputs.

class Hashes
  attr_accessor :storage
  attr_reader :storage_limit

  def initialize(storage_limit = 10)
    @storage = []
    @storage_limit = storage_limit
  end

  def hash(key)
    hash_value = 0

    key.each_char do |char|
      hash_value += char.ord
    end

    hash_value % storage_limit
  end

  def add(key, value)
    index = hash(key)

    if storage[index]
      inserted = false

      storage[index].each do |element|
        if element[0] == key
          element[1] = value
          inserted = true
        end
      end

      storage[index].push([key, value]) if inserted == false
    else
      storage[index] = [[key, value]]
    end
  end

  def remove(key)
    index = hash(key)

    return nil unless storage[index]

    if storage[index].length == 1 && storage[index][0][0] == key
      storage[index].shift
    else
      storage[index].each_with_index do |element, i|
        storage[index].delete_at(i) if element[0] == key
      end
    end
  end

  def find(key)
    index = hash(key)

    return nil unless storage[index]

    storage[index].each do |element|
      return element[1] if element[0] == key
    end
  end
end

h = Hashes.new
h.add('Eterp', 4)
h.add('Peter', 5)
h.add('Retep', 3)
h.add('John', 2)
h.remove('John')
h.add('John', 1)
puts h.find('Peter')
h.remove('Peter')
print h.storage
