class CargoTrain < Train
  attr_reader :train_type

  def initialize(train_number)
    @train_type = 'грузовой'
    super
  end

  def add_wagon(wagon)
    super if wagon.type == 'грузовой'
  end
end
