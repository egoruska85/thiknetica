class Train
  attr_reader :type, :speed, :route, :carriages, :number, :errors
  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
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
    route.start_station.add_train(self)
  end

  attr_reader :stations
  attr_writer :number_station

  def next_station
    route.stations[@number_station + 1] if route.stations[@number_station] != route.stations.last
  end

  def previous_station
    route.stations[@number_station - 1] unless @number_station == 0
  end

  def current_station
    route.stations[@number_station]
  end

end
