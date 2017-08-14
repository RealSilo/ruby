require 'byebug'

class HTML
  def initialize(&block)
    @rendered = ''
    instance_eval(&block)
  end

  def h1 content
    @rendered << "<h1>#{content}</h1>"
  end

  def div content
    @rendered << "<div>#{content}</div>"
  end

  def render
    @rendered
  end
end

result = HTML.new do
  h1 'Dev meeting'

  div 'hi there'
end

# p result.render

class HTML2
  TAG_LIST = %i(h1 div span ul li)

  def initialize(&block)
    @rendered = ''
    instance_eval(&block)
  end

  # def h1(content, &block)
  #   if block_given?
  #     @rendered << "<h1>"
  #     block.call if block_given?
  #   else
  #     @rendered << "<h1>#{content}"
  #   end
  #   @rendered << "</h1>"
  # end

  # def span content
  #   @rendered << "<span>#{content}</span>"
  # end

  # def div content
  #   @rendered << "<div>#{content}</div>"
  # end

  # def ul(&block)
  #   @rendered << "<ul>"
  #   block.call if block_given?
  #   @rendered << "</ul>"
  # end

  # def li(content, &block)
  #   if block_given?
  #     @rendered << "<li>"
  #     block.call if block_given?
  #   else
  #     @rendered << "<li>#{content}"
  #   end
  #   @rendered << "</li>"
  # end

  # def method_missing(tag, content)
  #   @rendered << "<#{tag}>#{content}</#{tag}>"
  # end

  TAG_LIST.each do |tag|
    define_method(tag) do |content = '', options = {}, &block|
      attributes = options.reduce('') { |result, (key, val)| result << "#{key}='#{val}' " }
      if block
        @rendered << "<#{tag} #{attributes}>"
        block.call
      else
        @rendered << "<#{tag} #{attributes}>#{content}"
      end
      @rendered << "</#{tag}>"
    end
  end

  def render
    @rendered
  end
end

result2 = HTML2.new do
  h1 'Dev meeting' do
    span 'hahaha'
  end

  div 'hi there'

  ul do
    li 'list element', class: 'haha', id: 'hihi'
    li 'list element' do
      span 'alfsadlf'
    end
  end
end

p result2.render

class Expectation
  def initialize(first)
    @first = first
  end

  def equal(second)
    @second = second
    puts(@first == @second)
  end

  def greater_than(second)
    @second = second
    puts(@first > @second)
  end
end

class Test
  def initialize(&block)
    instance_eval(&block)
  end

  def it(name)
    yield
  end

  def expect(a)
    Expectation.new(a)
  end
end

a = 1
b = 1

test = Test.new do
  it 'a is equal b' do
    expect(a).equal(b)
  end

  it 'a is greter than b' do
    expect(a).greater_than(b)
  end
end

