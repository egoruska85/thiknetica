# frozen_string_literal: true

class PassengerCarriage < Carriage
  def initialize(number, volume)
    super(number, :passenger, volume)
  end

  def reserve_place
    raise 'Мест нет' if available_places.zero?

    super(1)
  end
end
