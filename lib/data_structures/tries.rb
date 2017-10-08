require 'byebug'
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
  attr_reader :root

  def initialize
    @root = Node.new
    @words = []
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
    return nil unless node

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

  def find_with_str(term = '', node = @root)
    @words = []
    collect_with_str(node, term.length, '', term)
    @words
  end

  private

  def collect_with_str(node, term_length, string, term = '')
    if node && node.hash.any?
      if term.empty?
        node.hash.each_key do |letter|
          new_string = string.clone + letter
          collect_with_str(node.hash[letter], term_length, new_string)
        end
      else
        new_string = string + term[0]
        collect_with_str(node.hash[term[0]], term_length, new_string, term[1..-1])
      end

      # when it comes back from the recursion middle words get added
      # if it's an end node and the term is shorter
      if node.end_node && string.length >= term_length
        @words.push("#{string}": node.data)
      end
    elsif node
      # we know it's an endpoint since it's a leaf, but we have tocheck if it's
      # not root or it's not shorter than the term
      unless string.empty? || string.length < term_length
        @words.push("#{string}": node.data)
      end
    end
  end

  def collect(node, string)
    if node.hash.empty?
      string.empty? ? nil : @words << string
    else
      node.hash.each_key do |letter|
        new_string = string.clone + letter
        collect(node.hash[letter], new_string)
      end

      @words << string if node.end_node?
    end
  end
end

ttrie = Trie.new
ttrie.add('hackerrank', date: '1988-02-26')
ttrie.add('hack', date: '1977-02-12')
ttrie.add('danny', date: '1998-04-21')
ttrie.add('jane', date: '1985-05-08')
ttrie.add('jack', date: '1994-11-04')
ttrie.add('pete', date: '1977-12-18')
p ttrie.find_with_str('hack')
p ttrie.find_with_str('hak')
p ttrie.find_with_str('hacker')
p ttrie.find_with_str('he')
p ttrie.print_all

birth_data_date = {
  '1985': [
    { 'Peter': { 'birthplace': 'Baltimore', 'hospital': 'St Mary' } },
    { 'Tom': { 'birthplace': 'Chicago', 'hospital': 'St Stephen' } },
    { 'Andy': { 'birthplace': 'Washington', 'hospital': 'St Stephen' } },
    { 'John': { 'birthplace': 'San Francisco', 'hospital': 'UCSF Medical Center' } }
  ],
  '1986': [
    { 'Jack': { 'birthplace': 'New Jersey', 'hospital': 'General Hospital' } },
    { 'Tom': { 'birthplace': 'Washington', 'hospital': 'St Stephen' } },
    { 'Steven': { 'birthplace': 'Indianapolis', 'hospital': 'City Hospital' } },
    { 'Jack': { 'birthplace': 'Dallas', 'hospital': 'Dallas City Hospital' } }
  ],
  '1987': [
    { 'David': { 'birthplace': 'Pittsburgh', 'hospital': 'Pittsburgh Hospital' } },
    { 'Michael': { 'birthplace': 'Los Angeles', 'hospital': 'UCLA Medical Center' } },
    { 'Brad': { 'birthplace': 'New Jersey', 'hospital': 'General Hospital' } },
    { 'David': { 'birthplace': 'Kansas City', 'hospital': 'Kanas State Hospital' } }
  ],
  '1988': [
    { 'Peter': { 'birthplace': 'Boston', 'hospital': 'St Peter' } },
    { 'Tom': { 'birthplace': 'Pittsburgh', 'hospital': 'Pittsburgh Hospital' } },
    { 'Pete': { 'birthplace': 'Green Bay', 'hospital': 'Green Bay Hospital' } }
  ],
  '1989': [
    { 'Donald': { 'birthplace': 'San Francisco', 'hospital': 'UCSF Medical Center' } },
    { 'Tom': { 'birthplace': 'Miami', 'hospital': 'Florida State Hospital' } },
    { 'Aaron': { 'birthplace': 'Seattle', 'hospital': 'Seattle Medical Center' } },
    { 'Aaron': { 'birthplace': 'Chicago', 'hospital': 'St Stephen' } },
    { 'Pete': { 'birthplace': 'Denver', 'hospital': 'Hopkins Hospital' } }
  ]
}

birth_data_name = {}

birth_data_date.each do |key, value|
  value.each do |hash|
    hash.each do |k, v|
      v[:date] = key.to_s
      if birth_data_name[k.to_s]
        birth_data_name[k.to_s] << v
      else
        birth_data_name[k.to_s] = [v]
      end
    end
  end
end

puts birth_data_name['Peter']

trie = Trie.new

birth_data_name.each do |k, v|
  trie.add(k, v)
end

p trie.find_with_str('Peter')
p trie.find_with_str('Pet')
