class Hand

  attr_reader :cards

  # initialize with an array of cards
  def initialize(cards = [])
    @cards = []
    cards.each do |card|
      self << card
    end
  end

  # add a card if it is valid
  def add(card)
    @cards << card if card.instance_of? Card
  end

  # alias array push (<<) to add method
  alias_method :<<, :add

  # indexing
  def [](n)
    @cards[n]
  end

  # sorting
  def sort!
    @cards.sort!
  end

  # displaying the card icons
  # using extensions/string.rb for String#next
  def to_s
    @cards.map(&:to_s).inject(:next)
  end

end