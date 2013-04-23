require 'spec_helper'

describe RubyCards::Deck do
  describe '#initialize' do
    it 'initializes 52 cards' do
      subject.cards.count.should == 52
      subject.cards.each { |card| card.should be_a RubyCards::Card }
    end
  end

  describe '#shuffle!' do
    it 'shuffles the cards' do
      cards_before_shuffling = subject.cards.dup
      subject.shuffle!
      subject.cards.should_not == cards_before_shuffling
    end

    it 'returns itself' do
      should == subject.shuffle!
    end
  end

  describe '#draw' do
    it 'draws a single card from the deck' do
      first_card = subject.cards.first
      cards_expected_after_draw = subject.cards[1..-1]
      subject.draw.should == first_card
      subject.cards.should == cards_expected_after_draw
    end
  end

  describe '#empty?' do
    context 'empty deck' do
      it 'returns true' do
        subject.cards.count.times { subject.draw }
        subject.empty?.should be_true
      end
    end

    context 'full deck' do
      it 'returns false' do
        subject.empty?.should be_false
      end
    end
  end
end
