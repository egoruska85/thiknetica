# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Style/Documentation

class CargoCarriage < Carriage
  def initialize(number, volume = 20)
    super(number, :cargo, volume)
  end

  def reserve_place(quantity)
    raise 'Недостаточно места.' if available_places < quantity

    super(quantity)
  end
end
