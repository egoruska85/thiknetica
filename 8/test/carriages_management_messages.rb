# frozen_string_literal: true

require_relative 'dictonary'

module CarriageManagementMessages
  include Dictonary

  def message_created_carrriage(carriage)
    puts "Создан вагон с типом #{carriage.type}"
  end

  def list_carriages_with_enter
    i = 0
    if carriages.any?
      carriages.each do |carriage|
        i += 1
        puts "#{i}) #{carriage.type} #{carriage.name_manufacturer}"
      end
    else
      puts NO_AVAILABLE_OR_CREATED_CARRIAGES
    end
    print ENTER_CARRIAGE
  end

  def all_carriages
    @all_carriages = carriages + @attached_carriages
    i = 0
    @all_carriages.each do |carriage|
      i += 1
      puts "#{i}) (#{carriage.type} #{carriage.name_manufacturer})"
    end
    print ENTER_CARRIAGE
  end

  def message_attached_carriage(carriage, train)
    puts "К поезду № #{train.number}(#{train.type}) присоеденён вагон #{carriage.number}(#{carriage.type})"
  end

  def list_attached_carriages_to_train(train)
    i = 0
    train.carriages.each do |carriage|
      i += 1
      puts "#{i}) #{carriage.number}(#{carriage.type})"
    end
    print ENTER_CARRIAGE
  end

  def message_disattached_carriage(train, carriage)
    puts "От поезда № #{train.number}(#{train.type}) отсоеденён вагон #{carriage.number}(#{carriage.type})"
  end

  def view_carriage(carriage)
    tab
    if carriage.type == :cargo
      puts "Вагон № #{carriage.number} объём(свободно/занято): #{carriage.available_places}/#{carriage.reserved_places}"
    elsif carriage.type == :passenger
      puts "Вагон № #{carriage.number} места(свободно/занято): #{carriage.available_places}/#{carriage.reserved_places}"
    end
  end

  def entered_carriage(carriage)
    puts "Вы выбрали вагон #{carriage.number}(#{carriage.type})"
  end

  def select_add_place
    print 'Введите объём груза в м2 : '
  end

  def message_add_volume_to_carriage(carriage)
    puts carriage.type == :cargo ? ADD_VOLUME_CARGO : ADD_SEAT_PASSENGER
  end
end
