require_relative 'dictonary'

class Card
  include Dictonary

  attr_reader :name, :points

  def initialize(suit:, face:, points:)
    @name = "#{face}#{suit}"
    @points = points
  end

  def ace?
    points == POINTS[:A]
  end
end
