# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Style/Documentation

require_relative 'dictonary'
require_relative 'carriages_management_messages'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'
require_relative 'control_interface'

module CarriageManagement
  include Dictonary
  include CarriageManagementMessages
  include ControlInterface

  CARRIAGES_MENU_LIST = [
    'создание вагона',
    'подсоеденить вагон к поезду',
    'отсоеденить вагон от поезда',
    'управление пассажирами и грузами',
    'Информация о вагоне',
    'любое значение для возврата в корневое меню'
  ].freeze

  def carriages_management
    view_title(4)
    choices_list(CARRIAGES_MENU_LIST, false)
    case gets.to_i
    when 1 then create_carriage
    when 2 then connect_carriage_to_train
    when 3 then disconnect_carriage_from_train
    when 4 then manage_passenger_and_cargo
    when 5 then carriage_info
    else main_menu
    end
  end

  def create_carriage
    view_title(4)
    print TYPE
    type = gets.chomp
    create_carriage_action(type)
    carriages_management
  end

  def create_carriage_action(type)
    if type == '1'
      carriage = PassengerCarriage.new(0, 36)
    elsif type == '2'
      carriage = CargoCarriage.new(0, 10)
    end
    print ENTER_MANUFACTURER_NAME
    carriage.name_manufacturer = gets.chomp
    carriages << carriage
    message_created_carrriage(carriage)
  end

  def connect_carriage_to_train
    list_carriages_with_enter
    carriage_index = gets.chomp
    trains_list_in_menu_with_enter
    train_index = gets.chomp
    carriages_management if train_index == 'e' || carriage_index == 'e'
    carriage = carriages[carriage_index.to_i - 1]
    connect_carriage_to_train_action(carriage, train_index)
  rescue RuntimeError => e
    puts e
  end

  def connect_carriage_to_train_action(carriage, train_index)
    train = trains[train_index.to_i - 1]
    train.attach_carriages(carriage)
    @attached_carriages << train.carriages.last
    attached_carriages_action(train)
  end

  def attached_carriages_action(train)
    @attached_carriages.uniq!
    @attached_carriages.compact!
    @carriages.delete(@attached_carriages.last)
    train.carriages.last.number = train.carriages.index(@attached_carriages.last) + 1
    message_attached_carriage(@attached_carriages.last, train)
    carriages_management
  end

  def disconnect_carriage_from_train
    trains_list_in_menu_with_enter
    train_index = gets.chomp
    list_attached_carriages_to_train(trains[train_index.to_i - 1])
    carriage_index = gets.chomp
    carriages_management if train_index == 'e' || carriage_index == 'e'
    disconnect_carriage_from_train_action(train_index, carriage_index)
  rescue RuntimeError => e
    puts e
  end

  def disconnect_carriage_from_train_action(train_index, carriage_index)
    train = trains[train_index.to_i - 1]
    carriage = train.carriages[carriage_index.to_i - 1]
    train.disattach_carriages(carriage)
    carriages.push(carriage)
    message_disattached_carriage(train, carriages.last)
    carriages_management
  end

  def carriage_info
    all_carriages
    carriage_index = gets.to_i
    carriage = @all_carriages[carriage_index - 1]
    view_carriage(carriage)
    carriages_management
  end
end
