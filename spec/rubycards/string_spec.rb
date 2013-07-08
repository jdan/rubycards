require 'spec_helper'

include RubyCards

describe String do
  describe '#next' do
    context 'one liners' do
      # cat <- dog == catdog
      it 'should concatenate strings' do
        'cat'.next('dog').should == 'catdog'
      end

      # hello <- "" == hello
      it 'should remain unchanged' do
        'hello'.next('').should == 'hello'
      end

      # "" <- hello == ""
      it 'should return an empty string' do
        ''.next('hello').should == ''
      end
    end

    context 'multiple lines' do
      # aa    bb    aabb
      # aa <- bb == aabb
      it 'should place blocks adjacently' do
        "aa\naa".next("bb\nbb").should == "aabb\naabb"
        "aaa\naaa\naaa".next("bbb\nbbb\nbbb").should == "aaabbb\naaabbb\naaabbb"
      end

      # aa    bb    aabb
      # aa <-    == aa
      it 'should stack the second block in its entirety' do
        "aa\naa".next("bb").should == "aabb\naa"
        "1\n2\n3".next("4\n5").should == "14\n25\n3"
      end

      # aa    bb    aabb
      #    <- bb ==
      it 'should cut off some of the second block' do
        "aa".next("bb\nbb").should == "aabb"
        "1\n2".next("4\n5\n6").should == "14\n25"
      end
    end
  end

end