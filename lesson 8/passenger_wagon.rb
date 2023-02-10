require_relative 'wagon'
class PassengerWagon < Wagon
  def initialize(total_place)
    super
    @type = 'пассажирский'
  end

  def take_place
    @taken_places += 1 if free_places > 0
  end
end
