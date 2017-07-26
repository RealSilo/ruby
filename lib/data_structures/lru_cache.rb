class Node
  attr_accessor :data, :next_node, :prev_node

  def initialize(data)
    @data = data
    @next_node = nil
    @prev_node = nil
  end
end

class LruCache
  # Data structure to implement key-value caches with limited storage.
  # When the storage is full the least recently used (hence LRU) element
  # should be removed from the cache. We need a dobuly linked list as
  # underlying data structure since when we use the get method the node
  # has to be moved from the middle of the list to the end.

  attr_reader :store, :size, :head, :tail

  def initialize(max_items = 5)
    @max_items = max_items
    @store = {}
    @size = 0
    @head = nil
    @tail = nil
  end

  def set(key, value)
    @size += 1
    new_node = Node.new(value)

    if @size == 1
      @head = new_node
      @tail = new_node
      @store[key] = new_node
      return new_node
    end

    if @size > @max_items
      @head.next_node.prev_node = nil
      @head = @head.next_node
      @size -= 1
    end

    @tail.next_node = new_node
    new_node.prev_node = @tail
    @tail = new_node
    @store[key] = new_node
  end

  def get(key)
    result = @store[key]

    return nil unless result
    return result unless result.next_node
    
    if result.prev_node
      result.prev_node.next_node = result.next_node
      result.next_node.prev_node = result.prev_node
    else
      @head = result.next_node
      @head.prev_node = nil
    end

    @tail.next_node = result
    result.prev_node = @tail
    result.next_node = nil
    @tail = result

    result
  end
end

lru = LruCache.new(3)
lru.set('a', 1)
lru.set('b', 5)
lru.set('c', 3)
lru.get('a')
lru.set('d', 4)
# p lru.store
# p lru.tail.data
# p lru.tail.prev_node.data
# p lru.tail.prev_node.prev_node.data
# p lru.tail.prev_node.prev_node.prev_node
p lru.head.data
p lru.head.next_node.data
p lru.head.next_node.next_node.data
p lru.head.next_node.next_node.next_node
