require_relative 'instance_counter'
require_relative 'validation'
require_relative 'station'
class Route
  include Validation
  include InstanceCounter
  attr_reader :start_station, :final_station, :stations, :route_name

  ROUTE_NAME_FORMAT = /^[A-ZА-Я][a-zа-я]+ -{1} [A-ZА-Я][a-zа-я]+$/

  self.validate(:route_name, :presense)
  self.validate(:route_name, :type, String)
  self.validate(:route_name, :format, ROUTE_NAME_FORMAT)

  def initialize(start_station, final_station, route_name)
    @stations = [start_station, final_station]
    @route_name = route_name
    validate!
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def pop_station(station)
    @stations.delete(station)
  end

  def print_route
    puts 'Текущий маршрут: '
    stations.each { |station| puts "#{station.name}" }
  end

end
