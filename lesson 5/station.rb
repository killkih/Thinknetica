require_relative 'instance_counter'
class Station
  include InstanceCounter
  attr_reader :trains, :name

  @@instances = []
  def self.all
    @@instances
  end

  def initialize(name)
    @name = name
    @trains = []
    @@instances << self
    register_instance
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
