class Core
  private

  attr_reader :stations, :routes, :trains, :carriages, :key, :attached_carriages, :available_carriages

  def show_command
    puts ''
    puts "###### КОМАНДЫ ДЛЯ УПРАВЛЕНИЯ ПРОГРАММОЙ ###### "
    @commands.each do |key, value|
      puts "\t\t\t\t#{key})#{value}\n\n".upcase
    end
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
    view_title
    puts "\t(l- Вывод список станций)" if stations.any?
    puts "\t(e- выйти из создания станций)"
    print 'Введите название станции: '
    name_station = gets.chomp.to_s
    if name_station == 'e'
      main_menu
    elsif name_station == 'l'
      view_stations
    else
      station = Station.new(name_station.capitalize)
      puts "Созданая станция сохранена: #{station.name}(#{station.inspect})"
      @stations << station
      puts "--------------------------------\nСоздано"
      stations_managment
    end
  end

  def view_stations
    view_title
    puts "\n #### #{@commands[key].upcase} #### \n \n"
    stations.each{|station| puts station.name}
    puts "--------------------------------\nВыполнено"
    stations_managment
  end

  def trains_managment
    view_title
    puts "###### Список поездов ######"
    @trains.each_with_index { |train, index| puts "#{index += 1})#{train.number}(#{train.type})"}
    puts "############################"
    print 'Введите номер поезда, либо(e- закончить создание поездов, r- назначить маршрут поездам): '
    number_train = gets.chomp
    if number_train == 'e'
      puts "--------------------\n Создание станции закончено)"
      main_menu
    elsif number_train == 'r'
      if @trains.empty?
        puts "У вас нету созданных поездов в системе"
        trains_managment
      else
        loop do
          @trains.each_with_index { |train, index| puts "#{index += 1})#{train.number}(#{train.type})"}
          print "\nВведите какому поезду назначить маршрут(e - Назад):"
          enter_train = gets.chomp
          trains_managment if enter_train == 'e'
          @routes.each_with_index { |route, index| puts "#{index += 1})#{route.start_station.name}=>#{route.finish_station.name}"}
          print "\nВведите какой маршрут хотите назначить поезду:"
          enter_route = gets.chomp
          enter_route_to_train(@trains[enter_train.to_i - 1], @routes[enter_route.to_i - 1 ])
        end
      end
    end
    puts "1) Пассажирский\n2) Грузовой:"
    print 'Выберите тип поезда:'
    type = gets.to_i
    if type == 1
      passenger_train = PassengerTrain.new(number_train.to_i)
      @trains << passenger_train
      puts "Создан поезд с номером #{passenger_train.number}(#{passenger_train.type})"
      trains_managment
    elsif type == 2
      cargo_train = CargoTrain.new(number_train.to_i)
      @trains << cargo_train
      puts "Создан поезд с номером #{cargo_train.number}(#{cargo_train.type})"
      trains_managment
    elsif type != 1 or type != 2
      puts "--------------------\n Ошибка(Вы неправильно ввели категорию поезда)"
      create_train
    end
  end

  def routes_management
    view_title
    if stations.size < 2
      puts "У вас должны созданы как минимум 2 станции для продолжения"
      stations_managment
    end
    if @routes.empty?
      puts "1)Создать маршрут\n0)Выход из режима"
    else
      puts "1)Создать маршрут\n2)Редактировать маршрут\n0)Выход из режима"
    end
    print "Выберите действие:"
    enter = gets.to_i
    if enter == 1
      create_route
    elsif enter == 2
      edit_route
    elsif enter == 0
      main_menu
    end
  end

  def create_route
    puts "\n #### #{@commands[key].upcase} #### \n \n"
    puts "#### Созданные станции ####"
    @available_stations = @stations.clone
    @available_stations.each_with_index {|station, index| puts "#{index += 1})#{station.name}" }
    print 'Выберите начальную станцию из списка (e- закончить создание маршрута): '
    first_station = gets.chomp
    if @routes.empty? and first_station == 'e'
      puts "--------------------\n Нет маршрутов)"
      routes_management
    elsif first_station == 'e'
      puts "--------------------\n Создание закончено закончено"
      routes_management
    end
    print 'Выберите конечную станцию из списка (e- закончить создание маршрута): '
    finish_station = gets.chomp

    route = Route.new(stations[first_station.to_i - 1], stations[finish_station.to_i - 1])
    @routes << route
    puts "Маршрут создан"
    print 'Хотите назначить этому маршруту добавить станции?: (Y- Да, N- Нет):'
    enter = gets.chomp.capitalize

    if enter == 'Y'
      loop do
        removal_existing_stations(route)#делает доступные только те станции которых нету в маршруте
        print "Выберите станцию, которую вы хотите добавить в маршрут (e- Назад):"
        enter_station = gets.chomp
        if enter_station == 'e'
          create_route
        else
          route.add_station(@available_stations[enter_station.to_i - 1])
          puts "\nДобавлена станция #{@available_stations[enter_station.to_i - 1].inspect}"
          puts "#{route.stations.inspect}"
        end
      end
    elsif enter == 'N'
      create_route
    end
  end

  def edit_route
    @available_stations = @stations.clone
    puts "\n #### #{@commands[key].upcase} #### \n \n"
    puts "#### Редактировать маршрут ####"
    i = 0
    @routes.each { |route| puts "#{ i+= 1})#{route.start_station.name} => #{route.finish_station.name}" }
    print "Выберите маршрут над которым хотите работать (e- Выход):"
    index_enter_route = gets.chomp
    main_menu if index_enter_route == 'e'
    enter_route = @routes[index_enter_route.to_i - 1]
    puts "1)Добавить станцию в маршрут\n2) Удалить станцию из маршрута"
    print "Что вы желаете сделать с данным марршрутом (#{enter_route.start_station.name} => #{enter_route.finish_station.name}):"
    enter = gets.chomp
    if enter == '1'
      loop do
        removal_existing_stations(enter_route) #делает доступные только те станции которых нету в маршруте
        print "\nВыберите станцию из списка: (e- назад):"
        enter_station = gets.chomp
        edit_route if enter_station == 'e'
        enter_route.add_station(@available_stations[enter_station.to_i - 1])
        puts "\nДобавлена станция #{@available_stations[enter_station.to_i - 1].inspect}"
        puts "#{enter_route.stations.inspect}"
      end
    elsif enter == '2'
      loop do
        removal_existing_stations(enter_route) #делает доступные только те станции которых нету в маршруте
        puts "\nСтанции указаные в маршруте"
        enter_route.stations.each_with_index { |station, index| puts "#{index += 1})#{station.name}" }
        print "Выберите станцию которую вы хотите удалить из маршрута(e- назад):"
        enter_station = gets.chomp
        edit_route if enter_station == 'e'
        enter_route.destroy_station(enter_route.stations[enter_station.to_i - 1])
      end
    elsif enter == 'e'
      main_menu
    end
  end

  def carriages_managment
    view_title
    puts "###### Список вагонов ######"
    carriages.each_with_index { |carriage, index| puts "#{index += 1})#{carriage.type} => #{carriage.inspect}"}
    puts "Нету созданных или доступных вагонов" if @carriages.empty?
    puts "############################"
    if @carriages.empty?
      puts "1)Пассажирский\n2)Грузовой\ne)Выход"
    else
      puts "1)Пассажирский\n2)Грузовой\n3)Прицепить вагоны к составу\ne)Выход" if attached_carriages.empty?
      puts "1)Пассажирский\n2)Грузовой\n3)Прицепить вагоны к составу\n4)Отцепить вагоны от состава\ne)Выход" if attached_carriages.any?
    end
    print 'Выберите действие для продолжения:'
    type = gets.chomp
    if type == '1'
      print 'Запустить генератор пассажирских вагонов?: (Y -Да; N -Нет;):'
      enter = gets.chomp.capitalize
      if enter == 'Y'
        puts 'Генератор вагонов'
        print 'Введите количество вагонов которое хотите создать:'
        quantity = gets.to_i
        1.upto(quantity) do
          carriage = PassengerCarriage.new
          @carriages << carriage
          puts "Создан вагон #{@carriages.last.type}"
        end
        carriages_managment
      elsif enter == 'N'
        carriage = PassengerCarriage.new
        @carriages << carriage
        puts "Создан вагон #{@carriages.last.type}"
        carriages_managment
      end
    elsif type == '2'
      print 'Запустить генератор грузовых вагонов?: (Y -Да; N -Нет;):'
      enter = gets.chomp.capitalize
      if enter == 'Y'
        puts 'Генератор вагонов'
        print 'Введите количество вагонов которое хотите создать:'
        quantity = gets.to_i
        1.upto(quantity) do
          carriage = CargoCarriage.new
          @carriages << carriage
          puts "Создан вагон #{@carriages.last.type}(#{@carriages.last.inspect}) "
        end
        carriages_managment
      elsif enter == 'N'
        carriage = CargoCarriage.new
        @carriages << carriage
        puts "Создан вагон #{@carriages.last.type}(#{@carriages.last.inspect}) "
        carriages_managment
      end
    elsif type == '3'
      loop do
        puts '######### Поезда #########'
        trains.each_with_index { |train, index| puts "#{index += 1})#{train.number}(#{train.type} => #{train.inspect})"}
        puts '######### Вагоны #########'
        carriages.each_with_index { |carriage, index| puts "#{index += 1})#{carriage.type} => #{carriage.inspect}"}
        puts "Нету созданных или доступных вагонов" if @carriages.empty?
        puts '##########################'
        print 'Выберите поезд (e - Назад):'
        enter_train = gets.chomp
        carriages_managment if enter_train == 'e'
        print 'Выберите вагон:'
        enter_carriage = gets.chomp
        connect_carriage_to_train(trains[enter_train.to_i - 1], carriages[enter_carriage.to_i - 1])
      end
    elsif type == '4'
      loop do
        puts '####### Занятые вагоны #######'
        attached_carriages.each_with_index { |carriage, index| puts "#{index += 1})#{carriage.type} => #{carriage.inspect}"}
        puts '########### Составы ###############'
        trains.each_with_index do |train, index|
          print "#{index += 1})#{train.number}=>"
          puts "\tНету подсоеденённых вагонов к этому поезду" if train.carriages.empty?
          train.carriages.each_with_index do |carriage, index|
            puts "\t(#{index += 1})#{carriage.inspect})"
          end
        end
        print 'Введите поезд который хотите выбрать (e - Нвзад): '
        enter = gets.chomp
        carriages_managment if enter == 'e'
        print 'Введите номер вагона который хотите отсоеденить от состава: '
        number_carriage = gets.to_i
        enter_train = trains[enter.to_i - 1]
        disconnect_carriage_from_train(enter_train, number_carriage - 1)
      end
    elsif type == 'e'
      main_menu
    end
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
    if result
      puts "\nОстановите поезд пожалуйста!\n" if train.errors[0][0] > 0
      puts "\nВагон несовместим с данным типом поезда\n" if train.errors[0][1] != train.errors[0][2]
    else
      puts "К поезду №#{train.number} присоеденён вагон #{attached_carriages.last}"
    end
    @carriages.delete(attached_carriages.last)
    puts "\nВагоны присоеденёные к составам: #{attached_carriages.inspect}\n"
    puts "\n#{train.inspect}"
  end

  def disconnect_carriage_from_train(train, number_carriage)
    carriage = train.carriages[number_carriage]
    if train.disattach_carriages(carriage)
      puts "\nОстановите поезд пожалуйста!\n" if train.errors[0][0] > 0
    else
      attached_carriages.delete(carriage)
      carriages.push(carriage)
      puts "Отсоеденён вагон от поезда #{train.number}=> #{carriages.last}"
    end

  end

  def control_interface
    view_title
    if trains.empty?
      puts '                                !!!!!! ВНИМАНИЕ У ВАС НЕТУ НИ ОДНОГО ПОЕЗДА !!!!!!'
      puts '                                !!!!!!       СОЗДАЙТЕ ХОТЯ БЫ ОДИН ПОЕЗД    !!!!!!'
      trains_managment
    elsif routes.empty?
      puts '                                !!!!!! ВНИМАНИЕ У ВАС НЕТУ НИ ОДНОГО МАРШРУТА !!!!!!'
      puts '                                !!!!!!      СОЗДАЙТЕ ХОТЯ БЫ ОДИН МАРШРУТ     !!!!!!'
      routes_management
    end
    puts '################# Маршруты к которым добавлен состав и на каких они станция в данный момент ###############################'
    puts
    loop do
      trains.each_with_index do |train, index|
        puts "#{index + 1} #{train.number} находится на #{train.current_station.name} количество вагонов: #{train.carriages.length}"
      end
      print "Выберите состав (0 - Выход): "
      enter_index = gets.to_i
      main_menu if enter_index == 0
      enter_train = trains[enter_index - 1]
      print "\t 1) Отправить на следующию станцию?\n"
      print "\t 2) Отправить на предыдущую станцию?\n"
      print "\t 3) Просто поехать?\n"
      print "\t 4) Затормозить?\n"
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
          puts "Поезд не может быть перемещен вперед, так как находится на начальной станции маршрута"
        end
      elsif enter_action == 3
        print "Укажите скорость: "
        speed = gets.to_i
        if enter_train.move(speed)
          puts "\nПоехали!"
        end
      elsif enter_action == 4
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
      puts '                                 !!!!!!  ВНИМАНИЕ У ВАС НЕТУ НИ ОДНОЙ СТАНЦИИ !!!!!!'
      puts '                               !!!!!!  СОЗДАЙТЕ ХОТЯ БЫ ОДНУ СТАНЦИЮ, А ЛУЧШЕ ДВЕ !!!!!!'
    stations_managment
    elsif routes.empty?
      puts '                                !!!!!! ВНИМАНИЕ У ВАС НЕТУ НИ ОДНОГО МАРШРУТА !!!!!!'
      puts '                                !!!!!!      СОЗДАЙТЕ ХОТЯ БЫ ОДИН МАРШРУТ     !!!!!!'
    routes_management
    elsif trains.empty?
      puts '                                !!!!!! ВНИМАНИЕ У ВАС НЕТУ НИ ОДНОГО ПОЕЗДА !!!!!!'
      puts '                                !!!!!!       СОЗДАЙТЕ ХОТЯ БЫ ОДИН ПОЕЗД    !!!!!!'
    trains_managment
    end
    view_title
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

  def view_title
    puts "############################################### #{@commands[key].upcase} ##########################################################"
  end
  def removal_existing_stations(route)
    route.stations.each { |station| @available_stations.delete(station)}
    puts "Доступные станции"
    @available_stations.each_with_index { |station, index| puts "#{index += 1})#{station.name}; " }
  end
end
