class Hand

  attr_reader :cards

  def initialize(cards = [])
    @cards = cards
  end

  def add(card)
    @cards << card if card.instance_of? Card
  end

  alias_method :<<, :add

  def [](n)
    @cards[n]
  end

  def sort!
    @cards.sort!
  end

  def to_s
    @cards.map(&:to_s).inject(:next)
  end

end