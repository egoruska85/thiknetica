# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Style/Documentation

class CargoTrain < Train
  attr_reader :type

  validate :number, :presence
  validate :number, :format, /^[a-z]{2}\d{1}.{1}[0-9]{2}$/i
  validate :number, :type, String

  def initialize(number)
    super(number)
    @type = :cargo
  end
end
