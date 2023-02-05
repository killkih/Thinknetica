class Wagon
  include Company
  attr_reader :type
  def initialize
    @type = nil
  end
end
