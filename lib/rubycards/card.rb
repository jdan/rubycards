# encoding: utf-8
require 'colored'

module RubyCards
  class Card

    include Comparable

    # constants for glyphs
    CLUB    = '♣'
    DIAMOND = '♦'
    HEART   = '♥'
    SPADE   = '♠'

    def initialize(rank = 'Ace', suit = 'Spades')
      @rank = rank_to_i(rank)
      @suit = suit_to_i(suit)
    end

    # returns the rank of the card
    # optional short parameter will limit face cards to one character
    def rank(short = false)
      if (2..10) === @rank
        @rank.to_s
      else
        h = { 11 => 'Jack', 12 => 'Queen', 13 => 'King', 14 => 'Ace' }
        h[@rank] && short ? h[@rank][0] : h[@rank]
      end
    end

    # returns the suit of a card
    # optional glyph parameter displays a colored unicode character
    def suit(glyph = false)
      case @suit
        when 1
          glyph ? CLUB.black.bold : 'Clubs'
        when 2
          glyph ? DIAMOND.red : 'Diamonds'
        when 3
          glyph ? HEART.red : 'Hearts'
        when 4
          glyph ? SPADE.black.bold : 'Spades'
      end
    end

    # returns the short rank, followed by suit icon
    def short
      "#{rank(true)}#{suit(true)}"
    end

    alias_method :inspect, :short

    # comparator
    def <=>(c)
      self.to_i <=> c.to_i
    end

    # returns the numerical representation of the rank
    def to_i
      @rank
    end

    alias :value, :to_i

    # draws a card picture
    def to_s
      # A simple template with X's as placeholders
      # YY represents the placement of the card's rank
      template = <<-TPL.gsub(/^\s+/,'')
        ╭───────╮
        | X X X |
        | X X X |
        | X YYX |
        | X X X |
        ╰───────╯
      TPL

      # the patterns represent the configuration of glyphys
      #   read from left to right, top to bottom
      # X means place a glyph, _ means clear the space
      case @rank
        when 2;  pattern = '_X_______X_'
        when 3;  pattern = '_X__X____X_'
        when 4;  pattern = 'X_X_____X_X'
        when 5;  pattern = 'X_X_X___X_X'
        when 6;  pattern = 'X_XX_X__X_X'
        when 7;  pattern = 'X_X_X_XXX_X'
        when 8;  pattern = 'X_XX_XXXX_X'
        when 9;  pattern = 'X_XXXXXXX_X'
        when 10; pattern = 'XXXX_XXXXXX'
        when 11..14;
          pattern = 'X_________X'
      end

      pattern.each_char do |c|
        # replace X's with glyphs
        if c == 'X'
          template.sub!(/X/, "#{suit(true)}")
        # replace _'s with whitespace
        else
          template.sub!(/X/, " ")
        end
      end

      # place the card rank (left-padded)
      template.sub(/YY/, rank(true).ljust(2))
    end

    private

    # converts the string representation of a rank to an integer
    def rank_to_i(rank)
      case rank.to_s
        when /^(a|ace)/i;   14
        when /^(k|king)/i;  13
        when /^(q|queen)/i; 12
        when /^(j|jack)/i;  11
        when '10';          10
        when '2'..'9';      rank
        else 0
      end
    end

    # converts the string representation of a suit to an integer
    # suits are ordered alphabetically
    def suit_to_i(suit)
      case suit
        when /^club/i;    1
        when /^diamond/i; 2
        when /^heart/i;   3
        when /^spade/i;   4
        else 0
      end
    end

  end
end
