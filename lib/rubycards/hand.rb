require 'forwardable'

module RubyCards
  class Hand

    include Enumerable
    extend Forwardable

    attr_reader :cards

    def_delegators :cards, :<<, :[]

    alias :add :<<

    # Initializes a hand of cards
    #
    # @param cards [Array<Card>] A predetermined array of cards
    # @return [Hand] The generated hand
    def initialize(cards = [])
      @cards = []
      cards.each do |card|
        self << card
      end
    end

    # Sorts the hand and returns it
    #
    # @return [Hand] The sorted hand
    def sort!
      @cards.sort!
      self
    end

    # Draws n cards from a given deck and adds them to the Hand
    #
    # @param deck [Deck] The deck to draw from
    # @param n [Integer] The amount of cards to draw
    # @return [Hand] The new hand
    def draw(deck, n = 1)
      n.times do
        @cards << deck.draw unless deck.empty?
      end
      self
    end

    # Returns an enumator over the hand
    #
    # @param block [Proc] The block to pass into the enumerator
    # @return [Enumerator] An enumerator for the hand
    def each(&block)
      @cards.each(&block)
    end

    # Displays the hand using ASCII-art-style cards
    #
    # @return [String] The ASCII representation of the hand
    def to_s
      @cards.map(&:to_s).inject(:next)
    end

    # A shortened representation of the hand used for the console
    #
    # @return [String] A concise string representation of the hand
    def inspect
      "[ #{@cards.map(&:inspect).join ', '} ]"
    end

  end
end
