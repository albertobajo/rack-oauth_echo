require 'spec_helper'

describe Rack::OAuthEcho::Middleware, vcr: { record: :once } do
  
  def app
    app = lambda { |env| [200, {}, "Hello, World!"] }
    Rack::OAuthEcho::Middleware.new(app)
  end
    
  describe "OAuth Echo" do    
    context "valid headers" do    
      let(:headers) do
        method = :get
        uri = "https://api.twitter.com/1/account/verify_credentials.json"
        params = {}
        credentials = {
          consumer_key: "___",
          consumer_secret: "___",
          token: "___",
          token_secret: "___"
        }

        { 
          'X-Auth-Service-Provider' => 
            "https://api.twitter.com/1/account/verify_credentials.json",
          'X-Verify-Credentials-Authorization' =>
            SimpleOAuth::Header.new(method, uri, params, credentials).to_s
        }
      end
      
      before(:each) { get "/", {}, headers }

      it "should retrieve user_hash" do
        user_hash = last_request.env['rack-oauth_echo.user_hash']
        user_hash['id'].should eq(16893620)
        user_hash['screen_name'].should eq("albertobajo")
      end
    end
    
    context "without headers" do
      before(:each) { get "/" }

      it "should skip assignment" do
        last_request.env['rack-oauth_echo.user_hash'].should be_nil
      end
    end

    context "invalid headers" do
      let(:headers) do
        { 
          'X-Auth-Service-Provider' => 
            "https://api.twitter.com/1/account/verify_credentials.json",
          'X-Verify-Credentials-Authorization' => 'bad header'
        }
      end
      
      before(:each) { get "/", {}, headers }
      
      it "should return a 401 status" do
        last_response.status.should eq(401)
      end
      
      it "should return an error msg" do
        last_response.body.include?("Could not authenticate you.").
          should be_true
      end
        
    end
  end

end