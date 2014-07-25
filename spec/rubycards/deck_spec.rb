require 'spec_helper'

include RubyCards

describe Deck do
  subject(:deck) { Deck.new }

  describe '#initialize' do
    it 'initializes 52 cards' do
      deck.cards.count.should == 52
      # test indexing
      deck[0].should be_a Card
      # test enumerability
      deck.each { |card| card.should be_a Card }
    end
  end

  describe '#shuffle!' do
    it 'shuffles the cards' do
      cards_before_shuffling = deck.cards.dup
      deck.shuffle!
      deck.cards.should_not == cards_before_shuffling
    end

    it 'returns itself' do
      should == deck.shuffle!
    end
  end

  describe '#draw' do
    it 'draws a single card from the deck' do
      first_card = deck.cards.first
      cards_expected_after_draw = deck.cards[1..-1]
      deck.draw.should == first_card
      deck.cards.should == cards_expected_after_draw
    end
  end

  describe '#empty?' do
    context 'empty deck' do
      it 'returns true' do
        deck.cards.count.times { deck.draw }
        expect(deck).to be_empty
      end
    end

    context 'full deck' do
      it 'returns false' do
        expect(deck).not_to be_empty
      end
    end
  end

  describe "#cut!" do
    context 'cutting the first card' do
      it 'cuts the cards' do
        cards_before_cutting = deck.cards.dup

        deck.cut!(0)

        deck.cards[0].suit.should == cards_before_cutting[1].suit
        deck.cards[0].rank.should == cards_before_cutting[1].rank

        deck.cards[-1].suit.should == cards_before_cutting[0].suit
        deck.cards[-1].rank.should == cards_before_cutting[0].rank
      end

      it 'should return the same number of cards' do
        cards_before_cutting = deck.cards.dup

        deck.cut!(0)

        deck.cards.count.should == cards_before_cutting.count
      end
    end

    context 'cutting the second card' do
      it 'cuts the cards' do
        cards_before_cutting = deck.cards.dup

        deck.cut!(1)

        deck.cards[0].suit.should == cards_before_cutting[2].suit
        deck.cards[0].rank.should == cards_before_cutting[2].rank

        deck.cards[-2].suit.should == cards_before_cutting[0].suit
        deck.cards[-2].rank.should == cards_before_cutting[0].rank
        deck.cards[-1].suit.should == cards_before_cutting[1].suit
        deck.cards[-1].rank.should == cards_before_cutting[1].rank
      end

      it 'should return the same number of cards' do
        cards_before_cutting = deck.cards.dup

        deck.cut!(1)

        deck.cards.count.should == cards_before_cutting.count
      end
    end
  end
end
