require_relative "manufacturer"
require_relative "instance_counter"

class Train
  include Manufacturer
  include InstanceCounter
  attr_reader :type, :speed, :route, :carriages, :number, :errors
  @@trains = []
  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
    @@trains << self
    register_instance
  end

  def self.find(number_train)
    @@trains.find{|train| train.number == number_train }
  end

  def move(speed)
    @speed = speed
  end

  def up_speed(speed)
    @speed += speed
    puts @speed
  end

  def down_speed(speed)
    @speed -= speed if @speed > 0
    puts @speed
  end

  def stop
    @speed = 0
  end

  def move_to_next_station
    return unless next_station

    current_station.send_train(self)
    next_station.add_train(self)
    @number_station += 1
  end

  def move_to_previous_station
    return unless previous_station

    current_station.send_train(self)
    previous_station.add_train(self)
    @number_station -= 1
  end

  def attach_carriages(carriage)
    @carriages << carriage if speed == 0 && type == carriage.type
    @errors = []
    @errors << [speed, type, carriage.type] if speed > 0 or type != carriage.type
  end

  def disattach_carriages(carriage)
    @carriages.delete(carriage) if speed == 0 && @carriages.length > 0
    @errors = []
    @errors << [speed, type, carriage.type] if speed > 0
  end

  def show_carriages_quantity
    puts carriages.length
  end

  def enter_route(route)
    @route = route
    @number_station = 0
    current_station.add_train(self)
  end

  def next_station
    route.stations[@number_station + 1]
  end

  def previous_station
    route.stations[@number_station - 1] if @number_station > 0 #здесь нужна проверка иначе значение будет -1 и тода поезд будет перемещен на конечную станию
  end

  def current_station
    route.stations[@number_station]
  end

end
