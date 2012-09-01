# -*- encoding: utf-8 -*-
require File.expand_path('../lib/avalon/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ryo NAKAMURA"]
  gem.email         = ["r7kamura@gmail.com"]
  gem.description   = "Provide a simple validation method and validator class for Ruby"
  gem.summary       = "A validator implementation for Ruby"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "avalon"
  gem.require_paths = ["lib"]
  gem.version       = Avalon::VERSION

  gem.add_development_dependency "rspec"
end
