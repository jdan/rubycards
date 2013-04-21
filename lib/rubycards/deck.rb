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
      self
    end

    # draw a card from the deck
    def draw
      @cards.shift
    end

    # determines if the deck is empty
    def empty?
      @cards.empty?
    end

    # indexing
    def [](n)
      @cards[n]
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

    # display concise card representations in an array
    def to_s
      "[ #{@cards.map(&:inspect).join ', '} ]"
    end

    # in the ruby console, only show the first and last three
    #   separated by ellipses
    def inspect
      "[ #{@cards[0..2].map(&:inspect).join ', '}, ..., #{@cards[-3..-1].map(&:inspect).join ', '} ]"
    end

  end
end
