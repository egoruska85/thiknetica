# frozen_string_literal: true

require_relative 'dictonary'

module ControlInterface
  include Dictonary

  ERROR = /^[a-z]*$/i.freeze

  def manage_passenger_and_cargo
    trains_list_in_menu
    train_index = gets.chomp
    train = trains[train_index.to_i - 1]
    list_attached_carriages_to_train(train)
    carriage_index = gets.chomp
    carriages_management if carriage_index == 'e' || train_index == 'e'
    carriage = train.carriages[carriage_index.to_i - 1]
    manage_passenger_and_cargo_action(carriage)
  end

  def manage_passenger_and_cargo_action(carriage)
    entered_carriage(carriage)
    passenger_carriage_reserve_place(carriage) unless carriage.is_a?(CargoCarriage)
    cargo_carriage_reserve_place(carriage) unless carriage.is_a?(PassengerCarriage)
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def cargo_carriage_reserve_place(carriage)
    select_add_place
    volume = gets.to_i
    carriage.reserve_place(volume)
    message_add_volume_to_carriage(carriage)
    view_carriage(carriage)
    manage_passenger_and_cargo
  end

  def passenger_carriage_reserve_place(carriage)
    carriage.reserve_place
    message_add_volume_to_carriage(carriage)
    manage_passenger_and_cargo
  end

  def trains_control
    trains_list_in_menu_without_enter
    train_index = gets.chomp
    puts ACTION_TYPE
    action = gets.chomp
    trains_control_action(train_index, action)
  rescue RuntimeError => e
    puts e
    trains_management
  end

  def trains_control_action(train_index, action)
    enter_train = trains[train_index.to_i - 1]
    if action == '1'
      enter_train.move_to_next_station
    elsif action == '2'
      enter_train.move_to_previous_station
    else
      trains_management
    end
    train_move_message(enter_train)
    trains_management
  end
end
