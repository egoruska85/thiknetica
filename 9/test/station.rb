# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Style/Documentation

require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Station
  include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :trains
  attr_accessor :name

  strong_attr_accessor :name, String

  validate :name, :presence
  validate :name, :format, /^[a-z]*$/i

  def initialize(name)
    @name = name
    @trains = []
    validate!
    register_instance
  end

  def each_train(&block)
    trains.each(&block)
  end

  def add_train(train)
    trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def self.all
    ObjectSpace.each_object(Station).to_a
  end

  def show_trains(type)
    trains.select { |train| train.type == type }
  end
end
