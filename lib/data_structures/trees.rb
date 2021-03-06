require 'byebug'

class Trees
  class BinaryTree
    attr_accessor :root

    def initialize(root)
      @root = root
      @inorder_result = []
      @preorder_result = []
      @postorder_result = []
    end

    def insert_left(node, data)
      new_node = TreeNode.new(data)

      if node.left
        new_node.left, node.left = node.left, new_node
        node.left
      else
        node.left = new_node
      end
    end

    def insert_right(node, data)
      new_node = TreeNode.new(data)

      if node.right
        new_node.right, node.right = node.right, new_node
        node.right
      else
        node.right = new_node
      end
    end

    def inorder(node = @root)
      inorder(node.left) if node.left
      @inorder_result << node.data
      inorder(node.right) if node.right
    end

    def preorder(node = @root)
      @preorder_result << node.data
      preorder(node.left) if node.left
      preorder(node.right) if node.right
    end

    def postorder(node = @root)
      postorder(node.left) if node.left
      postorder(node.right) if node.right
      @postorder_result << node.data
    end

    def levelorder(start_node = @root)
      return nil if start_node.nil?

      result = []
      queue = []

      queue << start_node

      until queue.empty?
        node = queue.shift
        result << node.data

        queue << node.left if node.left
        queue << node.right if node.right
      end

      result
    end
  end

  class TreeNode
    attr_accessor :data, :parent, :left, :right

    def initialize(data, parent = nil, left = nil, right = nil)
      @data = data
      @parent = parent
      @left = left
      @right = right
    end

    def leaf?
      left.nil? && right.nil?
    end

    def has_both_children?
      left && right
    end

    def has_any_children?
      left || right
    end
  end

  class BinarySearchTree
    # keys that are less than the parent can be found in the left subtree, and
    # keys that are greater can be found in the right one

    # Worst case occurs when all the new values going to one side (values added
    # in order)

    # Algorithm   Average   Worst Case
    # Space       O(n)      O(n)
    # Search      O(log n)  O(n)
    # Insert      O(log n)  O(n)
    # Delete      O(log n)  O(n)

    # Good choice to store and manipulate ordered data
    # If we don’t anticipate that our list would be changing that often,
    # an ordered array would be a suitable data structure to contain our data.
    # If have to handle many changes in real time BSTs are better.
    # BSTs are a powerful node-based data structure that provides order
    # maintenance, while also offering fast search, insertion, and deletion.

    # Skip lists are more amenable to concurrent access/modification. The most
    # frequently used implementation of a binary search tree is a red-black tree.
    # The concurrent problems come in when the tree is modified it often needs to
    # rebalance. The rebalance operation can affect large portions of the tree,
    # which would require a mutex lock on many of the tree nodes. Inserting a node
    # into a skip list is far more localized, only nodes directly linked to the
    # affected node need to be locked.

    attr_accessor :size, :root

    def initialize(root = nil)
      @root = root
      @size = 0
    end

    def insert(data, node = @root)
      if @root
        insert_place(data, node)
      else
        @root = TreeNode.new(data)
      end

      @size += 1
    end

    def find(data, node = root)
      return nil unless node

      if node.data == data
        node
      elsif node.data > data
        find(data, node.left)
      elsif node.data < data
        find(data, node.right)
      end
    end

    def delete(data)
      delete_place(data, @root)
    end

    def find_min(node)
      current = node
      current = current.left while current.left
      current.data
    end

    def find_max(node)
      current = node
      current = current.right while current.right
      current.data
    end

    def min_height(node = @root)
      return -1 if node.nil?

      left = min_height(node.left)
      right = min_height(node.right)

      if left < right
        left + 1
      else
        right + 1
      end
    end

    def max_height(node = @root)
      return -1 if node.nil?

      left = max_height(node.left)
      right = max_height(node.right)

      if left < right
        right + 1
      else
        left + 1
      end
    end

    def balanced?
      min_height >= max_height - 1
    end

    def levelorder(start_node = @root)
      return nil if start_node.nil?

      result = []
      queue = []

      queue << start_node

      until queue.empty?
        node = queue.shift
        result << node.data

        queue << node.left if node.left
        queue << node.right if node.right
      end

      result
    end

    private

    def insert_place(data, node, parent = nil)
      if data < node.data
        if node.left
          insert_place(data, node.left, node)
        else
          node.left = TreeNode.new(data, node)
        end
      else
        if node.right
          insert_place(data, node.right, node)
        else
          node.right = TreeNode.new(data, node)
        end
      end
    end

    def delete_place(data, node = @root, parent = nil)
      return nil unless node

      if data < node.data
        delete_place(data, node.left, node)
      elsif data > node.data
        delete_place(data, node.right, node)
      else
        if node.left && node.right
          # if there are both left and right children the data is replaced with the
          # min value of the right branch then the node with that value is deleted
          node.data = find_min(node.right)
          delete_place(node.data, node.right, node)
        elsif node == root
          # if there is only left child => node removed and replaced with node.left
          # if there is only right child => node removed and replaced with node.right
          # it's good because the reference to the parent is untouched
          # if there is no left/right child it's simply set to null
          node = node.left || node.right
          self.root = node
        else
          node = node.left || node.right
          # Since when you reassign a variable in Ruby the reference gets lost, so
          # the parent's children has to be set manually
          parent.left.data == data ? parent.left = node : parent.right = node
        end

        @size -= 1
      end
      # We have to return the node to be able to handle the references.
      # When calling the function recursively the last call (which doesn't call
      # the function again) will set node to node.left || node.right then sends
      # back that node to the last recursive call so the reference is still working.
      node
    end
  end

  bst = BinarySearchTree.new
  bst.insert(20)
  bst.insert(10)
  bst.insert(30)
  bst.insert(25)
  bst.insert(40)
  bst.insert(35)
  bst.insert(50)
  # bst.find(50)
  bst.delete(10)
  p bst.root
  p bst.root.left
  p bst.root.right
  bst.delete(20)
  p bst.root

  # PROBLEM 1:
  # Given a binary tree check if it's binary search tree

  # Traversal is O(n) complexity
  # this only works with no duplicates
  def self.inorder_for_check(node, nodes = [])
    if node
      inorder_for_check(node.left, nodes)
      nodes << node.data
      raise 'not in order' unless nodes[nodes.length - 2] <= nodes[nodes.length - 1]
      inorder_for_check(node.right, nodes)
    end
    nodes
  end

  p inorder_for_check(bst.root)

  # PROBLEM 2
  # Trim a binary search tree based on min and max values:
  # gt = BinarySearchTree.new
  # gt.insert('10', 10)
  # gt.insert('30', 30)
  # gt.insert('5', 5)
  # gt.insert('15', 15)
  # p gt

  def self.trim_tree(tree, min, max)
    return nil unless tree

    tree.left = trim_tree(tree.left, min, max)
    tree.right = trim_tree(tree.right, min, max)

    return true if min <= tree.data && tree.data <= max
    return tree.right if tree.data < min
    return tree.left if tree.data > max
  end

  # p bst
  # self.trim_tree(bst.root, 2, 10)
  # p bst

  # PROBLEM3: Given a sorted (increasing order) array with unique integer
  # elements, write an algorithm to create a binary search tree with minimal
  # height.

  def balanced_binary_with_sorted_array(arr, min, max)
    return nil if min > max
    mid = (min + max) / 2
    # Always passes the next middle as next root, so the tree stays balanced.
    root = TreeNode.new(arr[mid])
    root.left = balanced_binary_with_sorted_array(arr, min, mid - 1)
    root.right = balanced_binary_with_sorted_array(arr, mid + 1, max)
    root
  end

  # arr = [1, 3, 4, 8, 12, 15, 20, 32, 40]
  # p Trees.new.balanced_binary_with_sorted_array(arr, 0, arr.length - 1)

  # PROBLEM4: Given a binary tree, design an algorithm which creates a linked
  # list of all the nodes at each depth (e.g., if you have a tree with depth D,
  # you'll have D linked lists).
  class LinkedTreeNode
    attr_accessor :data, :left, :right, :next_node

    def initialize(data, left = nil, right = nil, next_node = nil)
      @data = data
      @left = left
      @right = right
      @next_node = next_node
    end
  end

  def level_order_linked_list(node)
    queue = []
    queue << node
    prev = nil

    until queue.empty?
      temp_queue = []
      prev = nil

      queue.each do |vertex|
        temp_queue << vertex.left if vertex.left
        temp_queue << vertex.right if vertex.right
        prev&.next_node = vertex
        prev = vertex
      end

      queue = temp_queue
    end

    node
  end

  # n = LinkedTreeNode.new(20)
  # n.left = LinkedTreeNode.new(10)
  # n.right = LinkedTreeNode.new(30)
  # n.left.left = LinkedTreeNode.new(5)
  # n.left.right = LinkedTreeNode.new(15)
  # n.right.left = LinkedTreeNode.new(25)
  # n.right.right = LinkedTreeNode.new(35)
  # n = Trees.new.level_order_linked_list(n)
  # puts n.next_node == nil
  # puts n.right.next_node == nil
  # puts n.left.next_node.data
  # puts n.left.left.next_node.data
end
