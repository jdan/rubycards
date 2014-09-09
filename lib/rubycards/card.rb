# encoding: utf-8
require 'colored'

module RubyCards

  # Class representation of a standard playing card. (French Design: 52 cards)
  class Card

    include Comparable

    attr_reader :joker

    CLUB    = '♣'
    DIAMOND = '♦'
    HEART   = '♥'
    SPADE   = '♠'

    # Returns a new card instance.
    #
    # @param rank [String, Integer] The rank of the card
    # @param suit [String] The suit of the card
    # @param joker [String] The value of the joker, if the card is a joker
    # @return [Card] The constructed card
    def initialize(rank = 'Ace', suit = 'Spades', joker = nil)
      @rank = rank_to_i(rank)
      @suit = suit_to_i(suit)
      @joker = joker
    end

    # Returns true if the card is a joker.
    #
    # @return [Boolean] true if the card is a joker, otherwise false
    def joker?
      @joker.nil? == false
    end

    # Returns the rank of the card with an optional `short` parameter
    # to limit face cards to one character.
    #
    # @param short [Boolean] Optional short setting
    # @return [String] The string representation of the card's rank
    def rank(short = false)
      if (2..10) === @rank
        @rank.to_s
      elsif @joker
        short ? "Joker" : "#{@joker} Joker"
      else
        h = { 11 => 'Jack', 12 => 'Queen', 13 => 'King', 14 => 'Ace' }
        h[@rank] && short ? h[@rank][0] : h[@rank]
      end
    end

    # Returns the suit of the card.
    #
    # @param glyph [Boolean] Optional setting to draw a unicode glyph in place
    # of a word
    # @return [String] The string (of glyph) representation of the card's suit
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

    # Returns the shortened rank, followed by a suit glyph.
    #
    # @return [String] The short representation of the card.
    def short
      "#{rank(true)}#{suit(true)}"
    end

    alias_method :inspect, :short

    # Compares the card to another.
    #
    # @param other [Card] A card to use in comparison
    # @return [Integer]
    def <=>(other)
      self.to_i <=> other.to_i
    end

    # Returns the integer representation of the rank.
    #
    # @return [Integer] The rank of the card
    def to_i
      @rank
    end

    # Returns the ASCII-art representation of the card.
    #
    # @return [String] The card drawn in ASCII characters.
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

    def same_as?(card)
      self.suit == card.suit && self.rank == card.rank
    end

    private

    # Converts the string representation of a rank to an integer.
    #
    # @param rank [String] The rank of the card as a string
    # @return [Integer] An integer representation of the rank (ordered)
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

    # Converts the string representation of a suit to an integer, in
    # alphabetical order.
    #
    # @param suit [String] The string representation of the suit
    # @return [Integer] An integer representation of the suit (ordered)
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
