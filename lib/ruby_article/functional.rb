class Array
  def my_map(&block)
    result = []
    i = 0
    
    while i < size
      result << block.call(self[i])
      i += 1
    end

    result
  end
end

double = [1 ,2 ,3 ,4].my_map { |n| n * 2 }

puts double