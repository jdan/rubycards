$: << File.dirname(__FILE__)

require 'extensions/string'
require 'rubycards/card'
require 'rubycards/deck'
require 'rubycards/hand'

h = Hand.new
d = Deck.new

d.shuffle!

h.draw(d, 5)

puts h
