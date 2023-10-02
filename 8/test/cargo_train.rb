# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Style/Documentation

class CargoTrain < Train
  def initialize(number)
    super(number, :cargo)
  end
end
