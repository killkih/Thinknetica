require_relative 'route.rb'
require_relative 'station.rb'

class Train
  attr_accessor :speed, :wagons, :route
  attr_reader :train_number, :train_type

  def initialize(train_number, train_type, wagons)
    @train_number = train_number
    @train_type = train_type
    @wagons = wagons
    @speed = 0
  end

  def add_pop_wagon(operation)
    if speed == 0
      if operation == 'add'
        self.wagons += 1
      elsif operation == 'pop'
        self.wagons -= 1
      end
    end
  end

  def add_route(route)
    self.route = route
    @index = 0 #Индекс нужен для перемещения поезда
    self.route.stations[@index].add_train(self)
    puts "Текущая станция: #{route.stations[@index].name}"
  end

  def go_train(operation)
    if operation == 'forward'
      if next_station != nil
        current_station.delete_train(self)
        next_station.add_train(self)
        @index += 1
      end

    elsif operation == 'back'
      if back_station != nil
        current_station.delete_train(self)
        back_station.add_train(self)
        @index -= 1
      end
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

end
