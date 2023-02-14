require_relative 'company'
class Wagon
  include Company
  attr_reader :type, :number, :total_place, :taken_places

  def initialize(total_place)
    @number = @number = rand(1000).to_s
    @total_place = total_place
    @taken_places = 0
    @type = nil
  end

  def free_places
    @total_place - @taken_places
  end
end
