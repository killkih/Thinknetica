class PassengerTrain < Train
  attr_reader :train_type

  def initialize(train_number)
    @train_type = 'пассажирский'
    super
  end

  def add_wagon(wagon)
    super if wagon.type == 'пассажирский'
  end
end
