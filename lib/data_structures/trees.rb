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

    attr_reader :size, :root

    def initialize
      @root = nil
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

    def find(data)
      return nil unless @root
      find_place(data, @root)
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

    def find_place(data, node)
      return nil unless node

      if node.data == data
        node
      elsif node.data > data
        find_place(data, node.left)
      elsif node.data < data
        find_place(data, node.right)
      end
    end

    def insert_place(data, node)
      if data < node.data
        if node.left
          insert_place(data, node.left)
        else
          node.left = TreeNode.new(data)
        end
      else
        if node.right
          insert_place(data, node.right)
        else
          node.right = TreeNode.new(data)
        end
      end
    end

    def delete_place(data, node)
      return nil if node.nil?

      if data < node.data && node.left
        node.left = delete_place(data, node.left)
      elsif data > node.data && node.right
        node.right = delete_place(data, node.right)
      elsif data == node.data
        if node.left && node.right
          # if there are both left and right children the data is replaced with the
          # min value of the right branch then the node with that value is deleted
          node.data = find_min(node.right)
          node.right = delete_place(node.data, node.right)
        else
          # if there is only left child => node removed and replaced with node.left
          # if there is only right child => node removed and replaced with node.right
          # it's good because the reference to the parent is untouched
          # if there is no left/right child it's simply set to null
          node = node.left || node.right
          @size -= 1
        end
      else
        # if the value is not found in the tree we null is returned
        return nil
      end
      # We have to return the node to be able to handle the references.
      # When calling the function recursively the last call (which doesn't call
      # the function again) will set node to node.left || node.right then sends
      # back that node to the last recursive call so the reference is still working.
      node
    end
  end

  class TreeNode
    attr_accessor :data, :left, :right

    def initialize(data, left = nil, right = nil)
      @data = data
      @left = left
      @right = right
    end

    def leaf?
      left.nil? && right.nil?
    end

    def has_both_children?
      left.present? && right.present?
    end

    def has_any_children?
      left.present? || right.present?
    end
  end

  btn = BinaryTree.new(TreeNode.new(20))
  ln = btn.insert_left(btn.root, 10)
  rn = btn.insert_right(btn.root, 30)
  # puts ln
  # puts rn
  btn.insert_left(ln, 5)
  btn.insert_right(rn, 40)
  btn.inorder
  btn.preorder
  btn.postorder
  # print btn.levelorder
  # puts btn.inspect

  bst = BinarySearchTree.new
  bst.insert(20)
  bst.insert(10)
  bst.insert(30)
  bst.insert(25)
  bst.insert(40)
  bst.insert(35)
  bst.insert(50)
  bst.find(50)
  bst.delete(30)
  puts bst.inspect
  puts bst.min_height
  puts bst.max_height
  puts bst.balanced?
  print bst.levelorder

  # PROBLEM 1:
  # Given a binary tree check if it's binary search tree

  # with fake tree

  TREE_VALS = []

  # Traversal is O(n) complexity
  def self.inorder_for_check(tree)
    if tree
      inorder_for_check(tree.left)
      TREE_VALS << tree.root
      inorder_for_check(tree.right)
    end
  end

  def self.sort_check
    # could be made faster if just checking the next and prev value O(N)
    TREE_VALS == TREE_VALS.sort
  end
  # p sort_check == true

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

  arr = [1, 3, 4, 8, 12, 15, 20, 32, 40]
  p Trees.new.balanced_binary_with_sorted_array(arr, 0, arr.length - 1)

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
