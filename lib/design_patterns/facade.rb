# GOF definition

# Provide a unified interface to a set of interfaces in a subsystem.
# Facade defines a higher-level interface that makes the subsystem easier
# to use.

# FACADE PATTERN

# Structuring a system into subsystems helps reduce complexity. A common design
# goal is to minimize the communication and dependencies between subsystems. One
# way to achieve this goal is to introduce a facade object that provides a
# single, simplified interface to the more general facilities of a subsystem.

# Use the Facade pattern when
# - you want to provide a simple interface to a complex subsystem
# - there are many dependencies between clients and the implementation classes of
#   an abstraction. Introduce a facade to decouple the subsystem from clients and
#   other subsystems, thereby promoting subsystem independence and portability

# The Dashboard class provides a common interface for locating the user’s
# collaborator objects to display the user's notifications and posts on the
# dashboard.

class User
  attr_reader :first_name, :last_name, :notifications, :posts

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @notifications = []
    @posts = []
  end

  def send_notification(notification)
    @notifications << notification
  end

  def create_post(post)
    @posts << post
  end
end

class Notification
  def initialize(message)
    @message = message
    @time = Time.now
  end
end

class Post
  def initialize(content)
    @content = content
    @time = Time.now
  end
end

class UserDashboardController
  def index
    user = User.new
    @user_dashboard = UserDashboard.new(user)
  end
end

class UserDashboard
  attr_reader :user

  def initialize(user = nil)
    @user = user
  end

  def notifications
    @user.notifications
  end

  def posts
    @user.posts
  end
end

user = User.new('Peter', 'Jones')
user_dashboard = UserDashboard.new(user)
user.send_notification(Notification.new('message sent'))
user.send_notification(Notification.new('second message'))
user.create_post(Post.new('my first post'))
user.create_post(Post.new('second post'))

puts user_dashboard.notifications.inspect
puts user_dashboard.posts.inspect
