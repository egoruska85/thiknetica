module ItemsForMenu
  COMMANDS = {1 => 'Менеджер станций', 2 => 'Менеджер маршрутов', 3 => 'Менеджер поездов', 4 => 'Менеджер вагонов', 5 => 'Интерфейс управления поездами', 6 => 'Стастистика по станциям и поездам' }.freeze

  TAB = "\n\t\t\t\t\t"
  CONTROL_INTERFACE_TITLE_ROUTES = '### Маршруты к которым добавлен состав и на каких они станция в данный момент #########################'.freeze
  SECTION_SEPARATOR = '#######################################################################################################'.freeze

  LIST_TRAINS = '######################################### СПИСОК ПОЕЗДОВ ##############################################'.freeze
  NO_CREATED_TRAINS = "НЕТУ СОЗДАННЫХ ПОЕЗДОВ".freeze
  ERROR_NOT_CREATED = "!!!!! У ВАС НЕТУ СОЗДАННЫХ ИЛИ ДОСТУПНЫХ".freeze
  ERROR_ENTER_TYPE_TRAIN = "Ошибка(Вы неправильно указали категорию поезда)".freeze
  ENTER_TRAINS_MANAGMENT = 'Введите номер поезда, либо(e- закончить создание поездов, r- назначить маршрут поездам): '.freeze
  MESSAGE_END_CREATE_TRAIN = "\n\t\t\t\t\t\t Создание станции закончено".freeze
  ENTER_ROUTE_DESTINATION = "\nВведите какой маршрут хотите назначить поезду:"
  ENTER_THE_TRAIN_ROUTE = "\nВведите какому поезду назначить маршрут(e - Назад): ".freeze
  ENTER_NAME_MANUFACTURER = "Укажите имя производителя поезда: ".freeze
  ERROR_NO_CREATED_ROUTES = "У ВАС НЕТУ СОЗДАННЫХ МАРШРУТОВ".freeze
  TRAIN = "Поезд".freeze

  LIST_CARRIAGES = "################################# Список доступных вагонов ########################################".freeze
  LIST_ATTACHED_CARRIAGES = "################################# Список занятых вагонов ########################################".freeze

  ENTER_MENU_TYPE = ['1)Пассажирский', '2)Грузовой']

  ENTER_LIST_STATIONS = "(l- Вывод список станций)".freeze
  ENTER_NAME_STATION = "Введите название станции: ".freeze
  SELECT_AN_ACTION_TO_CONTINUE = "Выберите действие для продолжения (e выход):".freeze
  ENTER_CARRIAGE_NUMBER = "Укажите номер вагона :".freeze
  ERROR_NO_CREATED_STATION = "НЕТУ СОЗДАННЫХ МАРШРУТОВ".freeze
  ENTER_TRAIN = "Выберите поезд который хотите выбрать (e - Назад): ".freeze
  ENTER_MENU_CARRIAGE = "Выберите вагон: ".freeze
  ENTER_MENU_CARRIAGES_WHAT_CARRIGE = "Введите номер вагона который хотите отсоеденить от состава: ".freeze
  MESSAGE_NO_ATTACHED_CARRIAGES_CURRENT_TRAIN = "Нету подсоеденённых вагонов к этому поезду".freeze

  MENU_AVAILABLE_STATIONS = "Доступные станции для этого маршрута".freeze
  ERROR_FOR_ROUTES_NOT_TWO_STATIONS = "У вас должны созданы как минимум 2 станции для продолжения".freeze
  ENTER_STATION_TO_ROUTE = "Выберите станцию из списка которая будет ".freeze
  ENTER_CURRENT_ROUTE_ADD_STATION = "Хотите назначить этому маршруту добавить станции?: (Y- Да, N- Нет):".freeze
  ENTER_ADD_STATION_TO_ROUTE = "Выберите станцию, которую вы хотите добавить в маршрут (e- Назад):".freeze
  TITLE_EDIT_ROUTE = "Редактировать маршрут".freeze
  SELECT_CREATE_ROUTE = "Создать маршрут".freeze

  NO_ROUTES_MESSAGE = "НЕТУ МАРШРУТОВ".freeze
  END_CREATE_ROUTES_MESSAGE = "Создание маршрутов закончено".freeze
  ENTER_ROUTE_FOR_STATIONS = "Выберите маршрут над которым хотите работать (e- Выход):".freeze
  ENTER_ADD_OR_DELETE_STATION_TO_ROUTE = "1)Добавить станцию в маршрут\n2) Удалить станцию из маршрута".freeze
  STATIONS_IN_CURRENT_ROUTE = "\nСтанции указаные в маршруте".freeze


  EXIT = "(e Выход из менеджера "

  def tab
    print TAB
  end

  def section_separator
    puts SECTION_SEPARATOR
  end

  def error_not_created
    print ERROR_NOT_CREATED
  end

  def commands_menu
    puts ''
    COMMANDS.each { |key, value| puts "\t\t\t\t#{key})#{value}\n\n".upcase }
  end

  def view_title(key)
    puts "############################################### #{COMMANDS[key].upcase} ##########################################################"
  end

  def entered_commands

  end

  def exit
    print EXIT
  end
  ############# МЕТОДЫ ДЛЯ МЕНЕДЖЕРА ПОЕЗДОВ И ВАГОНОВ #################

  def list_trains
    puts LIST_TRAINS
  end

  def train_word
    print TRAIN
  end

  def no_created_trains
    puts NO_CREATED_TRAINS
  end

  def enter_trains_managment
    print ENTER_TRAINS_MANAGMENT
  end

  def message_end_create_train
    puts MESSAGE_END_CREATE_TRAIN
  end

  def enter_menu_type
    puts ENTER_MENU_TYPE
  end

  def enter_menu_type_trains
    enter_menu_type
    print 'Выберите тип поезда:'
  end

  def enter_the_train_route
    print ENTER_THE_TRAIN_ROUTE
  end

  def enter_route_destination
    print ENTER_ROUTE_DESTINATION
  end

  def enter_name_manufacturer
    print ENTER_NAME_MANUFACTURER
  end

  def error_enter_type_train
    puts ERROR_ENTER_TYPE_TRAIN
  end

  def created_message_trains_or_carriages(number, type, name_manufacturer)

    puts " c номером: #{number}, типом: #{type} и производителем: #{name_manufacturer} успешно создан."
  end

  def list_carriages
    puts LIST_CARRIAGES
  end

  def list_attached_carriages
    puts LIST_ATTACHED_CARRIAGES
  end

  def error_no_created_carriages
    tab
    error_not_created
    puts "ВАГОНОВ !!!!!"
  end
  ENTER_MENU_CARRIAGES_WHAT_CARRIGE
  def enter_menu_carriages_what_carrige
    print ENTER_MENU_CARRIAGES_WHAT_CARRIGE
  end

  def message_no_attached_carriages_current_train
    puts MESSAGE_NO_ATTACHED_CARRIAGES_CURRENT_TRAIN
  end

  def enter_menu_type_carriages_if_carriages_added
    enter_menu_type
    puts "3)Прицепить вагоны к составу"
  end

  def enter_menu_type_carriages_if_carriages_attached_to_train
    enter_menu_type_carriages_if_carriages_added
    puts "4)Отцепить вагоны от состава"
  end

  def select_an_action_to_continue
    print SELECT_AN_ACTION_TO_CONTINUE
  end

  def enter_carriage_number
    print ENTER_CARRIAGE_NUMBER
  end

  def enter_train
    print ENTER_TRAIN
  end

  def enter_menu_carriage
    print ENTER_MENU_CARRIAGE
  end

  def message_attached_carriage(train, carriage)
    puts "К поезду № #{train.number}(#{train.type}) присоеденён вагон #{carriage.number}(#{carriage.type})"
  end

  def message_disattached_carriage(train, carriage)
    puts "От поезда № #{train.number}(#{train.type}) отсоеденён вагон #{carriage.number}(#{carriage.type})"
  end
  ############# МЕТОДЫ ДЛЯ МЕНЕДЖЕРА СТАНЦИЙ #################

  def enter_list_stations
    puts ENTER_LIST_STATIONS
  end

  def enter_name_station
    print ENTER_NAME_STATION
  end

  def created_message_station(name)
    puts "Станция #{name} создана\n\n"
  end

  def error_no_created_station
    puts
  end

  ############# МЕТОДЫ ДЛЯ МЕНЕДЖЕРА МАРШРУТОВ #################

  def error_for_routes_not_two_stations
    puts ERROR_FOR_ROUTES_NOT_TWO_STATIONS
  end

  def menu_available_stations
    puts MENU_AVAILABLE_STATIONS
  end

  def enter_station_to_route
    print ENTER_STATION_TO_ROUTE
  end

  def no_routes_message
    puts NO_ROUTES_MESSAGE
  end

  def end_create_routes_message
    puts END_CREATE_ROUTES_MESSAGE
  end

  def error_no_created_routes
    puts ERROR_NO_CREATED_ROUTES
  end

  def message_created_route(start_station, finish_station)
    puts "Маршрут успешно создан c начальной #{start_station} и конечной #{finish_station} станциями"
  end

  def enter_current_route_add_station
    print ENTER_CURRENT_ROUTE_ADD_STATION
  end

  def select_create_route(routes)
    if routes.empty?
      puts SELECT_CREATE_ROUTE
    end
  end

  def error_not_created

  end

  def enter_add_station_to_route
    print ENTER_ADD_STATION_TO_ROUTE
  end

  def menu_add_station_to_route_start
    enter_station_to_route
    print 'начальная (e- закончить создание маршрута): '
  end

  def menu_add_station_to_route_finish
    enter_station_to_route
    print 'конечная (e- закончить создание маршрута): '
  end

  def add_station_message_to_route(station)
    puts "Добавлена станция #{station.name}"
  end

  def title_edit_route
    puts TITLE_EDIT_ROUTE
  end

  def enter_route_for_stations
    print ENTER_ROUTE_FOR_STATIONS
  end

  def enter_add_or_delete_station_to_route
    puts ENTER_ADD_OR_DELETE_STATION_TO_ROUTE
  end

  def entered_route_menu(route)
    print "Что вы желаете сделать с данным марршрутом (#{route.start_station.name} => #{route.finish_station.name})?:"
  end

  def menu_add_station_to_route
    enter_station_to_route
    print "добавлена в маршрут: (e- назад):"
  end

  def stations_in_current_route
    puts STATIONS_IN_CURRENT_ROUTE
  end

  def menu_delete_station_from_route
    enter_station_to_route
    print "удалена из маршрута: (e- назад):"
  end

  def control_interface_title_routes
    puts CONTROL_INTERFACE_TITLE_ROUTES
  end
end
