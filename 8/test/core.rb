# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Style/Documentation

require_relative 'dictonary'

class Core
  include Dictonary

  private

  attr_reader :stations, :routes, :trains, :carriages, :key, :attached_carriages, :available_carriages

  def show_command
    puts ''
    puts '###### КОМАНДЫ ДЛЯ УПРАВЛЕНИЯ ПРОГРАММОЙ ###### '
    commands_menu
  end

  def process_start(key)
    @key = key
    case key
    when 1 then stations_management
    when 2 then routes_management
    when 3 then trains_management
    when 4 then carriages_management
    else main_menu
    end
  end

  def tab
    print TAB
  end

  def commands_menu
    puts ''
    COMMANDS.each { |key, value| puts "#{tab}#{key})#{value}\n\n".upcase }
  end

  def choices_list(*options, extra_lines)
    puts 'Введите:'
    number = 1
    options[0].each do |option|
      puts "#{number} - #{option}"
      number += 1
    end

    puts TO_EXIT_APPLICATION_0 if extra_lines
    print '> ' if extra_lines
  end
end
