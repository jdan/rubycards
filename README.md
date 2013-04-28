# Rubycards

[![Build Status](https://travis-ci.org/prezjordan/rubycards.png)](https://travis-ci.org/prezjordan/rubycards) [![Coverage Status](https://coveralls.io/repos/prezjordan/rubycards/badge.png?branch=master)](https://coveralls.io/r/prezjordan/rubycards)

Rubycards is a library to emulate playing cards (cards, hands, decks). As an added bonus, you can display the cards as tiny pictures. I'm mainly doing this as an exercise to learn better Ruby organization, as well as documentation and testing. More importantly it's just fun.

Feel free to peek around my code and point out anything I'm bad at.

![rubycards](http://jordanscales.com/rubycards.png)

## Installation

Add this line to your application's Gemfile:

    gem 'rubycards'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubycards

## Example

Here's a trivial example of declaring a new deck, shuffling, and drawing 5 cards into a hand:

```ruby
require 'rubycards'
include RubyCards

hand = Hand.new
deck = Deck.new

deck.shuffle!

hand.draw(deck, 5)

puts hand
```

Which produces the image at the top of this README.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
