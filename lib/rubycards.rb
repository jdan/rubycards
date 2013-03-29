$: << File.dirname(__FILE__)

require 'extensions/string'
require 'rubycards/card'
require 'rubycards/deck'
require 'rubycards/hand'

ranks = [*2..10, 'jack', 'queen', 'king', 'ace']
suits = %w{ clubs diamonds hearts spades }

h = Hand.new
5.times do
  h << Card.new(ranks.sample, suits.sample)
end

h.sort!
puts h
