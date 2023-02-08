require_relative 'wagon'
class FreightWagon < Wagon
  attr_reader :free_volume, :taken_volume

  def initialize(volume)
    @number = rand(1000).to_s
    @free_volume = volume
    @taken_volume = 0
    @type = 'грузовой'
  end

  def take_volume(volume)
    if @free_volume - volume >= 0
      @free_volume -=  volume
      @taken_volume += volume
    end
  end
end
