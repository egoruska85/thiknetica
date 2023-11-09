require_relative 'deck'
require_relative 'dictonary'

class Round
  include Dictonary

  attr_reader :user, :diller, :deck
  attr_accessor :bank

  def initialize(user, diller, deck, bank)
    @user = user
    @diller = diller
    @deck = deck
    @bank = bank
  end

  def start
    set_winnings
    first_round
    second_round
    total_score
    define_winner
    update_cards!
    puts '__________________________________________'
  end

  def first_round
    2.times { take_card(user) }
    user.show_info

    2.times { take_card(diller) }
    diller.diller_hide_cards
    puts "На кону #{bank}$"
  end

  def second_round
    puts "Количество карт в колоде: #{deck.deck.count}(#{@deck.inspect})"
    open = false
    case make_choice
    when 2
      take_card user
    when 3
      open = true
    end
    take_card(diller) if diller.card_points < THRESHOLD && !open
  end

  private

  def take_card(player)
    player.hand.push(deck.take_card)
  end

  def set_winnings
    user.put_to_win(10)
    diller.put_to_win(10)
    @bank += 20
  rescue ArgumentError => e
    print e.message
  end

  def total_score
    system('cls')
    user.show_info
    diller.show_info
    puts "На кону #{bank}$"
  end

  def make_choice
    puts '1 - пропустить'
    puts '2 - взять карту'
    puts '3 - открыться'
    print 'Выбор: '
    choice = gets.chomp.to_i
  raise StandardError unless (1..3).include? choice

  choice
  rescue StandardError
    puts 'Вы что-то сделали не то, попробуйте еще.'
  retry
  end

  def define_winner
    if user.card_points > LIMIT
      print 'Перебор! '
    diller_win
    elsif user_wins?
      user_win
    elsif diller_wins?
      diller_win
    else
      tie
    end
  end

  def diller_wins?
    diller.card_points > user.card_points && diller.card_points <= LIMIT
  end

  def user_wins?
    user.card_points > diller.card_points || diller.card_points > LIMIT
  end

  def user_win
    puts "#{user.name} выйграл!"
    cash_to(user)
  end

  def diller_win
    puts "#{diller.name}-(Диллер) выйграл!"
    cash_to(diller)
  end

  def tie
    puts 'Ничья'
    cash_to(nil)
  end

  def cash_to(player)
  if player
    player.money_count += bank
  else
    split = bank / 2
    diller.money_count += split
    user.money_count += split
  end
    self.bank = 0
  end

  def update_cards!
    user.hand.clear
    diller.hand.clear
  end

end
