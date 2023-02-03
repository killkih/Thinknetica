class Route
  attr_reader :start_station, :final_station, :stations, :route_name

  def initialize(start_station, final_station, route_name)
    @stations = [start_station, final_station]
    @route_name = route_name
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def pop_station(station)
    @stations.delete(station)
  end

  def print_route
    puts "Текущий маршрут: "
    stations.each { |station| puts "#{station.name}" }
  end
end
