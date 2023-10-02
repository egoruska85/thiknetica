# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Style/Documentation

class PassengerTrain < Train
  def initialize(number)
    super(number, :passenger)
  end
end
