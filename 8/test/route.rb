require_relative 'instance_counter'
require_relative "validator"

class Route
  attr_reader :stations

  include InstanceCounter
  include Validator

  def initialize(start, finish)
    @stations = [start, finish]
    validate!
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
