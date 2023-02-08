require_relative 'company'
class Wagon
  include Company
  attr_reader :type, :number
  def initialize
    @type = nil
  end
end
