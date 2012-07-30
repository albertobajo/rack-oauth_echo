require "rack/oauth_echo/version"

module Rack
  module OAuthEcho
    class Middleware
      def initialize(app)
        @app = app
      end
      
      def call(env)
        if auth_header?(env)
          json_response = auth_request(env)
          if json_response.status == 200
            env['rack-oauth_echo.user_hash'] = auth_request(env).body
            @app.call(env)
          else
            [json_response.status, {}, "Could not authenticate you."]
          end
        else
          @app.call(env)
        end
      end
      
      private

        def auth_header?(env)
          env.has_key?('X-Verify-Credentials-Authorization') ||
          env.has_key?('X-Auth-Service-Provider')
        end
        
        def auth_request(env)
          conn = Faraday.new do |conn|
            conn.response :json, :content_type => /\bjson$/
            conn.headers['Authorization'] =
              env['X-Verify-Credentials-Authorization']
            
            conn.adapter Faraday.default_adapter
          end
          
          conn.get env['X-Auth-Service-Provider']
        end
   
    end    
  end
end
