require "rack/ensure_proper_host/version"

module Rack
  class EnsureProperHost
  
    def initialize(app, *hosts)
      @app = app
      @hosts = hosts.flatten
    end
  
    def call(env)
      @host = env['HTTP_HOST']    
      if @hosts.include?(@host)
        @app.call(env)
      else
        [ 301, request_with_proper_host(env), [ "Moved Permanently\n" ]]      
      end    
    end
  
    private
      
      def request_with_proper_host(env)
        req = Rack::Request.new(env)
        { 'Location' => req.url.sub(req.host, @hosts.first), 'Content-Type' => 'text/html' }
      end
  
  end
end
