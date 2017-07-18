require 'byebug'

class Trees
  class BinaryTree # list of lists would be the easiest implementation
    # value of root node is the first element of the lsit
    # second element represents the left subtree
    # third element represents the right subtree
    # binary tree -> nodes can only have 2 children
    attr_accessor :left, :right, :root

    def initialize(root)
      @root = root
      @left = nil
      @right = nil
    end

    def insert_left(node)
      new_node = BinaryTree.new(node)

      if @left
        new_node.left, @left = @left, new_node.left
        left
      else
        @left = new_node
      end
    end

    def insert_right(node)
      new_node = BinaryTree.new(node)

      if @right
        new_node.right, @right = @right, new_node.right
        right
      else
        @right = new_node
      end
    end
  end

  bt = BinaryTree.new(20)
  bt.insert_left(10)
  bt.insert_right(30)
  bt.left.insert_left(5)
  bt.left.insert_right(15)

  # traversal:
  # Starting from the root node we always try to find the left child, so
  # we call recursively call preorder on the left child.

  def self.preorder(tree)
    if tree
      puts tree.root
      preorder(tree.left)
      preorder(tree.right)
    end
  end

  # preorder(bt)

  def self.postorder(tree)
    if tree
      postorder(tree.left)
      postorder(tree.right)
      puts tree.root
    end
  end

  # postorder(bt)

  def self.inorder(tree)
    if tree
      inorder(tree.left)
      puts tree.root
      inorder(tree.right)
    end
  end

  inorder(bt)

  class BinaryHeap
    # like binary search tree except:
    # 1.
    # if min heap:
    # values of child nodes must be greater than parent node's value
    # if max hep:
    # values of child nodes must be smaller than parent node's value
    # 2.
    # all levels of the tree, except possibly the last one (deepest) are FULLY FILLED,
    # and, if the last level of the tree is not complete, the nodes of that level
    # are filled from left to right

    # in order to guarantee log performance we must keep our tree balanced
    # a balanced binary tree has roughly the same number of nodes in the
    # left and the right subtrees of the root. (in definition -> fully filled, so this
    # is not a problem here)

    def initialize
      @heap_list = [0]
      @current_size = 0
    end

    def insert(k)
      @heap_list.push(k)
      @heap_list.current_size += 1
      perc_up(current_size)
    end

    def perc_up(i)
      while i / 2 > 0
        if @heap_list[i] < @heap_list[i / 2]
          @heap_list[i], @heap_list[i / 2] = @heap_list[i / 2], @heap_list
        end
        i /= 2
      end
    end

    # ......
  end

  class BinarySearchTree
    # keys that are less than the parent can be found in the left subtree, and
    # keys that are greater can be found in the right one

    # Algorithm   Average   Worst Case
    # Space       O(n)      O(n)
    # Search      O(log n)  O(n)
    # Insert      O(log n)  O(n)
    # Delete      O(log n)  O(n)

    attr_reader :size

    def initialize
      @root = nil
      @size = 0
    end

    def insert(data)
      if @root
        insert_place(data, @root)
      else
        @root = TreeNode.new(data)
      end

      @size += 1
    end

    def get(data)
      return nil unless @root
      return find_item(data, @root) if response.val
      nil
    end

    def delete(data)
      delete_place(data, @root)
    end

    def find_min(data, node)
      current = node

      while current.left
        current = current.left
      end

      current.data
    end

    def find_max(data, node)
      current = node

      while current.right
        current = current.right
      end

      current.data
    end

    private

    def find_item(data, node)
      return nil unless node

      if node.data == data
        node
      elsif current_node.key > data
        find_item(data, node.left)
      elsif current_node.data < data
        find_item(data, node.right)
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
          node.data = find_min(data, node.right)
          node.right = delete_place(node.data, node.right)
        else
          node = node.left || node.right
          @size -= 1
        end
      else
        return nil
      end

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

  bst = BinarySearchTree.new
  bst.insert(20)
  bst.insert(10)
  bst.insert(30)
  bst.insert(25)
  bst.insert(35)
  bst.insert(50)
  bst.delete(30)
  puts bst.inspect


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

  inorder_for_check(bt)
  p sort_check == true

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

    return true if min <= tree.val && tree.val <= max
    return tree.right if tree.val < min
    return tree.left if tree.val > max
  end
end
