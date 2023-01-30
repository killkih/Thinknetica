require_relative 'train.rb'

class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
      @trains << train
  end

  def delete_train(train)
    @trains.delete(train)
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
