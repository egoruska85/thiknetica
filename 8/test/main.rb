# frozen_string_literal: true

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
    # @commands = {1 => 'Менеджер станций', 2 => 'Менеджер маршрутов', 3 => 'Менеджер поездов', 4 => 'Менеджер вагонов', 5 => 'Интерфейс управления поездами', 6 => 'Стастистика по станциям и поездам' }
  end

  def start
    print 'Запустить программу?: (Y)-Да; (N-Нет;):'
    enter = gets.chomp.capitalize
    main_menu if (enter == 'Y') || (enter == 'Н')
    puts 'Очень жаль что не попробовали в использовании нашу программу' if (enter == 'N') || (enter == 'Т')
  end

  def main_menu
    puts ''
    0.upto(100) do |i|
      sleep 0.01
      print '####' if i == 1
      print '####' if i == 5
      print '####' if i == 10
      print '# З ##' if i == 15
      print '####' if i == 20
      print '# А ##' if i == 25
      print '####' if i == 30
      print '# Г ##' if i == 35
      print '####' if i == 40
      print '# Р ##' if i == 45
      print '####' if i == 50
      print '# У ##' if i == 55
      print '####' if i == 60
      print '# З ##' if i == 65
      print '####' if i == 70
      print '# К ##' if i == 75
      print '####' if i == 80
      print '# А ##' if i == 85
      print '####' if i == 90
      print '####' if i == 95
      print '####' if i == 100
    end
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
