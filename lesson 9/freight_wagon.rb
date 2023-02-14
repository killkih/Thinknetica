require_relative 'wagon'
class FreightWagon < Wagon
  def initialize(total_place)
    super
    @type = 'грузовой'
  end

  def take_place(volume)
    @taken_places += volume if free_places >= volume
  end
end
