require_relative 'instance_counter'
class Route
  include InstanceCounter
  attr_reader :start_station, :final_station, :stations, :route_name

  ROUTE_NAME_FORMAT = /^[A-ZА-Я][a-zа-я]+ -{1} [A-ZА-Я][a-zа-я]+$/

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
    puts "Текущий маршрут: "
    stations.each { |station| puts "#{station.name}" }
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    raise 'Имя маршрута не может быть nil!' if route_name.nil?
    raise 'Неверный формат имени маршрута!' if route_name !~ ROUTE_NAME_FORMAT
  end
end
