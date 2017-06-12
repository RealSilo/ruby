require 'byebug'

class Trees
  class BinaryTree # list of lists would be the easiest implementation
    # value of root node is the first element of the lsit
    # second element represents the left subtree
    # third element represents the right subtree
    # binary tree -> nodes can only have 2 children
    attr_accessor :left_child, :right_child, :root

    def initialize(root)
      @root = root
      @left_child = nil
      @right_child = nil
    end

    def insert_left(node)
      new_node = BinaryTree.new(node)

      if @left_child
        new_node.left_child, @left_child = @left_child, new_node.left_child
        left_child
      else
        @left_child = new_node
      end
    end

    def insert_right(node)
      new_node = BinaryTree.new(node)

      if @right_child
        new_node.right_child, @right_child = @right_child, new_node.right_child
        right_child
      else
        @right_child = new_node
      end
    end
  end

  bt = BinaryTree.new(20)
  bt.insert_left(10)
  bt.insert_right(30)
  bt.left_child.insert_left(5)
  bt.left_child.insert_right(15)

  # traversal:
  # Starting from the root node we always try to find the left child, so
  # we call recursively call preorder on the left child.

  def self.preorder(tree)
    if tree
      puts tree.root
      preorder(tree.left_child)
      preorder(tree.right_child)
    end
  end

  # preorder(bt)

  def self.postorder(tree)
    if tree
      postorder(tree.left_child)
      postorder(tree.right_child)
      puts tree.root
    end
  end

  # postorder(bt)

  def self.inorder(tree)
    if tree
      inorder(tree.left_child)
      puts tree.root
      inorder(tree.right_child)
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
        i = i / 2
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

    def insert(key, val)
      if @root
        insert_place(key, val, @root)
      else
        @root = TreeNode.new(key, val)
      end

      @size += 1
    end

    def get(key)
      return nil unless @root
      response = find_item(key, @root) if response.val
      nil
    end

    private

    def find_item(key, current_node)
      return nil unless current_node

      if current_node.key == key
        current_node
      elsif current_node.key > key
        find_item(key, current_node.left_child)
      elsif current_node.key < key
        find_item(key, current_node.right_child)
      end
    end

    def insert_place(key, val, current_node)
      if key < current_node.key
        if current_node.left_child
          insert_place(key, val, current_node.left_child)
        else
          current_node.left_child = TreeNode.new(key, val, current_node)
        end
      else
        if current_node.right_child
          insert_place(key, val, current_node.right_child)
        else
          current_node.right_child = TreeNode.new(key, val, current_node)
        end
      end
    end
  end

  class TreeNode
    attr_accessor :parent, :left_child, :right_child, :key

    def initialize(key, val, parent = nil, left = nil, right = nil)
      @key = key
      @val = val
      @parent = parent
      @left_child = left
      @right_child = right
    end

    def root?
      parent.nil?
    end

    def leaf?
      left_child.nil? && right_child.nil?
    end

    def has_both_children?
      left_child.present? && right_child.present?
    end

    def has_any_children?
      left_child.present? || right_child.present?
    end
  end

  # PROBLEM 1:
  # Given a binary tree check if it's binary search tree

  # with fake tree

  TREE_VALS = []

  # Traversal is O(n) complexity
  def self.inorder_for_check(tree)
    if tree
      inorder_for_check(tree.left_child)
      TREE_VALS << tree.root
      inorder_for_check(tree.right_child)
    end
  end

  def self.sort_check
    debugger
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

    tree.left_child = trim_tree(tree.left_child, min, max)
    tree.right_child = trim_tree(tree.right_child, min, max)

    return true if min <= tree.val && tree.val <= max
    return tree.right_child if tree.val < min
    return tree.left_child if tree.val > max
  end
end
