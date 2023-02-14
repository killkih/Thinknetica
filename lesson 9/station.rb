require_relative 'instance_counter'
require_relative 'validation'
class Station
  include InstanceCounter
  include Validation
  attr_reader :trains, :name

  STATION_NAME_FORMAT = /^[A-ZА-Я][a-zа-я]+$/

  self.validate(:name, :presense)
  self.validate(:name, :type, String)
  self.validate(:name, :format, STATION_NAME_FORMAT)

  @@instances = []
  def self.all
    @@instances
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
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

    puts "Пассажирских - #{passenger}, грузовых - #{freight}"
  end

  def enumeration_train(&block)
    @trains.each { |train| block.call(train) }
  end
end
