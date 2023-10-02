# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Style/Documentation

require_relative 'dictonary'

module StationsManagementMessages
  include Dictonary

  def view_title(key)
    puts "################################# #{COMMANDS[key].upcase} #############################################"
  end

  def stations_list_in_menu
    if stations.any?
      i = 0
      stations.each do |station|
        i += 1
        puts "#{i}) #{station.name}"
      end
    else
      puts NO_CREATED_STATIONS_MESSAGE
    end
    enter_name_station
  end

  def enter_name_station
    print ENTER_NAME_STATION
  end

  def message_create_station(station)
    puts "Создана станция с именем #{station.name}"
    puts SMALL_SECTION_SEPARATOR
  end

  def view_stations
    stations.each_with_index do |station, index|
      puts "#{index + 1}) #{station.name}: \n\n\tПоезда на станции:"
      station.trains.each_with_index do |train, index|
        puts "\tПуть № #{index + 1} #{train.number}; кол-во ввгонов #{train.carriages.size};"
        train.carriages.each do |carriage|
          view_carriage(carriage)
        end
      end
    end
  end
end
