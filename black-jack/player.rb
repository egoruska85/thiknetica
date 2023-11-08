class Player

  attr_reader :name
  attr_accessor :money_count, :hand

  def initialize(name, money_count)
    @name = name
    @money_count = money_count
    @hand = []
  end

  def put_to_win(quantity)
    @money_count -= quantity
    #raise ArgumentError, @name.to_s if money_count.negative?
    raise ArgumentError, name.to_s if money_count.negative?
  end

  def show_cards
    hand.each do |card|
      print "[#{card.name}]"
    end
    puts
  end

  def show_card_points
    puts "Очки: #{card_points}"
  end

  def show_balance
    puts "Баланс: #{money_count}$"
  end

  def card_points
    max_points = hand.map(&:points).sum
    aces_count = hand.find_all(&:ace?).count
    ace_points_diff = Deck::POINTS[:A] - Deck::ACE_ALT_VALUE

    while aces_count.positive? && max_points > 21
      max_points -= ace_points_diff
      aces_count -= 1
    end
    max_points
  end

  def show_info
    puts name
    show_cards
    show_card_points
    show_balance
    puts '------------------------------'
  end

end
