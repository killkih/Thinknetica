class Train
  attr_accessor :speed, :route
  attr_reader :number, :wagons

  def initialize(train_number)
    @number = train_number
    @speed = 0
    @wagons = []
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
    else
      puts "Поезд на конечной станции!"
    end
  end

  def move_back
    if back_station != nil
      current_station.delete_train(self)
      back_station.add_train(self)
      @index -= 1
    else
      puts "Поезд на станции отправления!"
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
