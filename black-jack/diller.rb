require_relative 'dictonary'

class Diller < Player
  include Dictonary

  def initialize(name = DILLER_NAME[0])
    super(name, 100)
  end

  def diller_hide_cards
    puts name
    hand.each { print '[*]' }
    puts "\nОчки: ? "
    show_balance
    puts '------------------------------'
  end
end
