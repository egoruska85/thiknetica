class Core
  private

  attr_reader :stations, :routes, :trains, :carriages, :key, :attached_carriages, :available_carriages

  def show_command
    puts ''
    puts "###### КОМАНДЫ ДЛЯ УПРАВЛЕНИЯ ПРОГРАММОЙ ###### "
    commands_menu
  end

  def process_start(key)
    @key = key
    if key == 1
      stations_managment
    elsif key == 2
      routes_management
    elsif key == 3
      trains_managment
    elsif key == 4
      carriages_managment
    elsif key == 5
      control_interface
    elsif key == 6
      view_trains_on_station
    end
  end


  def stations_managment
    view_title(1)
    enter_list_stations if stations.any?
    exit
    puts "станций)"
    enter_name_station
    name_station = gets.chomp.to_s
    if name_station == 'e'
      main_menu
    elsif name_station == 'l'
      view_stations
    else
      station = Station.new(name_station.capitalize)
      tab
      created_message_station(station.name)
      @stations << station
      stations_managment
    end
  rescue RuntimeError => e
    tab
    puts e.message.upcase
    retry
  end

  def view_stations
    view_title(1)
    stations.each_with_index do |station, index|
      puts "#{ index+1 }) #{ station.name }: \n\n\tПоезда на станции:"
      station.trains.each_with_index do |train, index|
        puts "\tПуть № #{ index + 1 } #{ train.number }; кол-во ввгонов #{train.carriages.size};"
        train.carriages.each do |carriage|
          puts "#{tab}#{tab} Вагон № #{carriage.number} свободный объём: #{carriage.available_places}; занятого объёма: #{carriage.reserved_places}" if carriage.type == :cargo
          puts "#{tab}#{tab} Вагон № #{carriage.number} свободных мест: #{carriage.available_places}; занятых мест: #{carriage.reserved_places}" if carriage.type == :passenger
        end
      end
      small_section_separator
    end
    stations_managment
  end

  def trains_managment
    view_title(3)
    list_trains
    tab
    no_created_trains if @trains.empty?
    @trains.each_with_index { |train, index| puts "#{tab}#{index += 1})#{train.number}(#{train.type})(#{train.name_manufacturer})"}
    section_separator
    enter_trains_managment
    number_train = gets.chomp
    if number_train == 'e'
      message_end_create_train
      main_menu
    elsif number_train == 'r'
      if @trains.empty?
        tab
        error_not_created
        puts "ПОЕЗДОВ !!!!!\n\n"
        trains_managment
      elsif @routes.empty?
        tab
        error_not_created
        puts "МАРШРУТОВ !!!!!\n\n"
        routes_management
      else
        loop do
          @trains.each_with_index { |train, index| puts "#{index += 1})#{train.number}(#{train.type})"}
          enter_the_train_route
          enter_train = gets.chomp
          trains_managment if enter_train == 'e'
          @routes.each_with_index { |route, index| puts "#{index += 1})#{route.start_station.name}=>#{route.finish_station.name}"}
          enter_route_destination
          enter_route = gets.chomp
          enter_route_to_train(@trains[enter_train.to_i - 1], @routes[enter_route.to_i - 1 ])
        end
      end
    elsif number_train == 'l'
      show_trains
    end
  create_train(number_train)
  rescue RuntimeError => e
    tab
    puts e.message.upcase
    retry
  end


  def create_train(number_train)
    loop do
      enter_menu_type_trains
      type = gets.to_i
      if type == 1
        passenger_train = PassengerTrain.new(number_train)
        enter_name_manufacturer
        name_manufacturer = gets.chomp
        passenger_train.name_manufacturer = name_manufacturer
        @trains << passenger_train
        train_word
        created_message_trains_or_carriages(passenger_train.number, passenger_train.type, passenger_train.name_manufacturer)
        trains_managment
      elsif type == 2
        cargo_train = CargoTrain.new(number_train)
        enter_name_manufacturer
        name_manufacturer = gets.chomp
        cargo_train.name_manufacturer = name_manufacturer
        @trains << cargo_train
        train_word
        created_message_trains_or_carriages(cargo_train.number, cargo_train.type, cargo_train.name_manufacturer)
        trains_managment
      else
        tab
        error_enter_type_train
        trains_managment
      end
    end
  end

  def show_trains
    @trains.each_with_index do |train, index|
      puts "#{index + 1} - Поезд №  #{train.number}, тип: #{train.type}, количество вагонов: #{train.carriages.size};"
      train.carriages.each do |carriage|
        print "#{tab}"
        puts "#{tab} Вагон поезда № #{carriage.number} Занято #{carriage.reserved_places}м3; свободно: #{carriage.available_places} м3" if carriage.type == :cargo
        puts "#{tab} Вагон поезда № #{carriage.number} Занято #{carriage.reserved_places}; свободно: #{carriage.available_places}" if carriage.type == :passenger
        small_section_separator
      end
      small_section_separator
    end
  end

  def routes_management
    view_title(2)
    if stations.size < 2
      tab
      error_for_routes_not_two_stations
      stations_managment
    end
    select_create_route
    select_create_route_if_created_routes if routes.any?
    select_an_action_to_continue
    enter = gets.chomp
    if enter == '1'
      create_route
    elsif enter == '2'
      edit_route
    elsif enter == 'e'
      main_menu
    end
  end

  def create_route
    view_title(2)
    menu_available_stations
    @available_stations = @stations.clone
    @available_stations.each_with_index {|station, index| puts "#{tab}#{index += 1})#{station.name}" }
    menu_add_station_to_route_start
    first_station = gets.chomp
    if @routes.empty? and first_station == 'e'
      tab
      no_routes_message
      end_create_routes_message
      routes_management
    elsif first_station == 'e'
      end_create_routes_message
      routes_management
    end
    menu_add_station_to_route_finish
    finish_station = gets.chomp
    route = Route.new(stations[first_station.to_i - 1], stations[finish_station.to_i - 1])
    message_created_route(route.start_station.name, route.finish_station.name)
    @routes << route
    enter_current_route_add_station
    enter = gets.chomp.capitalize

    if enter == 'Y'
      loop do
        removal_existing_stations(route)#делает доступные только те станции которых нету в маршруте
        enter_add_station_to_route
        enter_station = gets.chomp
        if enter_station == 'e'
          create_route
        else
          route.add_station(@available_stations[enter_station.to_i - 1])
          add_station_message_to_route(route.stations[-2])
          puts "#{route.stations.inspect}"
        end
      end
    elsif enter == 'N'
      create_route
    end
    rescue NoMethodError => e
      puts e
    retry
  end

  def edit_route
    view_title(2)
    @available_stations = @stations.clone
    tab
    title_edit_route
    @routes.each_with_index { |route, index| puts "#{ index += 1})#{route.start_station.name} => #{route.finish_station.name}" }
    enter_route_for_stations
    index_enter_route = gets.chomp
    main_menu if index_enter_route == 'e'
    enter_route = @routes[index_enter_route.to_i - 1]
    enter_add_or_delete_station_to_route
    entered_route_menu(enter_route)
    enter = gets.chomp
    if enter == '1'
      loop do
        removal_existing_stations(enter_route) #делает доступные только те станции которых нету в маршруте
        menu_add_station_to_route
        enter_station = gets.chomp
        edit_route if enter_station == 'e'
        enter_route.add_station(@available_stations[enter_station.to_i - 1])
        add_station_message_to_route(enter_route.stations[-2])
        puts "#{enter_route.stations.inspect}"
      end
    elsif enter == '2'
      loop do
        removal_existing_stations(enter_route) #делает доступные только те станции которых нету в маршруте
        stations_in_current_route
        enter_route.stations.each_with_index { |station, index| puts "#{index += 1})#{station.name}" }
        menu_delete_station_from_route
        enter_station = gets.chomp
        edit_route if enter_station == 'e'
        enter_route.destroy_station(enter_route.stations[enter_station.to_i - 1])
      end
    elsif enter == 'e'
      main_menu
    end
  end

  def carriages_managment
    view_title(4)
    list_carriages
    carriages.each_with_index { |carriage, index| puts "#{index += 1})#{carriage.type} => #{carriage.inspect}"}
    error_no_created_carriages if @carriages.empty?
    section_separator
    enter_menu_type
    enter_menu_type_carriages_if_carriages_added if carriages.any? && attached_carriages.empty?
    enter_menu_type_carriages_if_carriages_attached_to_train if attached_carriages.any?
    select_an_action_to_continue
    type = gets.chomp
    if type == '1'
      enter_carriage_number
      number = gets.chomp
      carriage = PassengerCarriage.new(number, 36)
      @carriages << carriage
      created_message_trains_or_carriages(carriage.number, carriage.type, carriage.name_manufacturer)
      carriages_managment
    elsif type == '2'
      enter_carriage_number
      number = gets.chomp
      carriage = CargoCarriage.new(number, 45)
      @carriages << carriage
      created_message_trains_or_carriages(carriage.number, carriage.type, carriage.name_manufacturer)
      carriages_managment
    elsif type == '3'
      loop do
        list_trains
        trains.each_with_index { |train, index| puts "#{index += 1})#{train.number}(#{train.type} => #{train.inspect})"}
        list_carriages
        carriages.each_with_index { |carriage, index| puts "#{index += 1})#{carriage.type} => #{carriage.inspect}"}
        error_no_created_carriages if @carriages.empty?
        section_separator
        enter_train
        enter_train = gets.chomp
        carriages_managment if enter_train == 'e'
        enter_menu_carriage
        enter_carriage = gets.chomp
        connect_carriage_to_train(trains[enter_train.to_i - 1], carriages[enter_carriage.to_i - 1])
      end
    elsif type == '4'
      loop do
        list_attached_carriages
        attached_carriages.each_with_index { |carriage, index| puts "#{index += 1})#{carriage.type} => #{carriage.inspect}"}
        list_trains
        trains.each_with_index do |train, index|
          print "#{tab}#{index += 1})#{train.number}=>"
          message_no_attached_carriages_current_train if train.carriages.empty?
          train.carriages.each_with_index do |carriage, index|
            puts "#{tab}(#{index += 1})#{carriage.number} #{carriage.name_manufacturer})"
          end
        end
        section_separator
        enter_train
        enter = gets.chomp
        carriages_managment if enter == 'e'
        enter_menu_carriages_what_carrige
        number_carriage = gets.to_i
        enter_train = trains[enter.to_i - 1]
        disconnect_carriage_from_train(enter_train, number_carriage - 1)
      end
    elsif type == '5'
        attached_carriages.each_with_index {|carriage, index| puts "#{index + 1} #{carriage.type}"}
        enter_carriage_index = gets.to_i
        enter_carriage = attached_carriages[enter_carriage_index - 1]
        cariiage_info(enter_carriage)
        carriages_managment
    elsif type == 'e'
      main_menu
    end
    rescue NoMethodError => e
    rescue RuntimeError => e
      tab
    puts e.message.upcase
    retry
  end

  def enter_route_to_train(train, route)
    train.enter_route(route)
    puts "#{route.inspect}"
  end

  def connect_carriage_to_train(train, carriage)
    result = train.attach_carriages(carriage)
    attached_carriages << train.carriages.last
    attached_carriages.uniq!
    attached_carriages.compact!
    train.carriages.last.number = train.carriages.index(attached_carriages.last) + 1 # Назначает номер вагона согласно номера в массиве @carriages и + 1
    message_attached_carriage(train, attached_carriages.last)
    @carriages.delete(attached_carriages.last)
    puts attached_carriages.inspect
  end

  def disconnect_carriage_from_train(train, number_carriage)
    carriage = train.carriages[number_carriage]
    attached_carriages.delete(carriage)
    carriages.push(carriage)
    message_disattached_carriage(train, carriages.last)
  end

  def passenger_and_cargo_management(carriage)
    entered_carriage(carriage)
    if carriage.is_a?(CargoCarriage)
    select_add_place
      volume = gets.to_i
      carriage.reserve_place(volume)
    else
      carriage.reserve_place
    end
  message_add_volume_to_carriage(carriage)
  cariiage_info(carriage)
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def cariiage_info(carriage)
    trains.each do |train|
      train.carriages.each do |train_carriage|
        if train_carriage == carriage
          @finded_train = train
        end
      end
    end
    if carriage.type == :cargo
      puts "Вагон № #{carriage.number} присоеденён к поезду с № #{@finded_train.number}; доступного места для груза: #{carriage.available_places} м3; загружено: #{carriage.reserved_places} м3"
    else
      puts "Вагон № #{carriage.number} присоеденён к поезду с № #{@finded_train.number}; доступных мест для пассажиров: #{carriage.available_places}; занятых мест: #{carriage.reserved_places}"
    end
  end

  def control_interface
    view_title(5)
    if trains.empty?
      tab
      no_created_trains
      trains_managment
    elsif routes.empty?
      tab
      error_no_created_routes
      routes_management
    end
    control_interface_title_routes
    puts
    loop do
      trains.each_with_index do |train, index|
        puts "#{index + 1} #{train.number} находится на #{train.current_station.name} количество вагонов: #{train.carriages.length}"
      end
      enter_train
      enter_index = gets.chomp
      main_menu if enter_index == 'e'
      enter_train = trains[enter_index.to_i - 1]
      print "\t 1) Отправить на следующию станцию?\n"
      print "\t 2) Отправить на предыдущую станцию?\n"
      print "\t 3) Управления Пассажирами или грузами\n"
      print "\t 4) Просто поехать?\n"
      print "\t 5) Затормозить?\n"
      print "\t 0) Выйти\n"
      print "Выбран поезд #{enter_train.number} что вы желаете с ним сделать: (e- Выход)"
      enter_action = gets.to_i
      if enter_action == 1
        if enter_train.move_to_next_station
          puts "поезд c #{enter_train.number} перемещен вперед на 1 станцию, текущая станция = #{enter_train.current_station.name}"
        else
          puts "Поезд не может быть перемещен вперед, так как находится на конечной станции маршрута"
        end
      elsif enter_action == 2
        if enter_train.move_to_previous_station
          puts "поезд c #{enter_train.number} перемещен назад на 1 станцию, текущая станция = #{enter_train.current_station.name}"
        else
          puts "Поезд не может быть перемещен назад, так как находится на начальной станции маршрута"
        end
      elsif enter_action == 3
        enter_train.carriages.each {|carriage| puts "Вагон #{carriage.number} #{carriage.type}"}
        select_carriage_to_manage
        enter_carriage_index = gets.to_i
        enter_carriage = enter_train.carriages[enter_carriage_index - 1]
        passenger_and_cargo_management(enter_carriage)
      elsif enter_action == 4
        print "Укажите скорость: "
        speed = gets.to_i
        if enter_train.move(speed)
          puts "\nПоехали!"
        end
      elsif enter_action == 5
        if enter_train.stop
          puts 'STOP!'
        end
      elsif enter_action == 0
        main_menu
      end
    end
  end
  def view_trains_on_station
    if stations.empty?
      tab
      error_no_created_station
    stations_managment
    elsif routes.empty?
      tab
      error_no_created_routes
    routes_management
    elsif trains.empty?
      tab
      no_created_trains
    trains_managment
    end
    view_title(6)
    loop do
    stations.each_with_index {|station, index| puts "#{1}#{ station.name } "}
    puts "Выберите станцию, для которой хотите посмотреть список поездов(e - Выход):"
    enter = gets.chomp
    main_menu if enter == 'e'
    station = stations[enter.to_i - 1]
      if station
        puts "\nСписок поездов на станции #{station.name}"
        station.trains.each{|train| puts train.inspect}
      end
    end
  end

  def removal_existing_stations(route)
    route.stations.each { |station| @available_stations.delete(station)}
    puts "Доступные станции"
    @available_stations.each_with_index { |station, index| puts "#{index += 1})#{station.name}; " }
  end
end
