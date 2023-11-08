module Action
  require_relative 'dictonary'

  include Dictonary

  def questions_to_action_game
    puts ASK_TO_GAME
    answer = gets.chomp.upcase!
    if answer ==  'Y'
      continue
    elsif answer == 'N'
      exit
    else
      questions_to_action_game
    end
  end

  def menu_for_continue
    puts "Раунд #{rounds} окончен. Продолжим?"
    puts '1 - продолжить'
    puts '2 - выход'
    print 'Выбор: '
  end

  def quantity_rounds
    @rounds += 1
  end
end
