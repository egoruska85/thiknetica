# frozen_string_literal: true

require_relative 'dictonary'

module RoutesManagementMessages
  include Dictonary

  def stations_list_in_menu_for_route
    if stations.any?
      i = 0
      stations.each do |station|
        i += 1
        puts "#{i}) #{station.name}"
      end
    else
      no_created_stations_message
    end
    enter_station_from_list
  end

  def routes_list_in_add_station
    return unless routes.any?

    i = 0
    routes.each do |route|
      i += 1
      puts "#{i}) #{route.start_station.name}=>#{route.finish_station.name}"
    end
  end

  def enter_station_from_list
    print ENTER_STATION_FROM_LIST
  end

  def enter_station_to_route(route)
    removal_existing_stations(route)
    print ENTER_STATION_TO_ROUTE
  end

  def message_create_route(route)
    puts "Создан маршрут со станциями #{route.start_station.name}=>#{route.finish_station.name}"
    puts SMALL_SECTION_SEPARATOR
  end

  def no_created_stations_message
    puts NO_CREATED_STATIONS_MESSAGE
    stations_management
  end

  def message_add_station_to_route(station)
    puts "Добавлена станция #{station.name}"
    puts SMALL_SECTION_SEPARATOR
  end

  def delete_station_from_routes_message(station)
    puts "Удалена станция #{station.name}"
  end

  def removal_existing_stations(route)
    @available_stations = stations.clone
    route.stations.each { |station| @available_stations.delete(station) }
    puts 'Доступные станции'
    puts NO_AVAILABLE_STATIONS if @available_stations.empty?
    i = 0
    @available_stations.each do |station, _index|
      i += 1
      puts "#{i})#{station.name}; "
    end
  end
end
