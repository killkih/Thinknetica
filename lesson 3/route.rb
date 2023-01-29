class Route
  attr_reader :start_station, :final_station, :stations

  def initialize(start_station, final_station)
    @start_station = start_station
    @final_station = final_station
    @stations = []
  end

  def add_pop_station(operation, station)
      if operation == "add"
        @stations << station
      elsif operation == "pop"
        @stations.delete(station)
      end
  end

  def print_route
    puts "Текущий маршрут: #{@start_station} -> #{@stations.join(' -> ')} -> #{final_station}"
  end
end
