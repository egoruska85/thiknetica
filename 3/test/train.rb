class Train
  attr_reader :type, :speed, :route, :carriages_amount, :number
  def initialize(number, type, carriages_amount)
    @number = number
    @type = type
    @carriages_amount = carriages_amount
    @speed = 0
  end

  def next_station
    route.stations[@number_station + 1] if route.stations[@number_station] != route.stations.last
  end

  def previous_station
    route.stations[@number_station - 1] unless @num_station == 0
  end

  def current_station
    route.stations[@number_station]
  end

  def start(i)
    @speed = i
    puts @speed
    current_station.send_train(self)
  end

  def up_speed(i)
    @speed += i
    puts @speed
  end

  def down_speed(i)
    @speed -= i if @speed > 0
    puts @speed
  end

  def stop
    @speed = 0
  end

  def start_continue(i)
    @speed = i
  end

  def stop_station
    next_station.add_train(self) if
    @number_station += 1
    @speed = 0
  end

  def up_to_carriages(quantity)
    @carriages_amount += quantity if @speed == 0
  end

  def down_to_carriages(quantity)
    @carriages_amount -= quantity if @speed == 0 && carriages_amount > quantity
  end

  def show_carriages
    puts carriages_amount
  end

  def enter_route(route)
    @route = route
    @number_station = 0
    route.start_station.add_train(self)
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

end
