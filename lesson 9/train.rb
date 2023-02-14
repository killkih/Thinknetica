require_relative 'instance_counter'
require_relative 'company'
require_relative 'validation'
require_relative 'accessors'
class Train
  include Company
  include InstanceCounter
  include Validation
  extend Accessors
  attr_accessor :route
  attr_reader :number, :wagons

  self.attr_accessor_with_history(:speed)

  NUMBER_FORMAT = /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/i
  self.validate(:number, :presense)
  self.validate(:number, :format, NUMBER_FORMAT)

  @@trains = []
  def self.find(train_number)
    @@trains.find { |train| train.number == train_number }
  end

  def initialize(train_number)
    @number = train_number
    @speed = 0
    @wagons = []
    validate!
    @@trains << self
    register_instance
  end

  def add_wagon(wagon)
    @wagons << wagon if wagon.type == train_type && speed.zero?
  end

  def pop_wagon
    @wagons.pop if speed.zero?
  end

  def add_route(route)
    self.route = route
    @index = 0 # Индекс нужен для перемещения поезда
    self.route.stations[@index].add_train(self)
  end

  def move_forward
    return if next_station.nil?

    current_station.delete_train(self)
    next_station.add_train(self)
    @index += 1
  end

  def move_back
    return if back_station.nil?

    current_station.delete_train(self)
    back_station.add_train(self)
    @index -= 1
  end

  def stop
    self.speed = 0
  end

  def current_station
    route.stations[@index]
  end

  def next_station
    return unless route.stations.length != @index + 1

    route.stations[@index + 1]
  end

  def back_station
    return if @index - 1 < 0

    route.stations[@index - 1]
  end


  def enumeration_wagons(&block)
    @wagons.each { |wagon| block.call(wagon) }
  end

end
