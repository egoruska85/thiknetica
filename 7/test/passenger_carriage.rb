class PassengerCarriage < Carriage
  def initialize(number, volume)
    super(number, :passenger, volume)
  end

  def reserve_place
    raise "Мест нет" if available_places == 0
    super(1)
  end
end
