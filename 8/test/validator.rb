# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Style/Documentation
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity

module Validator
  NUMBER_FORMAT = /^[a-z]{2}\d{1}.{1}[0-9]{2}$/i.freeze
  STATION_FORMAT = /^[a-z]*$/i.freeze

  EQUALS_STATION_ERROR = 'Начальная и конечная станции совпадают'
  CREATED_STATION_EXIST_NAME = 'Станция с таким названием уже есть'
  CREATED_TRAIN_EXIST_NUMBER = 'Поезд с таким номером уже есть'
  ERROR_FORMAT_NUMBER_FOR_TRAINS = 'Вы не правильно ввели формат номера поезда'
  STOP_THE_TRAIN = 'Остановите пожалуйста поезд'

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    src = self
    stations = ObjectSpace.each_object(Station).to_a
    trains = ObjectSpace.each_object(Train).to_a
    stations.delete(src)
    trains.delete(src)
    unless defined?(src.number) || defined?(src.stations)
      raise 'Вы не правильно ввели формат станции' if src.name !~ STATION_FORMAT
      raise 'Вы должны ввести хотя бы две буквы' unless src.name.length > 1

      stations.each do |station|
        raise CREATED_STATION_EXIST_NAME if station.name == src.name
      end
      true
    end
    unless defined?(src.name) || defined?(src.stations)
      raise ERROR_FORMAT_NUMBER_FOR_TRAINS if src.number !~ NUMBER_FORMAT
      raise STOP_THE_TRAIN if src.speed.positive?

      trains.each do |train|
        raise CREATED_TRAIN_EXIST_NUMBER if train.number == src.number
      end
      true
    end
    return if defined?(src.name) || defined?(src.number)
    raise EQUALS_STATION_ERROR if src.stations.first == src.stations.last

    true
  end
end
