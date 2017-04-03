
#procs/lambdas ===========================

#first difference is the response to the number of arguments

number_lambda = lambda do |a,b,c|
  puts "The lambda numbers are #{a}, #{b} and #{c}"
end

number_lambda.call(2,4,6)
# number_lambda.call(2) => this throws wrong arg number error

number_proc = proc do |a,b,c|
  puts "c class: #{c.class}"
  puts "The proc numbers are #{a}, #{b} and #{c}"
end

number_proc.call(3,5,7)
number_proc.call(3)

#second difference is how they return from function call

def run_this_proc(p)
  puts "Start to run"
  p.call
  puts "Finished"
end

run_this_proc lambda { puts "I am a lambda"; return }
# run_this_proc proc { puts "I am a proc"; return } => unexpected return


# how to invoke procs

my_proc =  Proc.new do |n|
  puts "This is #{n}"
end

my_proc.call(10)
my_proc.(20)
my_proc[30]
my_proc === 40

few = Proc.new { |n| n > 0 && n < 3 }

0.upto(4) do |number|
  case number
  when few  # number === few
    puts "few"
  else
    puts "not few"
  end
end

#closure are bound to local vars around them
#methods are always bound to objects they are sent to


