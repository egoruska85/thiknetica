# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Style/Documentation

require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validator'

class Train
  include Manufacturer
  include InstanceCounter
  include Validator

  attr_reader :type, :speed, :route, :carriages, :errors
  attr_accessor :number

  @@trains = []

  def initialize(number, type)
    @number = number
    @carriages = []
    @type = type
    @speed = 0
    @@trains << self
    validate!
    register_instance
  end

  def self.find(number_train)
    @@trains.find { |train| train.number == number_train }
  end

  def each_carriage(&block)
    @carriages.each(&block)
  end

  def move(speed)
    @speed = speed
  end

  def up_speed(speed)
    @speed += speed
    puts @speed
  end

  def down_speed(speed)
    @speed -= speed if @speed.positive?
    puts @speed
  end

  def stop
    @speed = 0
  end

  def move_to_next_station
    return unless next_station

    current_station.send_train(self)
    next_station.add_train(self)
    @number_station += 1
  end

  def move_to_previous_station
    return unless previous_station

    current_station.send_train(self)
    previous_station.add_train(self)
    @number_station -= 1
  end

  def attach_carriages(carriage)
    validate!
    validate_attach_carriage!(carriage)
    @carriages << carriage
    # @errors = []
    # @errors << [speed, type, carriage.type] if speed > 0 or type != carriage.type
  end

  def disattach_carriages(carriage)
    validate!
    validate_disattach_carriage!(carriage)
    @carriages.delete(carriage)
  end

  def show_carriages_quantity
    puts carriages.length
  end

  def enter_route(route)
    @route = route
    @number_station = 0
    current_station.add_train(self)
  end

  def next_station
    route.stations[@number_station + 1]
  end

  def previous_station
    # здесь нужна проверка иначе значение будет -1 и тода поезд будет перемещен на конечную станию
    route.stations[@number_station - 1] if @number_station.positive?
  end

  def current_station
    route.stations[@number_station]
  end

  private

  def validate_attach_carriage!(carriage)
    raise 'Данный тип поезда несовместим с подключаемым вагоном' unless type == carriage.type

    true
  end

  def validate_disattach_carriage!(_carriage)
    raise 'К поезду нет присоеденённых вагонов' unless @carriages.length.positive?

    true
  end
end
