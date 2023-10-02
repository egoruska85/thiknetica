# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Style/Documentation
# rubocop:disable Metrics/MethodLength

require_relative 'dictonary'
require_relative 'trains_management_messages'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'control_interface'

module TrainsManagement
  include Dictonary
  include TrainsManagementMessages
  include ControlInterface

  TRAINS_MENU_LIST = [
    'создание поезда',
    'назначить поезду маршрут',
    'список поездов',
    'управление поездами',
    'любое значение для возврата в корневое меню'
  ].freeze

  def trains_management
    loop do
      view_title(3)
      choices_list(TRAINS_MENU_LIST, false)
      case gets.to_i
      when 1 then create_train
      when 2 then add_route_to_train
      when 3 then show_trains
      when 4 then trains_control
      else main_menu
      end
    end
  end

  def create_train
    trains_list_in_menu
    number = gets.chomp
    print TYPE
    type = gets.chomp
    trains_management if number == 'e' || type == 'e'
    create_train_action(number, type)
  rescue RuntimeError => e
    puts e
    retry
  end

  def create_train_action(number, type)
    if type == '1'
      train = PassengerTrain.new(number)
    elsif type == '2'
      train = CargoTrain.new(number)
    end
    print ENTER_MANUFACTURER_NAME
    name_manufacturer = gets.chomp
    train.name_manufacturer = name_manufacturer
    trains << train
    message_create_train(train)
  end

  def add_route_to_train
    trains_list_in_menu_without_enter
    print ENTER_TRAINS_ASSIGN_ROUTE
    train_index = gets.chomp
    routes_list_in_add_station
    print ENTER_ROUTE
    route_index = gets.chomp
    add_route_to_train_action(train_index, route_index)
  end

  def add_route_to_train_action(train_index, route_index)
    train = trains[train_index.to_i - 1]
    route = routes[route_index.to_i - 1]
    train.enter_route(route)
    message_add_route_to_train(route)
  end

  def train_move_message(train)
    puts "Поезд перемещен на станцию #{train.current_station.name}"
  end
end
