require '../rubycards/card.rb'

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
        new_card.rank.should == 3
        new_card.suit.should == 'Spades'
    end
  end
end