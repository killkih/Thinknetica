require_relative 'route.rb'

class Train
  attr_accessor :speed, :wagons
  attr_reader :current_route, :train_number, :train_type

  def initialize(train_number, train_type, wagons)
    @train_number = train_number
    @train_type = train_type
    @wagons = wagons
    @speed = 0
    @index = 0 #Индекс нужен для current_route
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
    @route = route

    @current_route = @route.stations
    @current_route.unshift(@route.start_station)
    @current_route.push(@route.final_station)

    puts "Назначен маршрут следования: #{current_route.join(' -> ')}"

    puts "Текущая станция: #{current_station}"
  end

  def go_train(operation)
    if operation == 'forward'

      if current_route.length == @index + 1
        puts "Поезд прибыл на конечную станцию!"
      else
        @index += 1
      end

    elsif operation == 'back'
      if @index - 1 < 0
        puts "Поезд находится на станции отправления!"
      else
        @index -= 1
      end
    end
  end

  def current_station
    current_route[@index]
  end

  def next_station
    if current_route.length != @index + 1
      current_route[@index + 1]
    else
      puts "Поезд находится на конечной станции!"
    end
  end

  def back_station
    if @index - 1 < 0
      puts "Поезд находится на станции отправления!"
    else
      current_route[@index - 1]
    end
  end

end
