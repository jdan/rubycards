require 'spec_helper'

include RubyCards

describe Deck do
  subject(:deck) { Deck.new }

  describe '#initialize' do
    it 'initializes 52 cards' do
      expect(deck.cards.count).to eq 52
      # test indexing
      expect(deck[0]).to be_a Card
      # test enumerability
      deck.each { |card| expect(card).to be_a Card }
    end

    it "initializes four suits" do
      suits = deck.cards.group_by { |c| c.suit }
      expect(suits.count).to be 4
    end

    ["Clubs", "Diamonds", "Hearts", "Spades"].each do |suit|
      it "initializes 13 cards for #{suit}" do
        cards = deck.cards.select { |c| c.suit == suit }
        expect(cards.count).to be 13
      end

      it "should include ranks of different ranks" do
        cards = deck.cards.select { |c| c.suit == suit }
        expect(cards.group_by { |x| x.rank }.count).to be 13
      end
    end
  end

  describe '#shuffle!' do
    it 'shuffles the cards' do
      cards_before_shuffling = deck.cards.dup
      deck.shuffle!
      expect(deck.cards).not_to eq cards_before_shuffling
    end

    it "should should shuffle the internal cards array" do
      expect(deck.instance_variable_get("@cards")).to receive(:shuffle!)
      deck.shuffle!
    end

    it 'returns itself' do
      expect(deck).to eq deck.shuffle!
    end
  end

  describe '#draw' do
    it 'draws a single card from the deck' do
      first_card = deck.cards.first
      cards_expected_after_draw = deck.cards[1..-1]
      expect(deck.draw).to be_same_as first_card
      expect(deck.cards).to eq cards_expected_after_draw
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

      it 'returns itself' do
        expect(deck).to eq deck.cut!(0)
        should == deck.cut!(0)
      end

      it 'cuts the cards' do
        cards_before_cutting = deck.cards.dup

        deck.cut!(0)

        expect(deck.cards[0].suit).to eq cards_before_cutting[1].suit
        expect(deck.cards[0].rank).to eq cards_before_cutting[1].rank

        expect(deck.cards[-1].suit).to eq cards_before_cutting[0].suit
        expect(deck.cards[-1].rank).to eq cards_before_cutting[0].rank
      end

      it 'should return the same number of cards' do
        cards_before_cutting = deck.cards.dup

        deck.cut!(0)

        expect(deck.cards.count).to eq cards_before_cutting.count
      end
    end

    context 'cutting the second card' do
      it 'cuts the cards' do
        cards_before_cutting = deck.cards.dup

        deck.cut!(1)

        expect(deck.cards[0].suit).to eq cards_before_cutting[2].suit
        expect(deck.cards[0].rank).to eq cards_before_cutting[2].rank

        expect(deck.cards[-2].suit).to eq cards_before_cutting[0].suit
        expect(deck.cards[-2].rank).to eq cards_before_cutting[0].rank
        expect(deck.cards[-1].suit).to eq cards_before_cutting[1].suit
        expect(deck.cards[-1].rank).to eq cards_before_cutting[1].rank
      end

      it 'should return the same number of cards' do
        cards_before_cutting = deck.cards.dup

        deck.cut!(1)

        expect(deck.cards.count).to eq cards_before_cutting.count
      end
    end
  end

  describe 'excluded whole Rank cards' do
    let (:deck_excluding_1) { Deck.new(exclude_rank: [5]) }
    let (:deck_excluding_2) { Deck.new(exclude_rank: [5,7]) }
    let (:deck_excluding_3) { Deck.new(exclude_rank: [5, 'Jack', 'Ace']) }

    describe '#initialize' do
      # Remove one card rank from deck
      it('initializes 48 cards') { expect(deck_excluding_1.cards.count).to eq 48 }
      it "doesn't include the excluded_rank in deck" do
        expect(deck_excluding_1.map(&:to_i)).not_to include(5)
        expect(deck_excluding_1.cards.count).to eq 48
      end
      # Remove two card ranks from deck
      it('initializes 44 cards') { expect(deck_excluding_2.cards.count).to eq 44 }
      it "doesn't include the excluded_rank in deck" do
        expect(deck_excluding_2.map(&:to_i)).not_to include(5)
        expect(deck_excluding_2.map(&:to_i)).not_to include(7)
      end
      # Remove three card ranks from deck, including 2 picture cards
      it('initializes 40 cards') { expect(deck_excluding_3.cards.count).to eq 40 }
      it "doesn't include the excluded_rank in deck" do
        expect(deck_excluding_3.map(&:to_i)).not_to include(5)
        expect(deck_excluding_3.map(&:to_i)).not_to include(11)
        expect(deck_excluding_3.map(&:to_i)).not_to include(14)
      end
    end
  end

  describe 'excluded singular cards' do
    let (:five_spades) { Card.new(5,'Spades') }
    let (:jack_hearts) { Card.new('Jack','Hearts') }
    let (:ace_diamonds) { Card.new('Ace','Diamonds') }
    let (:deck_excluding_1_card) { Deck.new(exclude_cards: [five_spades]) }
    let (:deck_excluding_2_cards) { Deck.new(exclude_cards: [five_spades, jack_hearts]) }
    let (:deck_excluding_3_cards) { Deck.new(exclude_cards: [five_spades, jack_hearts, ace_diamonds]) }

    describe '#initialize' do
      # Remove one card from deck
      it('initializes 51 cards') { expect(deck_excluding_1_card.cards.count).to eq 51 }
      it "doesn't include the 5 Spades in deck" do
        expect(deck_excluding_1_card.map(&:short)).not_to include(five_spades.short)
      end

      # Remove two cards from deck
      it('initializes 50 cards') { expect(deck_excluding_2_cards.cards.count).to eq 50 }
      it "doesn't include the excluded_cards in deck" do
        expect(deck_excluding_2_cards.map(&:short)).not_to include(five_spades.short)
        expect(deck_excluding_2_cards.map(&:short)).not_to include(jack_hearts.short)
      end
      # Remove three cards from deck, including 2 picture cards
      it('initializes 49 cards') { expect(deck_excluding_3_cards.cards.count).to eq 49 }
      it "doesn't include the excluded_rank in deck" do
        expect(deck_excluding_3_cards.map(&:short)).not_to include(five_spades.short)
        expect(deck_excluding_3_cards.map(&:short)).not_to include(jack_hearts.short)
        expect(deck_excluding_3_cards.map(&:short)).not_to include(ace_diamonds.short)
      end
    end
  end

  describe 'exclude suit' do
    let (:deck_excluding_1_suit) { Deck.new(exclude_suit: ['Hearts']) }
    let (:deck_excluding_2_suits) { Deck.new(exclude_suit: ['Hearts', 'Spades']) }
    let (:jack_hearts) { Card.new('Jack','Hearts') }
    let (:five_spades) { Card.new(5,'Spades') }

    describe '#initialize' do
      # Remove one suit deck
      it('initializes 39 cards') { expect(deck_excluding_1_suit.cards.count).to eq 39 }
      it('does not include the Jack Hearts in deck') { expect(deck_excluding_1_suit.map(&:short)).not_to include(jack_hearts.short) }
    end

    # Remove two suits from deck
    it('initializes 26 cards') { expect(deck_excluding_2_suits.cards.count).to eq 26 }
    it "doesn't include the excluded suits in deck" do
      expect(deck_excluding_2_suits.map(&:short)).not_to include(five_spades.short)
      expect(deck_excluding_2_suits.map(&:short)).not_to include(jack_hearts.short)
    end
  end

    describe 'various options and combinations' do
    let (:five_spades) { Card.new(5,'Spades') }
    let (:jack_hearts) { Card.new('Jack','Hearts') }
    let (:deck_2_decks) { Deck.new(number_decks: 2) }
    let (:deck_2_decks_excluding_2_ranks) { Deck.new(number_decks: 2, exclude_rank: [5, 'Jack']) }
    let (:deck_2_decks_excluding_2_cards) { Deck.new(number_decks: 2, exclude_cards: [five_spades, jack_hearts]) }
    let (:deck_2_decks_excluding_2_suits) { Deck.new(number_decks: 2, exclude_suit: ['Hearts', 'Spades']) }
    let (:deck_2_decks_excluding_1_rank_2_cards) { Deck.new(number_decks: 2, exclude_rank: [3], exclude_cards: [five_spades, jack_hearts]) }
    let (:deck_2_decks_excluding_1_rank_1_suit_2_cards) { Deck.new(number_decks: 2, exclude_rank: [3], exclude_suit: ['Hearts'], exclude_cards: [five_spades, jack_hearts]) }

    context 'multiple_decks' do
      it('initializes 104 cards') { expect(deck_2_decks.cards.count).to eq 104 }
      it('unique of decks should be 52') {expect(deck_2_decks.cards.map(&:short).uniq.count).to eq 52}
    end

    context 'multiple_decks and excluded ranks' do
      it('initializes 88 cards') { expect(deck_2_decks_excluding_2_ranks.cards.count).to eq 88 }
      it('unique of decks should be 48') {expect(deck_2_decks_excluding_2_ranks.cards.map(&:short).uniq.count).to eq 44}
    end

    context 'multiple_decks and excluded cards' do
      it('initializes 100 cards') { expect(deck_2_decks_excluding_2_cards.cards.count).to eq 100 }
      it('unique of decks should be 50') {expect(deck_2_decks_excluding_2_cards.cards.map(&:short).uniq.count).to eq 50}
    end

    context 'multiple_decks and excluded suits' do
      it('initializes 52 cards') { expect(deck_2_decks_excluding_2_suits.cards.count).to eq 52 }
      it('unique of decks should be 26') {expect(deck_2_decks_excluding_2_suits.cards.map(&:short).uniq.count).to eq 26}
      it('should not include the 5 of spades' ) {expect(deck_2_decks_excluding_2_suits.map(&:short)).not_to include(five_spades.short)}
      it('should not include the Jack of Hearts' ) {expect(deck_2_decks_excluding_2_suits.map(&:short)).not_to include(jack_hearts.short)}
    end

    context 'multiple_decks, 1 excluded rank and 2 excluded cards' do
      it('initializes 92 cards') { expect(deck_2_decks_excluding_1_rank_2_cards.cards.count).to eq 92 }
      it('unique of decks should be 46') {expect(deck_2_decks_excluding_1_rank_2_cards.cards.map(&:short).uniq.count).to eq 46}
      it('should not include the 5 of spades' ) {expect(deck_2_decks_excluding_1_rank_2_cards.map(&:short)).not_to include(five_spades.short)}
      it('should not include the Jack of Hearts' ) {expect(deck_2_decks_excluding_1_rank_2_cards.map(&:short)).not_to include(jack_hearts.short)}
    end

    context 'multiple_decks, 1 excluded rank, 1 excluded suit and 2 excluded cards' do
      it('initializes 70 cards') { expect(deck_2_decks_excluding_1_rank_1_suit_2_cards.cards.count).to eq 70 }
      it('unique of decks should be 35') {expect(deck_2_decks_excluding_1_rank_1_suit_2_cards.cards.map(&:short).uniq.count).to eq 35}
      it('should not include the 5 of spades' ) {expect(deck_2_decks_excluding_1_rank_1_suit_2_cards.map(&:short)).not_to include(five_spades.short)}
      it('should not include the Jack of Hearts' ) {expect(deck_2_decks_excluding_1_rank_1_suit_2_cards.map(&:short)).not_to include(jack_hearts.short)}
    end
  end
end
