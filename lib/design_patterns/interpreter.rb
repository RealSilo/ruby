# The Interpreter pattern suggests that sometimes the best way to solve a problem
# is to invent a new language for just that purpose. We will see how a typical
# interpreter is constructed and consider some ways of dealing with the tedious
# task of parsing. We will also find out that interpreters are perhaps not the
# best-performing solution, but that for their performance price they do offer a
# lot of flexibility and extensibility.
# The Interpreter pattern is built around a very basic idea: Some programming
# problems are best solved by creating a specialized language and expressing the
# solution in that language. What kind of problems are good candidates for the
# Interpreter pattern? As a general rule of thumb, problems well suited to the
# Interpreter pattern tend to be self-contained, with tight boundaries around them.
# For instance, if you are writing code that searches for specific objects based on
# some specification, you might consider creating a query language (like SQL). Or
# if you are tasked of creating complex object configurations, you might think about
# building a configuration language. Another hint that your problem might be right
# for the Interpreter pattern is that you find yourself creating lots of discrete
# chunks of code, chunks that seem easy enough to write in themselves, but which you
# find yourself combining in an expanding array of combinations. Perhaps a simple
# interpreter could do all of the combining work for you.

# Interpreters usually work in two phases. First, the parser reads in the program
# text and produces a data structure, called an abstract syntax tree (AST). The AST
# represents the same information as the original program, but transformed into a
# tree of objects that, unlike the original program text, can be executed with
# reasonable efficiency. Second, the AST is evaluated against some set of external
# conditions, or context, to produce the desired computation.

# For example, we might build an interpreter to evaluate very simple arithmetic
# expressions like this one:
# 5.0 * (3 + x)
# First, we need to parse this expression. Our parser would start out by tackling the
# first character of the expression (5) and then move on to the decimal point and the
# zero, working out along the way that it is dealing with a floating-point number.
# Having finished with the 5.0, the parser would move on to process the rest of the
# expression, eventually producing a tree data structure.

# With the AST in hand, we are almost ready to evaluate our expression except for one
# small detail: What is the value of x? To evaluate the expression, we need to supply
# a value for x. The GOF called such values or con-ditions supplied at the time the
# AST is interpreted the context. Whatever the values in the context, the AST evaluates
# itself by recursively descending down the tree. We ask the root node of the tree
# (the node representing the multiplication) to evaluate itself. Then itrecursively
# tries to evaluate its two factors. The 5.0 is easy, but the other factor (addition)
# must evaluate its terms (the 3 and x). We finally hit bottom here and the results
# are comeing back up through the recursion.
# We see two things from this simple arithmetic expression example. First, the
# Interpreter pattern has a lot of moving parts. Think of all the different classes that
# make up the AST and then add in the parser. The sheer number of components is why the
# Interpreter pattern is in practice limited to relatively simple languages. Second,
# the Interpreter pattern is unlikely to be fast. Aside from the parsing overhead,
# traversing the AST will inevitably exact some speed penalty of its own.
# We do get a couple of things back in return for the interpreter’s complexity and speed
# penalty. First, we get flexibility. Once you have an interpreter, it is usually pretty
# easy to add new operations to it. Second, we get the AST itself. An AST is a data
# structure that represents some specific piece of programming logic. While we originally
# built the AST to evaluate it, we can manipulate it so that it does other things, too.
# We might, for example, have the AST print out a description of itself: "Multiply 5.0 by
# the sum of 3 and x, where x is 1."

# Let's say that we are writing a program that manages files, lots of files of many
# different formats and sizes. We will frequently need to search for files with particular
# characteristics, such as all the MP3 files or all the writable files. Not only that, but
# we will also need to find files that share a specific combination of characteristics,
# such as all the big MP3 files or all the JPEG files that are read only.

# This sounds like a problem that could be solved with a simple query language. We can
# imagine that each expression in our language will specify the kind of files that we are
# looking for. Let’s start with the classes that will make up the AST and put off the parser
# until later.

require 'find'
class Expression
  # Common expression code will go here soon...
end

class All < Expression
  def evaluate(dir)
    results= []
    Find.find(dir) do |p|
      next unless File.file?(p)
      results << p
    end 
    results
  end
end




