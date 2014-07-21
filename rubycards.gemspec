# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubycards/version'

Gem::Specification.new do |gem|
  gem.name          = "rubycards"
  gem.version       = RubyCards::VERSION
  gem.authors       = ["Jordan Scales", "Joe Letizia", "Justin Workman"]
  gem.email         = ["scalesjordan@gmail.com", "joe.letizia@gmail.com", "xtagon@gmail.com"]
  gem.description   = "RubyCards"
  gem.licenses      = ["MIT"]
  gem.summary       = "A 52 card gem"
  gem.homepage      = "https://github.com/jdan/rubycards"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('colored', '~> 1.2')
end
