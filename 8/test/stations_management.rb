# frozen_string_literal: true

require_relative 'dictonary'
require_relative 'stations_management_messages'
require_relative 'station'

module StationsManagement
  include Dictonary
  include StationsManagementMessages

  STATIONS_MENU_LIST = [
    'создание станции',
    'список станций',
    'любое значение для возврата в корневое меню'
  ].freeze

  def stations_management
    loop do
      view_title(1)
      choices_list(STATIONS_MENU_LIST, false)
      case gets.to_i
      when 1 then create_station
      when 2 then view_stations
      else main_menu
      end
    end
  end

  def create_station
    loop do
      stations_list_in_menu
      enter_name = gets.chomp
      stations_management if enter_name == 'e'
      stations << Station.new(enter_name.capitalize)
      message_create_station(stations.last)
    end
  rescue RuntimeError => e
    puts e
    retry
  end
end
