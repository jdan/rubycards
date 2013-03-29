# encoding: utf-8
require 'colored'

class Card

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
    if (1..10) === @rank
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

  # returns the numerical representation of the rank
  def to_i
    @rank
  end

  # draws a card picture
  def to_s
    # A simple template with numeric placeholders
    template = <<-TPL.gsub(/^\s+/,'')
      ,-------,
      | 0 4 7 |
      | 1 5 8 |
      | 2   9 |
      | 3 6 X |
      `-------'
    TPL

    # the patterns represent the configuration of glyphys
    #   in the form of 0123456789X
    case @rank
      when 1;  pattern = '_____X_____'
      when 2;  pattern = '____X_X____'
      when 3;  pattern = '____XXX____'
      when 4;  pattern = 'X__X___X__X'
      when 5;  pattern = 'X__X_X_X__X'
      when 6;  pattern = 'XX_X___XX_X'
      when 7;  pattern = 'X__XXXXX__X'
      when 8;  pattern = 'XXXX___XXXX'
      when 9;  pattern = 'XXXX_X_XXXX'
      when 10; pattern = 'XXXXX_XXXXX'
      when 11..14;
        pattern = '_____X_____'
    end

    # String enumeration doesn't include indicies?
    i = 0
    pattern.each_char do |c|
      # what character in the template are we going to match?
      # we look for whitespace surrounding the match characters
      #   due to how the escape codes for coloring text are formed
      if i == 10
        match = / X /
      else
        match = %r{ #{i} }
      end

      # replace X's with glyphs
      if c == 'X'
        if (1..10) === @rank
          template.sub!(match, " #{suit(true)} ")
        else
          template.sub!(match, " #{rank(true)} ")
        end
      # replace _'s with whitespaces
      else
        template.sub!(match, '   ')
      end

      i += 1
    end

    template
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
      when '1'..'9';      rank
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
