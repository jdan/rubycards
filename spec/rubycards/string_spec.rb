require 'spec_helper'

include RubyCards

describe String do
  describe '#next' do
    context 'one liners' do
      # cat <- dog == catdog
      it 'should concatenate strings' do
        expect('cat'.next('dog')).to eq 'catdog'
      end

      # hello <- "" == hello
      it 'should remain unchanged' do
        expect('hello'.next('')).to eq 'hello'
      end

      # "" <- hello == ""
      it 'should return an empty string' do
        expect(''.next('hello')).to eq ''
      end
    end

    context 'multiple lines' do
      # aa    bb    aabb
      # aa <- bb == aabb
      it 'should place blocks adjacently' do
        expect("aa\naa".next("bb\nbb")).to eq "aabb\naabb"
        expect("aaa\naaa\naaa".next("bbb\nbbb\nbbb")).to eq "aaabbb\naaabbb\naaabbb"
      end

      # aa    bb    aabb
      # aa <-    == aa
      it 'should stack the second block in its entirety' do
        expect("aa\naa".next("bb")).to eq "aabb\naa"
        expect("1\n2\n3".next("4\n5")).to eq "14\n25\n3"
      end

      # aa    bb    aabb
      #    <- bb ==
      it 'should cut off some of the second block' do
        expect("aa".next("bb\nbb")).to eq "aabb"
        expect("1\n2".next("4\n5\n6")).to eq "14\n25"
      end
    end
  end

end
