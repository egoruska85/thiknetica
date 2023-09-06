require_relative 'instancecounter'

class Route
  attr_reader :stations

  def initialize(start, finish)
    @stations = [start, finish]
    register
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
