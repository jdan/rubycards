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

    it "initializes four suits" do
      suits = deck.cards.group_by { |c| c.suit }
      suits.count.should == 4
    end

    ["Clubs", "Diamonds", "Hearts", "Spades"].each do |suit|
      it "initializes 13 cards for #{suit}" do
        cards = deck.cards.select { |c| c.suit == suit }
        cards.count.should == 13
      end

      it "should include ranks of different ranks" do
        cards = deck.cards.select { |c| c.suit == suit }
        cards.group_by { |x| x.rank }.count.should == 13
      end
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
end
