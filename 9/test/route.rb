# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Style/Documentation

require_relative 'instance_counter'
require_relative 'validation'

class Route
  attr_reader :stations

  include InstanceCounter

  EQUALS_STATION_ERROR = 'Начальная и конечная станции совпадают'

  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]

    unless start_station.is_a?(Station) && finish_station.is_a?(Station)
      raise NO_EXIST_STATION_ERROR
    end

    raise EQUALS_STATION_ERROR if start_station == finish_station

    register_instance
  end

  def add_station(station)
    stations.insert(-2, station).uniq
  end

  def destroy_station(station)
    return if [start_station, finish_station].include?(station)

    stations.delete(station)
  end

  def start_station
    stations.first
  end

  def finish_station
    stations.last
  end
end
