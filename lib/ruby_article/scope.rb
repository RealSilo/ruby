class ClassScope
  puts self

  def instance_method_scope
    puts self
  end

  def self.class_method_scope
    puts self
  end
end

ClassScope.new.instance_method_scope
ClassScope.class_method_scope

puts self

1.times do |n|
  puts self
end
