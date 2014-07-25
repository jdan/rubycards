require 'forwardable'

module RubyCards
  class Deck

    include Enumerable
    extend Forwardable

    attr_reader :cards

    def_delegators :cards, :empty?, :[], :shift

    alias :draw :shift

    RANKS = [*2..10, 'Jack', 'Queen', 'King', 'Ace']
    SUITS = %w{ Clubs Diamonds Hearts Spades }

    # Initializes a standard deck of 52 cards
    #
    # @param options [Hash] A set of options to consider
    # @return [Deck] A standard deck of cards
    def initialize(options = {})
      @cards = []

      RANKS.product(SUITS).each do |rank, suit|
        @cards << Card.new(rank, suit)
      end

      if options.any?
        @cards << Card.new(nil, nil, 'Red')
        @cards << Card.new(nil, nil, 'Black')
      end
    end

    # Shuffles the deck and returns it
    #
    # @return [Deck] The shuffled deck
    def shuffle!
      @cards.shuffle!
      self
    end

    # Enumerates the deck
    #
    # @param block [Proc] The block to pass into the enumerator
    # @return [Enumerable] The deck enumerator
    def each(&block)
      @cards.each(&block)
    end

    # Displays concise card representations in an array
    #
    # @return [String] The concise string representation of the deck
    def to_s
      "[ #{@cards.map(&:inspect).join ', '} ]"
    end

    # Displays a shortened version of the #to_s method for use in the
    # ruby console
    #
    # @return [String] A shortened string output of the deck
    def inspect
      "[ #{@cards[0..2].map(&:inspect).join ', '}, ..., #{@cards[-3..-1].map(&:inspect).join ', '} ]"
    end

  end
end
