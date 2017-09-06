# Very commonly, a trie is used to store the entire (English) language for quick
# pre x lookups. While a hash table can quickly look up whether a string is a
# valid word, it cannot tell us if a string is a pre x of any valid words. A trie
# can do this very quickly.

# A trie can check if a string is a valid pre x in 0(K) time, where K is the
# length of the string. This is actually the same runtime as a hash table will
# take. Although we often refer to hash table lookups as being 0(1) time, this
# isn't entirely true. A hash table must read through all the characters in the
# input, which takes O(K) time in the case of a word lookup.

# Many problems involving lists of valid words leverage a trie as an optimization.
# In situations when we search through the tree on related pre xes repeatedly
# (e.g., looking up M, then MA, then MAN, then MANY), we might pass around a
# reference to the current node in the tree. This will allow us to just check if
# Y is a child of MAN, rather than starting from the root each time.

class Node
  attr_accessor :hash, :end_node, :data

  def initialize
    @hash = {}
    @end_node = false
    @data = data
  end

  def end_node?
    end_node
  end
end

class Trie
  def initialize
    @root = Node.new
    @words = []
    @string = ''
  end

  def add(input, data, node = @root)
    if input.empty?
      node.data = data
      node.end_node = true
    elsif node.hash.keys.include?(input[0])
      add(input[1..-1], data, node.hash[input[0]])
    else
      node.hash[input[0]] = Node.new
      add(input[1..-1], data, node.hash[input[0]])
    end
  end

  def find(input, node = @root)
    if input.empty? && node.end_node?
      return node.data
    elsif input.empty?
      return nil
    end

    find(input[1..-1], node.hash[input[0]])
  end

  def word?(input)
    node = @root

    until input.length == 1
      return false unless node.hash.keys.include?(input[0])
      node = node.hash[input[0]]
      input = input[1..-1]
    end

    return true if node.hash.keys.include?(input[0]) && node.hash[input[0]].end_node?
    false
  end

  def print_all(node = @root)
    collect(node, '')
    @words
  end

  def find_with_str(word = '', node = @root)
    matches = []
    collect_with_str(node, '', word)
    matches << @words
    @words = []
    matches
  end

  private

  def collect_with_str(node, string, word = '')
    if node && node.hash.any?
      if word.empty?
        node.hash.each_key do |letter|
          new_string = string + letter
          collect_with_str(node.hash[letter], new_string)
        end
      else
        new_string = string + word[0]
        collect_with_str(node.hash[word[0]], new_string, word[1..-1])
      end

      @words.push("#{string}": node.data) if node.end_node
    elsif node
      @words.push("#{string}": node.data) unless string.empty?
    end
  end

  def collect(node, string)
    if node.hash.empty?
      string.empty? ? nil : @words << string
    else
      node.hash.each_key do |letter|
        new_string = string + letter
        collect(node.hash[letter], new_string)
      end

      @words << string if node.end_node?
    end
  end
end

trie = Trie.new
trie.add('hackerrank', date: '1988-02-26')
trie.add('hack', date: '1977-02-12')
# trie.add('danny', date: '1998-04-21')
# trie.add('jane', date: '1985-05-08')
# trie.add('jack', date: '1994-11-04')
# trie.add('pete', date: '1977-12-18')
p trie.find_with_str('hack')
p trie.find_with_str('hak')
p trie.find_with_str('hacker')
# p trie.find_with_str('he')
p trie.print_all
p trie.find('hack')
