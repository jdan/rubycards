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
    # options:
    #   :number_decks
    #     eg. Deck.new(number_decks: 2)
    #     will create 2 decks standard decks of 52
    #   :exclude_rank
    #     eg. Deck.new(exclude_rank: [2,'Jack'])
    #     will exclude 8 cards of the 2 and Jack rank
    #   :exclude_cards
    #     e.g. Deck.new(exclude_cards: [Card.new(5,'Spades'), Card.new('Jack','Hearts'), Card.new('Ace','Diamonds')])
    #     will exclude 3 cards 5 Spades, Jack Hearts and the Ace Diamonds
    #   :exclude_suit
    #     eg. Deck.new(exclude_suit: ['Hearts', 'Spades']
    #     will exclude 26 cards, All Hearts and Spades
    #
    # @return [Deck] A standard deck of cards
    def initialize(options={})
      @cards = []
      options[:exclude_rank] ||= []
      options[:number_decks] ||= 1
      options[:exclude_cards] ||= []
      options[:exclude_suit] ||= []

      options[:number_decks].times do
        (RANKS - options[:exclude_rank]).product(SUITS).each do |rank, suit|
          unless excluded_card(options[:exclude_cards], rank, suit) || (options[:exclude_suit].include? suit)
            @cards << Card.new(rank, suit)
          end
        end
      end
    end

    # Shuffles the deck and returns it
    #
    # @return [Deck] The shuffled deck
    def shuffle!
      @cards.shuffle!
      self
    end

    # Cuts the deck and returns it
    #
    # @param index [Integer] The index of the card that will be cut
    # @return [Deck] The cut deck
    def cut!(index)
      (0..index).each { @cards << @cards.shift }
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

    def excluded_card(excluded_cards, rank, suit)
      #check if card is in the excluded hash
      if excluded_cards.map(&:short).include? Card.new(rank, suit).short
        true
      else
        false
      end
    end

  end
end
