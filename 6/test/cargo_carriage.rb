class CargoCarriage < Carriage
  def initialize(number)
    super(number, :cargo)
  end
end
