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

  def print(node = @root)
    collect(node, '')
    @words
  end

  private

  def collect(node, string)
    if node.hash.size > 0
      for letter in node.hash.keys
        string = string.concat(letter)
        collect(node.hash[letter], string.clone)
      end

      @words << string if node.end_node?
    else
      string.length > 0 ? @words << string : nil
    end 
  end
end

trie = Trie.new
trie.add('peter', date: '1988-02-26')
trie.add('petra', date: '1977-02-12')
trie.add('danny', date: '1998-04-21')
trie.add('jane', date: '1985-05-08')
trie.add('jack', date: '1994-11-04')
trie.add('pete', date: '1977-12-18')
print trie.print
