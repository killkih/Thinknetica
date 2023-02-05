class PassengerTrain < Train
  attr_reader :train_type

  def initialize(train_number)
    super
    @train_type = 'пассажирский'
  end

  def add_wagon(wagon)
    super if wagon.type == 'пассажирский'
  end

end
