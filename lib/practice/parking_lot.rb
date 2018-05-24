require 'byebug'

SMALL = 1
MEDIUM = 2
LARGE = 3

STORIES = 4

SMALL_SPOTS_PER_STORY = 5
MEDIUM_SPOTS_PER_STORY = 10
LARGE_SPOTS_PER_STORY = 2

class ParkingLot
  attr_reader :stories

  def initialize(stories)
    @stories = stories
  end

  def park(vehicle)
  end
end

class Story
  attr_reader :number, :spots

  def initialize(number, spots)
    @number = number
    @spots = spots
  end
end

class Spot
  attr_reader :number, :size, :vehicle

  def initialize(number, size)
    @number = number
    @size = size
    @vehicle = nil
  end

  def park(vehicle)
    return 'No fit' unless vehicle.size <= @size
    @vehicle = vehicle
  end

  def leave
    return 'No vehicle parked' if @vehicle.nil?
    leaving_vehicle = @vehicle
    @vehicle = nil
    leaving_vehicle
  end
end

class Vehicle
  def initialize(vin)
    @vin = vin
  end
end

class Bus < Vehicle
  def initialize(vin)
    super(vin)
    @size = LARGE
  end
end

class Car < Vehicle
  def initialize(vin)
    super(vin)
    @size = MEDIUM
  end
end

class MotoCycle < Vehicle
  def initialize(vin)
    super(vin)
    @size = SMALL
  end
end

def create_spots(size, quantity)
  spots = []
  quantity.times { |i| spots << Spot.new(i + 1, size) }
  spots
end

def create_spots_for_story
  {
    small: create_spots(SMALL, SMALL_SPOTS_PER_STORY),
    medium: create_spots(MEDIUM, MEDIUM_SPOTS_PER_STORY),
    large: create_spots(LARGE, LARGE_SPOTS_PER_STORY),
  }
end

number = (0..STORIES - 1).to_a
stories = Hash[number.map { |x| [x, Story.new(x, create_spots_for_story)] }]

parking_lot = ParkingLot.new(stories)
byebug
puts parking_lot



