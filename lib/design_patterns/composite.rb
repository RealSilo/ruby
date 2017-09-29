# GOF DEFINITION

# The design pattern for our “the sum acts like one of the parts”
# situation the Composite pattern. You will know that you need to
# use the Composite pattern when you are trying to build a
# hierarchy or tree of objects, and you do not want the code that
# uses the tree to constantly have to worry about whether it is
# dealing with a single object or a whole bushy branch of the tree.

# COMPOSITE PATTERN
# Sometimes we want a complex object to look and act exactly like
# the components we use to build it. For instance you are working for
# a gourmet bakery. You have been asked to build a system that keeps
# track of the manufacturing of the new chocolate cake. A key
# requirement is that your system has to keep track of the time it
# takes to manufacture a cake. Of course, making a cake is a fairly
# complicated process. First you have to make the cake batter, put
# the batter in a pan, and put the pan in the oven. Once the cake is
# baked, you need to frost it and package it for sale. Making the
# batter is also a prtty complicated process in itself,
# involving a quite long sequence of steps like measuring out
# the flour, cracking the eggs, and licking the spoon. You can think
# of the cake-baking process as a tree, where the master task of
# making a cake is built up from subtasks such as baking the cake
# and packaging it, which are themselves made up of even simpler
# tasks.

# 1. Manufacture Cake: Make Cake, Package cake
# 2. Make Cake: Make Batter, Fill Pan, Bake, Frost
# 2. Package Cake: Box, Label
# 3. Make Batter: AddDryIngredientsTask, AddLiquidsTask

# You need to identify the lowest-level, most-fundamental tasks of
# cake making and stop there => AddDryIngredientsTask and
# AddLiquidsTask, All of classes will need to share a common
# interface that will let them report back how much time they take.
# For tasks that are built up of smaller subtasks we also want to
# know how long it takes to finish them => Make Batter. But, these
# higher-level tasks are not quite the same as the simple ones:
# They are built up from other tasks, so you will need some kind of
# container object to deal with these complex (composite) tasks.
# There is one other point about these higher-level tasks: While
# they are built up internally of any number of subtasks, from the
# outside they look just like any other Task. This approach works
# on two levels. First, any code that uses the MakeBatterTask object
# does not have care about the fact that making batter is more
# complex than for instance adding liquuds. Simple or complex,
# everything is just a Task. The same is true for the MakeBatter
# class itself: MakeBatter should not concern itself with the details
# of its subtasks; simple or complex, they are just Tasks to
# MakeBatter. Because MakeBatter simply manages a list of Tasks, any
# of those subtasks could themselves be made up of sub-subtasks. We
# can, in short, make the tree of tasks and subtasks go as deep as
# we like.

# To build the Composite pattern you need three moving parts.

# First, you need a common interface or base class for all of
# your objects. The GoF call this base class or interface the
# component. Ask yourself, “What will my basic and higher-level
# objects all have in common?” In baking cakes, both the simple task
# of measuring flour and the much more complex task of making the
# batter take a certain amount of time.
# Second, you need one or more leaf classes—that is, the simplest
# building blocks of the process. In our cake example, the leaf tasks
# were the simple jobs, such as measuring flour or adding eggs.
# The leaf classes should, of course, implement the Component
# interface.
# Third, we need at least one higher-level class, which the GoF call
# the composite class. The composite is a component, but it is also a
# higher-level object that is built from subcomponents. In the baking
# example, the composites are the complex tasks such as making the
# batter or manufacturing the whole cake—that is, the tasks that are
# made up of subtasks.

# We said that the goal of the Composite pattern is to make
# the leaf objects more or less indistinguishable from the composite
# objects. There is one unavoidable difference between a composite
# and a leaf though: The composite has to manage its children,
# which means that it needs to have a method to get at the children
# and possibly methods to add and remove child objects. The leaf
# classes, of course, really do not have any children to manage.

# WRAP UP
# Sometimes we need to model objects that naturally group themselves
# into larger components. These more complex objects fit into the
# Composite pattern if they share some characteristics with the
# individual components: The whole looks a lot like one of the parts.
# The Composite pattern lets us build arbitrarily deep trees of objects
# in which we can treat any of the interior nodes(composites) just
# like any of the leaf nodes.
# The Composite pattern is so fundamental that it reappears in other
# patterns. The Interpreter pattern is nothing more than a
# specialization of the Composite pattern.
# It is difficult to imagine the Composite pattern without the Iterator
# pattern.

# Component base class:
class Task
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def time_required
    0.0
  end
end

# Leaf classes:
class AddDryIngredientsTask < Task
  def initialize
    super('Add dry ingredients')
  end

  def time_required
    1.0
  end
end

class AddLiquidsTask < Task
  def initialize
    super('Add liquid ingredients')
  end

  def time_required
    2.0
  end
end

# composite class
# While the MakeBatterTask class looks to the outside world like any other simple 
# ask—it implements the key time_required method—it is actually built up from two
# subtasks: AddDryIngredientsTask and AddLiquidsTask
class MakeBatterTaskDraft < Task
  def initialize
    super('Make batter')
    @sub_tasks = []
    add_sub_task(AddDryIngredientsTask.new)
    add_sub_task(AddLiquidsTask.new)
  end

  def add_sub_task(task)
    @sub_tasks << task
  end

  def remove_sub_task(task)
    @sub_tasks.delete(task)
  end

  def time_required
    time = 0.0
    @sub_tasks.each { |task| time += task.time_required }
    time
  end
end

# Since we will have more composite tasks it makes sense to extract the details
# of managing child tasks to another base class.

class CompositeTask < Task
  def initialize(name)
    super(name)
    @sub_tasks = []
  end

  def add_sub_task(task)
    @sub_tasks << task
  end

  def remove_sub_task(task)
    @sub_tasks.delete(task)
  end

  def time_required
    time = 0.0
    @sub_tasks.each { |task| time += task.time_required }
    time
  end
end

class MakeBatterTask < CompositeTask
  def initialize
    super('Make batter')
    add_sub_task(AddDryIngredientsTask.new)
    add_sub_task(AddLiquidsTask.new)
  end
end

make_batter = MakeBatterTask.new
add_dry_ingredients = AddDryIngredientsTask.new
add_liquids = AddLiquidsTask.new
make_batter.add_sub_task(add_dry_ingredients)
make_batter.add_sub_task(add_liquids)
p make_batter.time_required
