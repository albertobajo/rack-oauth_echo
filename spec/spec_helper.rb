require 'rubygems'
require 'bundler/setup'
require 'spork'

require 'fakeweb'
require 'faraday_middleware'
require 'rack/test'
require 'rack/oauth_echo'
require 'simple_oauth'
require 'vcr'
  
Spork.prefork do  
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Dir.pwd << ("/spec/support/**/*.rb")].each {|f| require f}
    
  RSpec.configure do |c|
    c.include Rack::Test::Methods
    c.treat_symbols_as_metadata_keys_with_true_values = true
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

end