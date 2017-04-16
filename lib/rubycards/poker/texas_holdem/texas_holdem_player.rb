require_relative '../../deck'
require_relative '../../hand'

module RubyCards
  module Poker
    class TexasHoldemPlayer
      attr_accessor :hand

      def initialize(name = nil)
        @name = name
        @hand = Hand.new
      end

      def best_hand(board)
        possible_hands(board).sort.last
      end

      def possible_hands(board)
        all_cards = Hand.new(@hand.cards + board.cards)
        all_cards.cards.combination(5).map { |combo|
          PokerHand.new(combo)
        }
      end

      def to_s
        @name.nil? ? "#{@hand}" : "#{@name}:\n#{@hand}"
      end
    end
  end
end