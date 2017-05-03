# the goal:

# html_second = HTML_SECOND.new do
#   h2 'My new nested HTML DSL'

#   ul do
#     li 'This DOM is implemented in Ruby'
#     li 'It is pretty awesome'
#   end
# end

class HTML_FIRST # without nesting
  def initialize(&block)
    @rendered_html = ''
    # to execute the block on HTML so h2 etc. methods can be defined in the class
    instance_eval(&block) 
  end

  def method_missing(tag, *args)
    # we save into a var since there are many blocks to be executed
    @rendered_html << "<#{tag}>#{args.first}</#{tag}>"
  end

  def render
    @rendered_html
  end
end

html_first = HTML_FIRST.new do
  h2 'My new HTML DSL'

  h4 'This DOM is implemented in Ruby'
  h4 'It is pretty awesome'
end

p html_first.render

class HTML_SECOND
  def initialize(&block)
    @rendered_html = ''
    instance_eval(&block)
  end

  def method_missing(tag, *args, &block) # could be also defined with dynamic methods
    @rendered_html << "<#{tag}>"
    if block_given?
      instance_eval(&block)
    else
      @rendered_html << "#{args.first}"
    end
    @rendered_html << "</#{tag}>"
  end

  def render
    @rendered_html
  end
end

html_second = HTML_SECOND.new do
  h2 'My new nested HTML DSL'

  ul do
    li 'This DOM is implemented in Ruby'
    li 'It is pretty awesome'
  end
end

p html_second.render


class HTML_THIRD
  def initialize(&block)
    @rendered_html = ''
    instance_eval(&block)
  end

  def method_missing(tag, *args, &block) # could be also defined with dynamic methods
    if args.first.is_a? Hash
      properties =  args.shift.map { |p| p.join("=") } * ' '
    end

    @rendered_html << "<#{tag} #{properties}>"

    if block_given?
      instance_eval(&block)
    else
      @rendered_html << "#{args.first}"
    end

    @rendered_html << "</#{tag}>"
  end

  def render
    @rendered_html
  end
end

html_third = HTML_THIRD.new do
  h2 'My new nested HTML DSL'

  ul id: 'nav', class: 'list' do
    li 'This DOM is implemented in Ruby'
    li 'It is pretty awesome'
  end
end

p html_third.render
