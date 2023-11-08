require_relative 'card'
require_relative 'dictonary'

class Deck
  include Dictonary

  attr_accessor :deck

  def initialize
    @deck = []
    create_deck
    mix_deck!
  end

  def take_card
    @deck.pop
  end

  private

  def create_deck
    FACES.each do |face|
      SUITS.each do |suit|
        points = POINTS.key?(face.to_sym) ? POINTS[face.to_sym] : face.to_i
        @deck << Card.new(suit: suit, points: points, face: face)
      end
    end
  end

  def mix_deck!
    @deck.shuffle!
  end

end
