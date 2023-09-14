require_relative 'manufacturer'

class Carriage
  include Manufacturer

  attr_reader :type, :number
  def initialize(number, type)
    @number = number
    @type = type
    validate!
  end
end
