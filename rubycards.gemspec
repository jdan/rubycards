# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubycards/version'

Gem::Specification.new do |gem|
  gem.name          = "rubycards"
  gem.version       = Rubycards::VERSION
  gem.authors       = ["Jordan Scales","Joe Letizia"]
  gem.email         = ["joe.letizia@gmail.com"]
  gem.description   = "RubyCards"
  gem.summary       = "A 52 card gem."
  gem.homepage      = "https://github.com/prezjordan/rubycards"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
