require "bundler/setup"
require "minitest/autorun"
require "minitest/should"

require "rack/test"
require "rack/ensure_proper_host"

module Rack
  class EnsureProperHostTest < MiniTest::Should::TestCase
  
    include Rack::Test::Methods
    
    MockApp = lambda { |env| [200, {}, [ "Hello, world." ]] }  
    
    def request_with_host(host, path="/")
      request path, { "HTTP_HOST" => host }
    end
    
    context "When used to ensure specific hosts" do
    
      def allowed_hosts
        %w(www.example.org secure.example.org)
      end
      
      def app
        EnsureProperHost.new(MockApp, allowed_hosts)
      end
        
      should "redirect to default host" do
        request_with_host "example.org"
        follow_redirect!
        assert_equal "http://www.example.org/", last_request.url
        assert last_response.redirect?
      end
      
      should "redirect to default host for any non-allowed host" do
        %w(something.example.org omg.wtf.bbq.example.com www2.exmple.com wwww.example.com).each do |host|
          request_with_host host
          follow_redirect!
          assert_equal "http://www.example.org/", last_request.url
          assert last_response.redirect?
        end
      end
      
      should "redirect to default host and keep path" do
        request_with_host "example.org", "/some/crazy/path?wtf=1"
        follow_redirect!
        assert_equal "http://www.example.org/some/crazy/path?wtf=1", last_request.url
        assert last_response.redirect?
      end
      
      should "redirect and retain content type" do
        request_with_host "example.org", "/some/crazy/path"
        follow_redirect!
        assert_equal "text/html", last_response.headers['Content-Type']
      end
      
      should "redirect and return 301 move permanently" do
        request_with_host "example.org"
        follow_redirect!
        assert_equal 301, last_response.status
        assert_equal "Moved Permanently\n", last_response.body
      end
      
      should "serve all allowed hosts without redirecting" do
        allowed_hosts.each do |host|
          request_with_host host
          assert_equal "http://#{host}/", last_request.url
          assert last_response.ok?
        end
      end
      
    end
    
    context "When used as no-www middleware" do
      
      def app
        EnsureProperHost.new(MockApp, "example.org")
      end
      
      should "redirect to non-www host" do
        request_with_host "www.example.org"
        follow_redirect!
        assert_equal "http://example.org/", last_request.url
        assert last_response.redirect?
      end
      
      should "redirect to non-www host and keep path" do
        request_with_host "www.example.org", "/some/crazy/path?wtf=1"
        follow_redirect!
        assert_equal "http://example.org/some/crazy/path?wtf=1", last_request.url
        assert last_response.redirect?
      end
      
    end
    
  end
end
