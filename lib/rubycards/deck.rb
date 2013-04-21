module RubyCards
  class Deck

    include Enumerable

    attr_reader :cards

    RANKS = [*2..10, 'Jack', 'Queen', 'King', 'Ace']
    SUITS = %w{ Clubs Diamonds Hearts Spades }

    # initialize a deck of cards using the RANKS and SUITS constants
    def initialize
      @cards = []

      RANKS.product(SUITS).each do |rank, suit|
        @cards << Card.new(rank, suit)
      end
    end

    # shuffle the deck
    def shuffle!
      @cards.shuffle!
    end

    # draw a card from the deck
    def draw
      @cards.shift
    end

    # determines if the deck is empty
    def empty?
      @cards.empty?
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

  end
end
