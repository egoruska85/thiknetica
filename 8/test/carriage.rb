# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Style/Documentation

require_relative 'manufacturer'
require_relative 'validator'

class Carriage
  include Manufacturer
  include Validator

  attr_reader :type, :reserved_places
  attr_accessor :number

  def initialize(number, type, volume)
    @number = number
    @volume = volume
    @type = type
    @reserved_places = 0
  end

  def available_places
    @volume - @reserved_places
  end

  def reserve_place(quantity)
    @reserved_places += quantity
  end
end
