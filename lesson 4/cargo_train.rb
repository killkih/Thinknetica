class CargoTrain < Train
  attr_reader :train_type

  def initialize(train_number)
    super
    @train_type = 'грузовой'
  end

  def add_wagon(wagon)
    super if wagon.type == 'грузовой'
  end
end
