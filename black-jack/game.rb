require_relative 'player'
require_relative 'user'
require_relative 'diller'
require_relative 'action'
require_relative 'dictonary'
require_relative 'deck'
require_relative 'round'

class Game

  include Action
  include Dictonary

  attr_accessor :deck, :bank, :rounds
  attr_reader :user, :diller

  def initialize
    @diller = Diller.new
    puts EXPLANATION
    print "#{@diller.name} - #{USERNAME}"
    username = gets.chomp.capitalize
    @user = User.new(username)
    puts "Игра #{@user.name} против #{@diller.name}"
    @deck = Deck.new
    @bank = 0
    @rounds = 0
  end

  def start
    questions_to_action_game
    continue
  end

  def continue
    validate_deck!
    loop do
      Round.new(user, diller, deck, bank).start
      quantity_rounds
      enter_continue
    end
  end

  private

  def validate_deck!
    if deck.deck.count < 6

      puts 'Опа, а карты кончились, заново перемешаю колоду'
      @deck = Deck.new
    end
  end

  def enter_continue
    menu_for_continue
    choice = gets.chomp.to_i
    if choice == 1
      continue
    elsif choice == 2
      exit
    end
  rescue StandardError
    puts 'Неверный выбор, попробуйте еще.'
    retry
  end

end
