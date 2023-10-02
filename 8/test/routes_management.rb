# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Style/Documentation

require_relative 'dictonary'
require_relative 'routes_management_messages'
require_relative 'route'

module RoutesManagement
  include Dictonary
  include RoutesManagementMessages

  ROUTES_MENU_LIST = [
    'создание маршрута',
    'добавить станции в маршрут',
    'удалить станции из маршрута',
    'любое значение для возврата в корневое меню'
  ].freeze

  def routes_management
    loop do
      view_title(2)
      choices_list(ROUTES_MENU_LIST, false)
      case gets.to_i
      when 1 then create_route
      when 2 then add_station_to_routes
      when 3 then delete_station_from_routes
      else main_menu
      end
    end
  end

  def create_route
    loop do
      view_title(2)
      stations_list_in_menu_for_route
      enter_station_first = gets.chomp
      enter_station_last = gets.chomp
      routes_management if enter_station_first == 'e' || enter_station_last == 'e'
      create_route_action(enter_station_first.to_i - 1, enter_station_last.to_i - 1)
    end
  rescue RuntimeError => e
    puts e
  end

  def create_route_action(first_station, last_station)
    route = Route.new(stations[first_station], stations[last_station])
    routes << route
    message_create_route(route)
    routes_management
  end

  def add_station_to_routes
    routes_list_in_add_station
    print ENTER_ROUTE
    route_index = gets.chomp
    route = routes[route_index.to_i - 1]
    enter_station_to_route(route)
    station_index = gets.chomp
    routes_management if station_index == 'e' || route_index == 'e'
    station = @available_stations[station_index.to_i - 1]
    add_station_to_routes_action(route, station)
  end

  def add_station_to_routes_action(route, station)
    route.add_station(station)
    message_add_station_to_route(route.stations[-2])
    add_station_to_routes
  end

  def delete_station_from_routes
    routes_list_in_add_station
    print ENTER_ROUTE
    route_index = gets.chomp
    routes_management if route_index == 'e'
    route = routes[route_index.to_i - 1]
    route_stations_list(route)
    print ENTER_STATION_FOR_DELETE
    station_index = gets.chomp
    routes_management if station_index == 'e'
    delete_station_from_route_action(route, station_index)
  end

  def delete_station_from_route_action(route, station_index)
    delete_station_from_routes_message(route.stations[station_index.to_i - 1])
    route.destroy_station(route.stations[station_index.to_i - 1])
  end

  def route_stations_list(route)
    i = 0
    route.stations.each do |station|
      i += 1
      puts "#{i}) #{station.name}"
    end
  end
end
