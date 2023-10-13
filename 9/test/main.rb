# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Style/Documentation

require_relative 'dictonary'
require_relative 'stations_management'
require_relative 'routes_management'
require_relative 'trains_management'
require_relative 'carriages_management'
require_relative 'core'

class Main < Core
  include StationsManagement
  include RoutesManagement
  include TrainsManagement
  include CarriageManagement
  include Dictonary

  def initialize
    @carriages = []
    @attached_carriages = []
    @routes = []
    @stations = []
    @trains = []
    super
  end

  def start
    print 'Запустить программу?: (Y)-Да; (N-Нет;):'
    enter = gets.chomp.capitalize
    main_menu if (enter == 'Y') || (enter == 'Н')
    puts 'Очень жаль что не попробовали в использовании нашу программу' if (enter == 'N') || (enter == 'Т')
  end

  def main_menu
    puts "\n######## ПРОГРАММА-КОНСОЛЬ УПРАВЛЕНИЯ ПОЕЗДАМИ, СТАНЦИЯМИ ######## \n"
    loop do
      show_command
      print 'Введите номер интересующей вас команды: '
      command_number = gets.to_i
      break if command_number.zero?

      process_start(command_number)
    end
  end
end
Main.new.start
