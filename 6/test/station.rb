require_relative 'instance_counter'
require_relative "validator"

class Station
  include InstanceCounter
  include Validator
  attr_reader :trains
  attr_accessor :name

  def initialize(name)
    @name = name
    @trains = []
    validate!
    register_instance
  end


  def add_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def self.all
    ObjectSpace.each_object(Station).to_a # есть вариант создать массив класса и добавлять туда при инициализации в этот массив поезда и потом вывести через all.
  end

  def show_trains(type)
    trains.select{ |train| train.type == type }
  end
end
