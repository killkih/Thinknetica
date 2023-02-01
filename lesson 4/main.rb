require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'freight_wagon'

trains = {}
stations = {}
routes = {}

menu = ['1 - Создать станцию', '2 - Создать поезд', '3 - Создать маршут, добавить/удалить станцию',
'4 - Назначить маршурт поезду', '5 - Прицепить вагон поезду', '6 - Отцепить вагон от поезда',
'7 - Переместить поезд по маршруту', '8 - Просмотреть список станций', '9 - Просмотреть список поездов на станции',
'0 - Выйти']

loop do
  puts "Выберите действие: "
  puts menu

  choice = STDIN.gets.chomp.to_i
  break if choice == 0

  case choice

  when 1
    loop do
      puts "Введите название станции(0 - выход): "
      name_station = STDIN.gets.chomp

      break if name_station.to_s == '0'

      stations[name_station] = Station.new(name_station)
      puts "Станция #{stations[name_station].name} создана!"
    end

  when 2
    puts "Введите номер поезда: "
    number_train = STDIN.gets.chomp
    puts "Введите тип поезда(1 - грузовой, 2 - пассажирский), 0 - выйти: "
    type_of_train = STDIN.gets.chomp

    case type_of_train.to_i

    when 1
      trains[number_train] = CargoTrain.new(number_train)
    when 2
      trains[number_train] = PassengerTrain.new(number_train)
    when 0
      break
    else
      puts "Ошибка при создании поезда!"
    end

    puts "Поезд с номером #{trains[number_train].train_number} создан!"
    gets

  when 3
    puts "Введите название маршрута: "
    name_route = STDIN.gets.chomp
    puts
    puts "Список станций: "
    puts stations.keys
    puts "Введите название начальной станции: "
    start_station_name = STDIN.gets.chomp
    puts "Введите название конечной станции: "
    final_station_name = STDIN.gets.chomp

    routes[name_route] = Route.new(stations[start_station_name], stations[final_station_name])
    loop do

      puts "Добавить станцию или удалить?"
      puts "1. Добравить"
      puts "2. Удалить"
      puts "0. Выйти"
      choice_action = STDIN.gets.chomp.to_i

      break if choice_action == 0
      case choice_action
      when 1
        puts "Введите название станции, которую хотите добавить: "
        name_station = STDIN.gets.chomp
        routes[name_route].add_station(stations[name_station])
      when 2
        puts "Введите название станции, которую хотите удалить: "
        name_station = STDIN.gets.chomp
        routes[name_route].pop_station(stations[name_station])
      when 0
        break
      end

      routes[name_route].print_route

      gets
    end

  when 4
    puts "Введите название маршрута: "
    name_route = STDIN.gets.chomp
    puts "Введите номер поезда: "
    number_train = STDIN.gets.chomp
    trains[number_train].add_route(routes[name_route])
    puts "Поезду #{trains[number_train].train_number} присвоен маршрут!"
    gets

  when 5
    puts "Введите номер поезда: "
    number_train = STDIN.gets.chomp

    if trains[number_train].train_type == 'грузовой'
      wagon = FreightWagon.new
    elsif name_class_train.train_type == 'пассажирский'
      wagon = PassengerWagon.new
    end

    trains[number_train].add_wagon(wagon)
    puts "Текущее кол-во вагонов: #{trains[number_train].wagons.size}"
    gets

  when 6
    puts "Введите номер поезда: "
    number_train = STDIN.gets.chomp

    trains[number_train].pop_wagon
    puts "Текущее кол-во вагонов: #{trains[number_train].wagons.size}"
    gets

  when 7
    puts "Введите номер поезда: "
    number_train = STDIN.gets.chomp

    puts "1 - Переместить вперёд"
    puts "2 - Переместить назад"
    puts "0 - Выйти"
    choice_action = STDIN.gets.chomp.to_i

    case choice_action

    when 1
      trains[number_train].move_forward
      puts "Вы прибыли на станцию #{trains[number_train].current_station}"
    when 2
      trains[number_train].move_back
      puts "Вы прибыли на станцию #{trains[number_train].current_station}"
    when 0
      break
    end

    gets

  when 8
    puts "Список станций:"
    puts stations.keys

    gets

  when 9
    puts "Введите название станции: "
    name_station = STDIN.gets.chomp

    puts "Список поездов на станции: "
    stations[name_station].trains.each { |train| puts train.train_number}

    gets

  else
    puts "Ошибка при выборе функции!"
  end

  system("clear")

end


