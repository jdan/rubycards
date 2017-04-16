require_relative '../../deck'
require_relative '../../hand'

module RubyCards
  module Poker
    class TexasHoldemDealer
      attr_reader :board

      def initialize
        @deck = Deck.new
        @deck.shuffle!
        @board = Hand.new
        @burn = Hand.new
      end

      def deal(hands)
        hands.each { |hand|
          hand.draw(@deck, 2)
        }
      end

      def flop
        reveal(3)
      end

      def turn
        reveal(1)
      end

      def river
        reveal(1)
      end

      private

      def reveal(amount)
        @burn.draw(@deck, 1)
        @board.draw(@deck, amount)
      end
    end
  end
end