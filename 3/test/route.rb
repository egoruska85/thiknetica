class Route
  attr_reader :start, :finish, :stations 
  def initialize(start, finish)
    @start = start
    @finish = finish
    @stations = []
  end
  def add_station(station, position)
    @stations.unshift @start unless @stations.include? @start
    @stations << @finish unless @stations.include? @finish
    @stations[position - 1] = station unless @stations.include?(station)
    @stations << @finish unless @stations.include? @finish
  end
  def destroy_station(station)
    @stations.delete(station)
  end
  def show_stations
    numeric = 0
    @stations.each { |station| puts "#{numeric += 1}) #{station}" }
  end
end
