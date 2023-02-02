require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'freight_wagon'
require_relative 'wagon'

class Main
  def initialize
    @trains = {}
    @stations = {}
    @routes = {}
  end

  def start
    loop do
      show_menu
      choice = get_choice
      action(choice)
      puts
    end
  end

  def show_menu
    menu = ['1 - Создать станцию', '2 - Создать поезд', '3 - Создать маршут, добавить/удалить станцию',
      '4 - Назначить маршурт поезду', '5 - Прицепить вагон поезду', '6 - Отцепить вагон от поезда',
      '7 - Переместить поезд по маршруту', '8 - Просмотреть список станций', '9 - Просмотреть список поездов на станции',
      '0 - Выйти']
      puts "Выберите действие: "
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
    when 0
      exit
    end
  end

  #Данные методы должны вызываться через через метод actions, пользователь не должен иметь доступ к ним
  private

  def create_station
    puts "Введите название станции: "
    name_station = STDIN.gets.chomp

    @stations[name_station] = Station.new(name_station)
    puts "Станция #{@stations[name_station].name} создана!"
  end

  def create_train
    puts "Введите номер поезда: "
    number_train = STDIN.gets.chomp
    puts "Введите тип поезда(1 - грузовой, 2 - пассажирский): "
    type_of_train = STDIN.gets.chomp

    case type_of_train.to_i

    when 1
      @trains[number_train] = CargoTrain.new(number_train)
    when 2
      @trains[number_train] = PassengerTrain.new(number_train)
    else
      puts "Ошибка при создании поезда!"
    end

    puts "Поезд с номером #{@trains[number_train].train_number} создан!"
  end

  def create_route
    puts "Введите название маршрута: "
    name_route = STDIN.gets.chomp
    puts
    puts "Список станций: "
    puts @stations.keys
    puts "Введите название начальной станции: "
    start_station_name = STDIN.gets.chomp
    puts "Введите название конечной станции: "
    final_station_name = STDIN.gets.chomp

    @routes[name_route] = Route.new(@stations[start_station_name], @stations[final_station_name])
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
        @routes[name_route].add_station(@stations[name_station])
      when 2
        puts "Введите название станции, которую хотите удалить: "
        name_station = STDIN.gets.chomp
        @routes[name_route].pop_station(@stations[name_station])
      when 0
        break
      end

      @routes[name_route].print_route
    end

  end

  def assign_route
    puts "Введите название маршрута: "
    name_route = STDIN.gets.chomp
    puts "Введите номер поезда: "
    number_train = STDIN.gets.chomp
    @trains[number_train].add_route(@routes[name_route])
    puts "Поезду #{@trains[number_train].train_number} присвоен маршрут!"
  end

  def hook_wagon
    puts "Введите номер поезда: "
    number_train = STDIN.gets.chomp

    if @trains[number_train].train_type == 'грузовой'
      wagon = FreightWagon.new
    elsif @trains[number_train].train_type == 'пассажирский'
      wagon = PassengerWagon.new
    end

    @trains[number_train].add_wagon(wagon)
    puts "Текущее кол-во вагонов: #{@trains[number_train].wagons.size}"
  end

  def unhook_wagon
    puts "Введите номер поезда: "
    number_train = STDIN.gets.chomp

    @trains[number_train].pop_wagon
    puts "Текущее кол-во вагонов: #{@trains[number_train].wagons.size}"
  end

  def move_train
    puts "Введите номер поезда: "
    number_train = STDIN.gets.chomp

    puts "1 - Переместить вперёд"
    puts "2 - Переместить назад"

    choice = STDIN.gets.chomp.to_i

    case choice
    when 1
      @trains[number_train].move_forward
      puts "Вы прибыли на станцию #{@trains[number_train].current_station.name}"
    when 2
      @trains[number_train].move_back
      puts "Вы прибыли на станцию #{@trains[number_train].current_station.name}"
    end
  end

  def show_stations
    puts "Список станций:"
    puts @stations.keys
  end

  def show_trains_on_station
    puts "Введите название станции: "
    name_station = STDIN.gets.chomp

    puts "Список поездов на станции: "
    @stations[name_station].trains.each { |train| puts train.train_number}
  end

end

Main.new.start
