class Train
  attr_reader :type_train, :speed, :route, :carriages_amount, :number
  ##### Создание поезда ######
  def initialize(number, type_train, quantity)
    @number = number
    type_trains = { 1 => 'Пассажирский', 2 => 'Грузовой' }
    @type_train = type_trains[type_train]
    @carriages_amount = quantity
    @spped = 0
  end
  def next_station
    route.stations[@num_station + 1]
  end
  def previous_station
    route.stations[@num_station - 1] unless @num_station == 0
  end
  def current_station
    route.stations[@num_station]
  end
  ###### Ручное управление ######
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
    @speed = 0
    next_station.add_train(self)
    @num_station += 1
  end
  def up_to_carriages(quantity)
    carriages_amount += quantity if @speed == 0

  end
  def down_to_carriages(quantity)
    carriages_amount -= quantity if @speed == 0 && carriages_amount > quantity
  end
  def show_carriages
    puts carriages_amount
  end

  #####Указание маршрута#####
  def enter_route(route)
    @route = route
    @num_station = 0
    route.start_station.add_train(self)
  end
  #### Передвижение поезда между стациями #####
  def move_to_next_station
    if next_station
      current_station.send_train(self)
      next_station.add_train(self)
      @num_station+= 1
    end
  end
  def move_to_previous_station
    if previous_station
      current_station.send_train(self)
      previous_station.add_train(self)
      @num_station -= 1
    end
  end

end
