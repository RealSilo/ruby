puts self

class ClassScope
  puts self
  def instance_scope
    puts self
  end
end

ClassScope.new.instance_scope
