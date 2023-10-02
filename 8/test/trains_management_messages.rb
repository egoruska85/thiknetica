# frozen_string_literal: true

require_relative 'dictonary'

module TrainsManagementMessages
  include Dictonary

  def trains_list_in_menu
    if trains.any?
      i = 0
      trains.each do |train|
        i += 1
        puts "#{i}) #{train.number}(#{train.type})"
      end
    else
      puts NO_CREATED_TRAINS_MESSAGE
    end
    print ENTER_NUMBER_TRAIN
  end

  def trains_list_in_menu_without_enter
    if trains.any?
      i = 0
      trains.each do |train|
        i += 1
        puts "#{i}) #{train.number}(#{train.type})"
      end
    else
      puts NO_CREATED_TRAINS_MESSAGE
    end
  end

  def trains_list_in_menu_with_enter
    if trains.any?
      i = 0
      trains.each do |train|
        i += 1
        puts "#{i}) #{train.number}(#{train.type})"
      end
    else
      puts NO_CREATED_TRAINS_MESSAGE
    end
    print ENTER_TRAIN
  end

  def message_create_train(train)
    puts "Создан позед с номером #{train.number}, тип: #{train.type}, производитель: #{train.name_manufacturer}"
  end

  def message_add_route_to_train(route)
    puts "К поезду присвоен маршрут #{route.start_station.name}=>#{route.finish_station.name}"
  end

  def show_trains
    @trains.each_with_index do |train, index|
      puts "#{index + 1} - Поезд №  #{train.number}, тип: #{train.type}, количество вагонов: #{train.carriages.size};"
      train.carriages.each do |carriage|
        view_carriage(carriage)
      end
    end
  end

  def trains_control_message
    puts
  end
end
