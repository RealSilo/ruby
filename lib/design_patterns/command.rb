# GOF definition

# We need to issue requests to objects without knowing anything about
# the action being requested or the receiver of the request.

# To solve this problem an object is used to encapsulate all
# information needed to performan action or trigger an event at a
# later time.

# COMMAND PATTERN

# Easiest approach would be to solve this with inheritance but
# there could be hundreds of different actions which would make
# things messy.

# The way to solve this problem is to package up the idea of what
# to do when an action is called. We want to bundle up the code to
# handle the any action ( create file or copy file) in its own object
# — an object that waits to be executed and, when executed, goes out
# and performs an application-specific task. These little packages of
# action are the commands of the Command pattern.

# The Command pattern can be useful in keeping track of what you have
# already done. For instance you are building an installation program,
# a utility that will set up some software on the user's system.
# Installation programs typically need to create, copy, move, and
# sometimes delete files. The user likely wanna know exactly what the
# installer is going to do before it actually does it. The user might
# also want to know what the installer did, after the fact. Keeping
# track of this information is easy if you organize each change as a
# command.

# Because we are trying to keep track of what we are about to do/have
# done, we need a class to collect all of the commands. A class that
# acts like a command, but it is just a front for a number of
# subcommands => Composite

# Enabling your client (user / another program) to undo what has already
# been executed is a common enough requirement. The naive way to implement
# an undo operation is to simply remember the state of things before you
# make the change and then restore the remembered state if the client
# wants to undo the change. The trouble with this approach is that text
# files, databases, etc. can be quite large. Creating a complete copy of
# everything each time you make a change can get ugly super quickly. The
# Command pattern can help here, too. A command (encapsulation
# of how do some specific thing) can also undo things. The idea is pretty
# simple: Every undo-able command that we create has two methods. Besides
# the usual execute method, which does the thing, we add an unexecute
# method, which undoes the same thing. As the user makes changes, we create
# command after command, executing each command immediately to effect the
# change. But we also store the commands, in order, in a list somewhere.
# If the user changes his or her mind and wants to undo a change, we find
# the last (or more) command  in reverse order on the list and unexecute it.

# The Command pattern can also be useful in situations where we accumulate
# a number of operations over time, but want to execute them all at once.

# Installers do this all the time. In a typical installation program, you
# go through the wizard saying that yes, you want the basic program the
# example files. As you progress through the installer, it memorizes a sort
# of to-do list based on what you check: copy in the program, copy in the
# documentation, etc. Only when you actually click the Install button do
# things really start to happen.

# Another example when it frequently takes a minor computer-time eternity
# to connect to a database. If you need to perform a number of database
# operations over time one-by-one it can be expensive. Instead of performing
# each operation as a stand-alone task, you can accumulate all of these
# commands in a list. Periodically, you can open a connection to the database,
# execute all of your commands, and flush out this list.

# Command pattern is used for instance for active record migrations.

# WRAP UP

# With the Command pattern, we create objects that know how to perform
# some very specific actions. Commands are useful for keeping a running list
# of things that your program needs to do, or for remembering what it has
# already done. You can also run your commands backward and undo the things
# that your program has done.

# The Command pattern and the Observer pattern have a lot in common. Both
# patterns identify an object — the command in the former pattern and the
# observer in the latter pattern — that is called from the other participant
# in the pattern. The differnce is that a command object simply knows how to
# do something, but is not particularly interested in the state of the thing
# that executed it. Conversely, an observer is intensely interested in the
# state of the subject, the thing that called it.

require 'fileutils'

class Command
  attr_reader :description

  def initialize(description)
    @description = description
  end

  def execute
    # implement
  end
end

class CompositeCommand < Command
  def initialize
    @commands = []
  end

  def add_command(command)
    @commands << command
  end

  def execute
    @commands.each(&:execute)
  end

  def unexecute
    @commands.reverse.each(&:unexecute)
  end

  def description
    description = ''
    @commands.each { |cmd| description += cmd.description + "\n" }
    description
  end
end

class CreateFile < Command
  def initialize(path, contents)
    super("Create file: #{path}")
    @path = path
    @contents = contents
  end

  def execute
    f = File.open(@path, 'w')
    f.write(@contents)
    f.close
  end

  def unexecute
    File.delete(@path)
  end
end

class DeleteFile < Command
  def initialize(path)
    super("Delete file: #{path}")
    @path = path
  end

  def execute
    @content = File.read(@path) if File.exist?(@path)
    File.delete(@path)
  end

  def unexecute
    if @content
      f = File.open(@path, 'w')
      f.write(@content)
      f.close
    end
  end
end

class CopyFile < Command
  def initialize(path, new_path)
    super("Copy file: #{path} to #{new_path}")
    @path = path
    @new_path = new_path
  end

  def execute
    @content = File.read(@new_path) if File.exists(@new_path)
    FileUtils.copy(@path, @new_path)
  end

  def unexecute
    if @contents
      f = File.open(@new_path, 'w')
      f.write(@contents)
      f.close
    else
      File.delete(@new_path)
    end
  end
end

commands = CompositeCommand.new
commands.add_command CreateFile.new('f1.txt', "hi there\n")
commands.add_command CopyFile.new('f1.txt', 'f2.txt')
commands.add_command DeleteFile.new('f1.txt')

puts commands.description
commands.execute
sleep 2
commands.unexecute
