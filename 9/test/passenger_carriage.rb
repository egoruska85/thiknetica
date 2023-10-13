# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Style/Documentation

class PassengerCarriage < Carriage
  def initialize(number, places = 36 )
    super(number, :passenger, places)
  end

  def reserve_place
    raise 'Мест нет' if available_places.zero?

    super(1)
  end
end
