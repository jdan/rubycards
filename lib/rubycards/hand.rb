class Hand

  attr_reader :cards

  def initialize(cards = [])
    @cards = cards
  end

  def add(card)
    @cards << card if card.instance_of? Card
  end

  def to_s
    @cards.map(&:to_s).inject(:next)
  end

end