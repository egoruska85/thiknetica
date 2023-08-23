class Route
  attr_reader :stations


  def initialize(start, finish)
    @stations = [start, finish]
  end
  def add_station(station)
    stations.insert(-2, station).uniq
  end
  def destroy_station(station)
    stations.delete(station)
  end
  def start_station
    stations.first
  end

  def finish_station
    stations.last
  end
  def show_stations
    numeric = 0
    stations.each { |station| puts "#{numeric += 1}) #{station.name}" }
  end
end
