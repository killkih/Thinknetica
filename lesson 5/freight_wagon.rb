require_relative 'wagon'
class FreightWagon < Wagon
  def initialize
    @type = 'грузовой'
  end
end
