# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rack/oauth_echo/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alberto Bajo"]
  gem.email         = ["albertobajo@gmail.com"]
  gem.description   = %q{OAuth Echo authentication by rack middleware}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rack-oauth_echo"
  gem.require_paths = ["lib"]
  gem.version       = Rack::OAuthEcho::VERSION
  
  gem.add_dependency "faraday_middleware", "~> 0.8.8"
  gem.add_dependency "rack", "~> 1.4.1"
  
  gem.add_development_dependency "fakeweb", "~> 1.3.0"
  gem.add_development_dependency "json", "~> 1.7.4"
  gem.add_development_dependency "rack-test", "~> 0.6.1"
  gem.add_development_dependency "rspec", "~> 2.11.0"
  gem.add_development_dependency "simple_oauth", "~> 0.1.9"
  gem.add_development_dependency "spork", "~> 0.9.2"
  gem.add_development_dependency "vcr", "~> 2.2.4"
end
