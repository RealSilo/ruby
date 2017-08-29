require 'byebug'
# PROBLEM 1: Flip Bit to Win
# You have an integer and you can flip exactly one bit from a 0 to a 1. Write
# code to finnd the length of the longest sequence of ls you could create.
# 1775 (or: 11011101111) => 8 
def flip_bit(integer)
  binary = integer.to_s(2)
  max = 0
  current = 0
  prev = 0

  binary.each_char do |char|
    if char == '1'
      current += 1
    elsif char == '0'
      prev = current
      current = 0
    end
    max = [prev + current + 1, max].max
  end
  max
end

flip_bit(1775)

# PROBLEM2: Next Number
# Given a positive integer, print the next smallest and the next largest number
# that have the same number of 1 bits in their binary representation.
def next_number(integer)
  binary = integer.to_s(2)

  trailing_zero = false
  flipping_slot = nil
  ones = 0

  (binary.length - 1).downto(0) do |i|
    if binary[i] == '1'
      ones += 1
    elsif binary[i] == '0' && trailing_zero
      trailing_zero = true if ones >= 1
      binary[i] = '1'
      flipping_slot = i
      break
    end
  end

  if trailing_zero == false
    binary.prepend('1')
    flipping_slot = 0
  end

  x = 0
  (flipping_slot + 1).upto(binary.length - 1) do |j|
    if binary[j] == '1'
      x += 1
      binary[j] = '0'
    end
  end

  (binary.length - 1).downto(binary.length - x + 1) do |k|
    binary[k] = '1'
  end

  binary.to_i(2)
end

p next_number(12)

# PROBLEM3: Write a function to determine the number of bits you would need to
# flip to convert integer A to integer B.
# 29 (or: 11101), 15 (or: 01111) => 2

def number_of_flipping_slots(integer1, integer2)
  (integer1 ^ integer2).to_s(2).count('1')
end

number_of_flipping_slots(29, 15)
