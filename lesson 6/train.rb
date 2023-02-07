require_relative 'instance_counter'
require_relative 'company'
class Train
  include Company
  include InstanceCounter
  attr_accessor :speed, :route
  attr_reader :number, :wagons

  NUMBER_FORMAT = /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/i

  @@trains = []
  def self.find(train_number)
    @@trains.find { |train|  train.number == train_number }
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
    @wagons << wagon if wagon.type == self.train_type && self.speed.zero?
  end

  def pop_wagon
    @wagons.pop if self.speed.zero?
  end

  def add_route(route)
    self.route = route
    @index = 0 #Индекс нужен для перемещения поезда
    self.route.stations[@index].add_train(self)
  end

  def move_forward
    if next_station != nil
      current_station.delete_train(self)
      next_station.add_train(self)
      @index += 1
    end
  end

  def move_back
    if back_station != nil
      current_station.delete_train(self)
      back_station.add_train(self)
      @index -= 1
    end
  end

  def stop
    self.speed = 0
  end

  def current_station
    route.stations[@index]
  end

  def next_station
    if route.stations.length != @index + 1
      route.stations[@index + 1]
    end
  end

  def back_station
    unless @index - 1 < 0
      route.stations[@index - 1]
    end
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Номер поезда не может быть nil!" if number.nil?
    raise "Номер должен содержать от 5 до 6 символов!" if number.length < 5 || number.length > 6
    raise "Неверный формат номера поезда!" if number !~ NUMBER_FORMAT
  end
end
