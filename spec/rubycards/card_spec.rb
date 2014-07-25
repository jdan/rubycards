require 'spec_helper'

include RubyCards

describe Card do
  describe '#initialize' do
    context 'no params' do
      it 'should return the ace of spades' do
        subject.suit.should == 'Spades'
        subject.rank.should == 'Ace'
      end
    end

    context 'params' do
      it 'should return the card specified in params' do
        new_card = Card.new('Queen', 'Clubs')
        new_card.rank.should == 'Queen'
        new_card.suit.should == 'Clubs'

        new_card = Card.new(3, 'Spades')
        new_card.rank.should == 3.to_s
        new_card.suit.should == 'Spades'

        new_card = Card.new('Jack', 'Diamonds')
        new_card.rank.should == 'Jack'
        new_card.suit.should == 'Diamonds'

        new_card = Card.new(7, 'Hearts')
        new_card.rank.should == 7.to_s
        new_card.suit.should == 'Hearts'
      end

      describe 'jokers' do
        it "should allow a third parameter to define the type of Joker" do
          red_joker = Card.new(nil, nil, 'Red')
          red_joker.joker.should == 'Red'

          black_joker = Card.new(nil, nil, 'Black')
          black_joker.joker.should == 'Black'
        end
      end
    end
  end

  describe '#comparator' do
    let (:king) { Card.new('King','Clubs') }
    let (:queen) { Card.new('Queen','Clubs') }
    let (:jack) { Card.new('Jack','Clubs') }
    let (:ace) { Card.new('Ace','Clubs') }
    let (:c2) { Card.new(2,'Diamonds') }
    let (:c2_heart) { Card.new(2,'Hearts') }
    let (:c4) { Card.new(4,'Spades') }

    it 'should reflect the correct rank when compared' do
      king.should > queen
      king.should > jack
      king.should == king
      king.should < ace

      jack.should_not > queen
      jack.should_not > ace
      jack.should < queen

      ace.should_not < queen
      ace.should > c4

      c2.should < c4
      c2_heart.should == c2
    end
  end

  describe '#rank' do
    context 'face cards' do
      let (:king) { Card.new('King', 'Clubs') }

      it 'should return a long rank' do
        king.rank.should == 'King'
      end

      it 'should return a short rank' do
        king.rank(true).should == 'K'
      end
    end

    context 'numeric cards' do
      let (:num) { Card.new(10, 'Diamonds') }

      it 'should have the same long and short rank' do
        num.rank.should == num.rank(true)
      end
    end

    context 'jokers' do
      let (:num) { Card.new(nil, nil, 'Red') }

      it "should return a long rank" do
        num.rank.should == 'Red Joker'
      end

      it "should return a short rank" do
        num.rank(true).should == 'Joker'
      end
    end
  end

  describe '#display' do
    BORDER_COUNT = 18 # the number of unicode characters on the border
    RANKS = [*2..10, 'Jack', 'Queen', 'King', 'Ace']

    it 'should have the correct number of glyps' do
      RANKS.each do |rank|
        card = Card.new(rank, 'hearts')   # rspec doesn't play nice with dark cards

        if (2..10).include? card.rank.to_i
          card.to_s.scan(/[^\x00-\x7F]/).count.should == card.rank.to_i + BORDER_COUNT
        else
          card.to_s.scan(/[^\x00-\x7F]/).count.should == 2 + BORDER_COUNT
        end
      end
    end

    it 'should display #inspect the same as #short' do
      RANKS.each do |rank|
        card = Card.new(rank, 'diamonds')

        card.inspect.should == card.short
      end
    end
  end

  describe '#garbage' do
    it 'should set a garbage rank to nil' do
      runt_card1 = Card.new(0, 'Diamonds')
      runt_card2 = Card.new(11, 'Diamonds')
      runt_card3 = Card.new(-6, 'Spades')

      runt_card1.rank.should be_nil
      runt_card2.rank.should be_nil
      runt_card3.rank.should be_nil
    end

    it 'should set a garbage suit to nil' do
      runt_card1 = Card.new(7, '')
      runt_card2 = Card.new('Ace', 'Garbage')

      runt_card1.suit.should be_nil
      runt_card2.suit.should be_nil
    end
  end

  describe '#joker' do
    it "should return true if the card is a joker" do
      card = Card.new(nil, nil, 'Red')
      card.joker?.should == true
    end

    it "should return false if the card is not a joker" do
      card = Card.new
      card.joker?.should == false
    end
  end

end
