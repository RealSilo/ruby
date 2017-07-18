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

    def find(data)
      return nil unless @root
      return find_place(data, @root) if response.val
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
          # if there are both left and right children the data is replaced with the
          # min value of the right branch then the node with that value is deleted
          node.data = find_min(data, node.right)
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
  puts ln
  puts rn
  btn.insert_left(ln, 5)
  btn.insert_right(rn, 40)
  btn.inorder
  btn.preorder
  btn.postorder
  print btn.levelorder
  puts btn.inspect

  bst = BinarySearchTree.new
  bst.insert(20)
  bst.insert(10)
  bst.insert(30)
  bst.insert(25)
  bst.insert(40)
  bst.insert(35)
  bst.insert(50)
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

    return true if min <= tree.val && tree.val <= max
    return tree.right if tree.val < min
    return tree.left if tree.val > max
  end
end
