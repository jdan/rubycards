module RubyCards
  class Hand

    include Enumerable

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
      self
    end

    # draw n cards from a deck
    def draw(deck, n = 1)
      n.times do
        @cards << deck.draw unless deck.empty?
      end
      self
    end

    # Enumerable#each
    def each(&block)
      @cards.each do |card|
        if block_given?
          block.call card
        else
          yield card
        end
      end
    end

    # displaying the card icons
    # using extensions/string.rb for String#next
    def to_s
      @cards.map(&:to_s).inject(:next)
    end

    # in the ruby console, call #inspect on each card
    #   and join with commas
    def inspect
      "[ #{@cards.map(&:inspect).join ', '} ]"
    end

  end
end