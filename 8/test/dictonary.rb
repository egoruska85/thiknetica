# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective

module Dictonary
  COMMANDS = { 1 => 'Менеджер станций', 2 => 'Менеджер маршрутов', 3 => 'Менеджер поездов',
               4 => 'Менеджер вагонов' }.freeze

  SMALL_SECTION_SEPARATOR = '_____________________________________________________________________________'

  NO_CREATED_STATIONS_MESSAGE = 'НЕТУ СОЗДАННЫХ СТАНЦИЙ'
  ENTER_NAME_STATION = 'Введите название станции(e- Выход): '

  NO_CREATED_TRAINS_MESSAGE = 'НЕТУ СОЗДАННЫХ ПОЕЗДОВ'
  ENTER_NUMBER_TRAIN = 'Введите номер поезда[ббч-чч] (e -Выход): '

  ENTER_STATION_FROM_LIST = 'Выберите 2 станции из списка (e- Выход): '
  ENTER_STATION_TO_ROUTE = 'Выберите станцию для добаления в маршрут (e -Выход): '
  NO_AVAILABLE_STATIONS = 'Нету доступных станций для этого маршрута!'
  ENTER_ROUTE = 'Выберите маршрут из списка: '
  ENTER_STATION_FOR_DELETE = 'Выберите станцию из списка для удаления (e -Выход): '
  ENTER_MANUFACTURER_NAME = 'Введите производителя (e -Выход): '
  TYPE = "1) Пассажирский\n2) Грузовой\nВведите тип позда (e -Выход): "
  ENTER_TRAIN = 'Выберите поезд который хотите выбрать (e - Назад): '
  ACTION_TYPE = "Переместить на одну станцию\n1)вперёд\n2)назад\ne)Выход"

  ENTER_TRAINS_ASSIGN_ROUTE = 'Выберите поезд котоому присвоить маршрут (e - Выход): '
  ENTER_CARRIAGE = 'Выберите вагон из списка (е -Выход): '
  NO_AVAILABLE_OR_CREATED_CARRIAGES = 'Нету созданных или доступных вагонов'
  LIST_ATTACHED_CARRIAGES = '############################## Список занятых вагонов ###################################'

  ADD_VOLUME_CARGO = 'Место для груза зарезервировано'
  ADD_SEAT_PASSENGER = 'Место для пассажира зарезервировано'

  TAB = "\n\t\t\t\t\t"
end
