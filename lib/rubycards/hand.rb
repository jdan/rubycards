module RubyCards
  class Hand

    include Enumerable

    attr_reader :cards

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

    # Adds a card to the hand
    #
    # @param card [Card] The card to add to the hand
    # @return [Hand] The new hand
    def add(card)
      @cards << card if card.instance_of? Card
    end

    # alias array push (<<) to add method
    alias_method :<<, :add

    # Returns the nth card in the hand
    #
    # @param n [Integer] The index of the hand
    # @return [Card] The card at the nth index
    def [](n)
      @cards[n]
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

    # Returns the sum of the hand
    #
    # @return [Integer] The combined weights of the cards in the hand
    def sum
      this.cards.reduce { |memo, card| memo + card.to_i }
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
