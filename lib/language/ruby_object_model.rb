class A
end

class B < A
  def self.baz
  end

  # class << self
  #   def hihi
  #   end
  # end
end

def B.baz;end

# b = B.new

def haha
  puts 'hihi'
end

# BasicObject.send(:haha)
# Object.send(:haha)
# self.send(:haha)
# puts self
# puts self.class
# puts self.to_s

# puts A.superclass
# puts B.class
# puts B.superclass.singleton_class
# puts B.singleton_class.superclass
# puts b.singleton_class
# puts b.superclass
# puts b.singleton_class.superclass
# puts b.singleton_class.object_id
# puts b.object_id
# puts B.singleton_class.object_id
# puts B.object_id
# puts B.singleton_class.superclass

# puts A.superclass.ancestors
# puts BasicObject.class
# puts BasicObject.superclass
# puts Class.class
# puts Class.superclass
# puts Module.class
# puts Module.superclass
# puts BasicObject.superclass.class
# puts Class.superclass.superclass.superclass.superclass.class.class
