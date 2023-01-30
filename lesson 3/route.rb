require_relative 'station.rb'
class Route
  attr_reader :start_station, :final_station, :stations

  def initialize(start_station, final_station)
    @stations = [start_station, final_station]
  end

  def add_pop_station(operation, station)
      if operation == "add"
        @stations.insert(-2, station)
      elsif operation == "pop"
        @stations.delete(station)
      end
  end

  def print_route
    puts "Текущий маршрут: "
    stations.each { |station| puts "#{station.name}" }
  end
end
