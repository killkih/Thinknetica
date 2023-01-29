require_relative 'train.rb'

class Station
  attr_reader :trains_numbers, :name

  def initialize(name)
    @name = name
    @trains = []
    @trains_numbers = []
  end

  def add_train(train)
      @trains << train
      @trains_numbers << train.train_number
  end

  def delete_train(train)
    @trains.delete(train)
    @trains_numbers.delete(train.train_number)
  end

  def type_number
    passenger = 0
    freight = 0

    @trains.each do |train|
      if train.train_type.downcase == 'пассажирский'
        passenger += 1
      elsif train.train_type.downcase == 'грузовой'
        freight += 1
      end
    end

    puts "Пассажирских - #{passenger.to_s}, грузовых - #{freight.to_s}"
  end

end
