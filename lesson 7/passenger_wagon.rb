 require_relative 'wagon'
 class PassengerWagon < Wagon
  attr_reader :free_places, :taken_places

  def initialize(places)
    @number = rand(1000).to_s
    @free_places = places
    @taken_places = 0
    @type = 'пассажирский'
  end

  def take_place
    if @free_places > 0
      @taken_places += 1
      @free_places -= 1
    end
  end
end
