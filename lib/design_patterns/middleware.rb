require 'logger'
require 'byebug'

class LoggerMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    puts 'LOGGER CALLED'
    Logger.new(STDOUT).info(env)
    @app.call(env)
  end
end

class RequestModifierMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    puts 'REQUEST MODIFIER CALLED'
    env.merge!({ request_modified: true })
    @app.call(env)
  end
end

class BuildMiddlewares
  def initialize(&block)
    @middlewares = []
    instance_eval(&block)
  end

  def call(env = {})
    to_app.call(env)
  end

  def to_app
    application = lambda { |env| env }

    @middlewares.reverse.inject(application) do |app, middleware|
      middleware.call(app)
    end
  end

  def use(klass)
    @middlewares << lambda do |app|
      klass.new(app)
    end
  end
end

config = BuildMiddlewares.new do
  use LoggerMiddleware
  use RequestModifierMiddleware
end

request = { request_modified: false }

result = config.call(request)
puts result
