# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Style/Documentation
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity

module Validation

  #EQUALS_STATION_ERROR = 'Начальная и конечная станции совпадают'
  #CREATED_STATION_EXIST_NAME = 'Станция с таким названием уже есть'
  #CREATED_TRAIN_EXIST_NUMBER = 'Поезд с таким номером уже есть'

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, type, *arg)
      @validations ||= []
      @validations << { type: type, name: name, arg: arg }
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def validate!
      self.class.validations.each do |params|
        value = get_instance_var_by_name(params[:name])
        send("validate_#{params[:type]}", value, *params[:arg])
      end
    end

    def validate_presence(value)
      raise 'Вы ничего не ввели' if value.nil? || value.empty?
    end

    def validate_format(value, format)
      raise 'Вы не правильно ввели формат номера поезда' if value !~ format
    end

    def validate_type(value, attribute_class)
      raise 'Объект другого класса' unless value.is_a?(attribute_class)
    end

    def get_instance_var_by_name(name)
      var_name = "@#{name}"
      instance_variable_get(var_name)
    end
  end
end
