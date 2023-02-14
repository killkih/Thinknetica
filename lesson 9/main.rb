require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'freight_wagon'
require_relative 'wagon'
require_relative 'company'
require_relative 'instance_counter'

class Main
  def initialize
    @trains = []
    @stations = []
    @routes = []
  end

  def start
    loop do
      show_menu
      choice = get_choice
      action(choice)
      puts
    end
  end

  # Данные методы должны вызываться через через метод actions, пользователь не должен иметь доступ к ним
  private

  def show_menu
    menu = ['1 - Создать станцию', '2 - Создать поезд', '3 - Создать маршут, добавить/удалить станцию',
            '4 - Назначить маршурт поезду', '5 - Прицепить вагон поезду', '6 - Отцепить вагон от поезда',
            '7 - Переместить поезд по маршруту', '8 - Просмотреть список станций', '9 - Просмотреть список поездов на станции',
            '10 - Показать список вагонов у поезда', '0 - Выйти']
    puts 'Выберите действие: '
    puts menu
  end

  def get_choice
    STDIN.gets.chomp.to_i
  end

  def action(choice)
    case choice
    when 1
      create_station
    when 2
      create_train
    when 3
      create_route
    when 4
      assign_route
    when 5
      hook_wagon
    when 6
      unhook_wagon
    when 7
      move_train
    when 8
      show_stations
    when 9
      show_trains_on_station
    when 10
      wagons_info
    when 0
      exit
    end
  end

  def create_station
    begin
      puts 'Введите название станции: '
      station_name = STDIN.gets.chomp

      @stations << Station.new(station_name)
    rescue RuntimeError => e
      puts e.inspect
      retry
    end
    puts "Станция #{@stations.last.name} создана!"
  end

  def create_train
    begin
      puts 'Введите номер поезда: '
      train_number = STDIN.gets.chomp
      puts 'Введите тип поезда(1 - грузовой, 2 - пассажирский): '
      type_of_train = STDIN.gets.chomp

      case type_of_train.to_i

      when 1
        @trains << CargoTrain.new(train_number)
      when 2
        @trains << PassengerTrain.new(train_number)
      end
    rescue RuntimeError => e
      puts e.inspect
      retry
    end

    puts "Поезд с номером #{@trains.last.number} создан!"
  end

  def create_route
    puts 'Список станций: '
    @stations.each { |station| puts station.name }
    puts
    puts 'Введите название начальной станции: '
    start_station_name = STDIN.gets.chomp
    puts 'Введите название конечной станции: '
    final_station_name = STDIN.gets.chomp
    begin
      puts 'Введите название маршрута: '
      name_of_route = STDIN.gets.chomp

      start_station_object = nil
      final_station_object = nil

      @stations.each do |station|
        start_station_object = station if station.name == start_station_name
        final_station_object = station if station.name == final_station_name
      end

      @routes << Route.new(start_station_object, final_station_object, name_of_route)
    rescue RuntimeError => e
      puts e.inspect
      retry
    end
    loop do
      puts 'Добавить станцию или удалить?'
      puts '1. Добравить'
      puts '2. Удалить'
      puts '0. Выйти'
      choice_action = STDIN.gets.chomp.to_i

      break if choice_action == 0

      puts 'Введите название станции: '
      station_name = STDIN.gets.chomp

      added_station = nil
      @stations.each { |station| added_station = station if station.name == station_name }

      case choice_action
      when 1
        @routes.last.add_station(added_station)
      when 2
        @routes.last.pop_station(added_station)
      when 0
        break
      end
    end

    puts "Маршрут #{@routes.last.route_name} успешно создан!"
    @routes.last.print_route
  end

  def assign_route
    puts 'Введите название маршрута: '
    route_name = STDIN.gets.chomp
    puts 'Введите номер поезда: '
    train_number = STDIN.gets.chomp

    train_object = nil
    route_object = nil
    @routes.each { |route| route_object = route if route.route_name == route_name }
    @trains.each { |train| train_object = train if train.number == train_number }

    train_object.add_route(route_object)
    puts "Поезду #{train_object.number} присвоен маршрут #{route_object.route_name}!"
  end

  def hook_wagon
    puts 'Введите номер поезда: '
    train_number = STDIN.gets.chomp

    train_object = nil
    @trains.each { |train| train_object = train if train.number == train_number }

    if train_object.train_type == 'грузовой'
      puts 'Укажите объём вагона: '
      wagon_volume = STDIN.gets.chomp.to_i

      wagon = FreightWagon.new(wagon_volume)

      puts 'Сколько загрузить в вагон? '
      amount_volume = STDIN.gets.chomp.to_i

      wagon.take_place(amount_volume)
    elsif train_object.train_type == 'пассажирский'
      puts 'Укажите кол-во мест в вагоне: '
      wagon_places = STDIN.gets.chomp.to_i

      wagon = PassengerWagon.new(wagon_places)

      puts 'Занять место?'
      puts '1 - Да'
      puts '0 - Нет'
      choice = STDIN.gets.chomp.to_i

      wagon.take_place if choice == 1
    end

    train_object.add_wagon(wagon)
    puts "Текущее кол-во вагонов: #{train_object.wagons.size}"
  end

  def unhook_wagon
    puts 'Введите номер поезда: '
    train_number = STDIN.gets.chomp

    train_object = nil
    @trains.each { |train| train_object = train if train.number == train_number }

    train_object.pop_wagon
    puts "Текущее кол-во вагонов: #{train_object.wagons.size}"
  end

  def move_train
    puts 'Введите номер поезда: '
    train_number = STDIN.gets.chomp

    train_object = nil
    @trains.each { |train| train_object = train if train.number == train_number }

    puts '1 - Переместить вперёд'
    puts '2 - Переместить назад'

    choice = STDIN.gets.chomp.to_i

    case choice
    when 1
      train_object.move_forward
      puts "Вы прибыли на станцию #{train_object.current_station.name}"
    when 2
      train_object.move_back
      puts "Вы прибыли на станцию #{train_object.current_station.name}"
    end
  end

  def show_stations
    puts 'Список станций:'
    puts @stations.each { |station| puts station.name }
  end

  def show_trains_on_station
    puts 'Введите название станции: '
    station_name = STDIN.gets.chomp

    station_object = @stations.find { |station| station.name == station_name }

    puts 'Список поездов на станции: '
    station_object.enumeration_train do |train|
      puts "Номер - #{train.number} тип - #{train.train_type}, "
      "кол-во вагонов #{train.wagons.size}"
    end
  end

  def wagons_info
    puts 'Введите номер поезда: '
    train_number = STDIN.gets.chomp
    train_object = @trains.find { |train| train_number == train.number }

    if train_object.train_type == 'пассажирский'
      train_object.enumeration_wagons do |wagon|
        puts "Вагон - #{wagon.number}, тип - #{wagon.type}, " +
             "свободные места - #{wagon.free_places}, занятые места - #{wagon.taken_places}\n"
      end

    elsif train_object.train_type == 'грузовой'
      train_object.enumeration_wagons do |wagon|
        puts "Вагон - #{wagon.number}, тип - #{wagon.type}, " +
             "свободный объём - #{wagon.free_places}, занятый объём - #{wagon.taken_places}\n"
      end
    end
  end
end

Main.new.start
