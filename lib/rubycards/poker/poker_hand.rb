require_relative '../hand'
require 'set'

module RubyCards
  module Poker
    class PokerHand < Hand

      include Comparable

      POKER_HANDS = [
        :high_card,
        :one_pair,
        :two_pair,
        :three_of_a_kind,
        :straight,
        :flush,
        :full_house,
        :four_of_a_kind,
        :straight_flush,
      ]

      def initialize(cards = [])
        super(cards)
        self.sort!
      end

      def <=>(other)
        cached_type = hand_type
        other_type = other.hand_type

        if POKER_HANDS.index(cached_type) != POKER_HANDS.index(other_type)
          return POKER_HANDS.index(cached_type) <=> POKER_HANDS.index(other_type)
        end

        if cached_type == :straight_flush || cached_type == :straight
          return cards.last <=> other.cards.last
        end

        cached_sorted_ranks = sorted_ranks
        cached_others_sorted_ranks = other.sorted_ranks

        if cached_sorted_ranks.count >= 1 && cached_sorted_ranks[-1][0] != cached_others_sorted_ranks[-1][0]
          return cached_sorted_ranks[-1][0] <=> cached_others_sorted_ranks[-1][0]
        elsif cached_sorted_ranks.count >= 2 && cached_sorted_ranks[-2][0] != cached_others_sorted_ranks[-2][0]
          return cached_sorted_ranks[-2][0] <=> cached_others_sorted_ranks[-2][0]
        elsif cached_sorted_ranks.count >= 3 && cached_sorted_ranks[-3][0] != cached_others_sorted_ranks[-3][0]
          return cached_sorted_ranks[-3][0] <=> cached_others_sorted_ranks[-3][0]
        elsif cached_sorted_ranks.count >= 4 && cached_sorted_ranks[-4][0] != cached_others_sorted_ranks[-4][0]
          return cached_sorted_ranks[-4][0] <=> cached_others_sorted_ranks[-4][0]
        elsif cached_sorted_ranks.count >= 5 && cached_sorted_ranks[-5][0] != cached_others_sorted_ranks[-5][0]
          return cached_sorted_ranks[-5][0] <=> cached_others_sorted_ranks[-5][0]
        end

        return 0
      end

      def hand_type
        sort!

        if is_flush?
          return is_straight? ? :straight_flush : :flush
        end

        return :straight if is_straight?

        cached_sorted_ranks = sorted_ranks
        case cached_sorted_ranks.last[1]
        when 1
          return :high_card
        when 2
          return cached_sorted_ranks[-2][1] == 2 ? :two_pair : :one_pair
        when 3
          return cached_sorted_ranks[-2][1] == 2 ? :full_house : :three_of_a_kind
        when 4
          return :four_of_a_kind
        end
      end

      def is_straight?
        sort!

        cards[1].to_i == (cards[0].to_i + 1) &&
        cards[2].to_i == (cards[1].to_i + 1) &&
        cards[3].to_i == (cards[2].to_i + 1) &&
        cards[4].to_i == (cards[3].to_i + 1)
      end

      def is_flush?
        suits = Set.new
        cards.each { |card|
          suits.add card.suit
        }
        suits.count == 1
      end

      def sorted_ranks
        ranks = {}
        cards.each { |card|
          ranks[card.to_i] ||= 0
          ranks[card.to_i] += 1
        }
        ranks.sort { |rank1, rank2|
          if rank1[1] != rank2[1]
            rank1[1] <=> rank2[1]
          else
            rank1[0] <=> rank2[0]
          end
        }
      end
    end
  end
end