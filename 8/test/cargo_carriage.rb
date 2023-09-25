class CargoCarriage < Carriage
  def initialize(number, volume)
    super(number, :cargo, volume)
  end

  def reserve_place(quantity)
    raise "Недостаточно места." if available_places < quantity
    super(quantity)
  end
end
