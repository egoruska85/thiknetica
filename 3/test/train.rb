class Train
  ##### Создание поезда ######
  def initialize(number, type_train, quantity)
    @number = number
    type_trains = { 1 => 'Пассажирский', 2 => 'Грузовой' }
    @type_train = type_trains[type_train]
    @number_of_wagons = quantity
    @spped = 0
  end
  ###### Ручное управление ######
  def start(i)
    @speed = i
    puts @speed
    @route.stations[@num_station].trains.delete(@number)
    @route.stations[@num_station].sent_trains << @number
  end

  def up_speed(i)
    @speed += i
    puts @speed
  end
  def down_speed(i)
    @speed -= i if @speed > 10
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
    @num_station += 1
    @current_station = @route.stations[@num_station]
    @route.stations[@num_station].trains << @number
    @route.stations[@num_station].arrived << @number
  end
  def up_wagons(i)
    @number_of_wagons += i if @speed == 0

  end
  def down_wagons(i)
    @number_of_wagons -= i if @speed == 0

  end
  def show_wagons
    puts @number_of_wagons
  end
  ####Автомашинист########Нужно стартануть(start)#####
  def next_station
    @num_station += 1
    @route.stations[@num_station].trains << @number if @speed > 0
    @route.stations[@num_station].arrived << @number if @speed > 0
    @speed = 0
  end
  def previous_station
    @route.stations[@num_station].trains.delete(@number)
    @num_station -= 1
    @route.stations[@num_station].trains << @number if @speed > 0
    @route.stations[@num_station].arrived << @number if @speed > 0
    @speed = 0
  end
  #####Указание маршрута#####
  def enter_route(route)
    @route = route
    @num_station = 0
    @current_station = @route.stations[@num_station]
    @route.stations[@num_station].trains << @number
    @route.stations[@num_station].arrived << @number
  end
  def show_current_station
    puts @current_station
  end
end
