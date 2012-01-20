# Rack::EnsureProperHost [![Build Status](https://secure.travis-ci.org/citrus/rack-ensure_proper_host.png)](http://travis-ci.org/citrus/rack-ensure_proper_host)

Inspired by [rack-no-www](https://github.com/logicaltext/rack-no-www).

------------------------------------------------------------------------------
Usage
------------------------------------------------------------------------------

All of these examples will redirect all requests from *.example.com to example.com. Requests to secure.example.com will remain untouched.

Rack::EnsureProperHost is middleware. Use it like this in your rack applications:


### Rails

```ruby
# config/application.rb
module MyApp
  class Application < Rails::Application

    config.middleware.insert_before Rack::Lock, Rack::EnsureProperHost, %w(example.com secure.example.com)
        
  end
end
```

### Sinatra

```ruby
require 'sinatra'
require 'rack/ensure_proper_host'

use Rack::EnsureProperHost, %w(example.com secure.example.com)

get '/hello' do
  'Hello World'
end
```

### Rack 

Add the following to your `config.ru`

```ruby
# config.ru
require 'your_app.rb'
require 'rack/ensure_proper_host'

use Rack::EnsureProperHost, %w(example.com secure.example.com)
run YourApp.new
```



------------------------------------------------------------------------------
Installation
------------------------------------------------------------------------------

As usual, just use the `gem install` command:

```bash
(sudo) gem install rack-ensure_proper_host
```
    
Or add Rack::EnsureProperHost as a gem in your Gemfile:

```bash
gem 'rack-ensure_proper_host', '~> 0.1.0' 
```

Then run `bundle install`


------------------------------------------------------------------------------
Testing
------------------------------------------------------------------------------

Testing is done with minitest. Run the tests with:

```bash
rake
```
    

------------------------------------------------------------------------------
Changelog
------------------------------------------------------------------------------

**2012/1/20 - v0.1.0**

- it exists!
  

------------------------------------------------------------------------------
License
------------------------------------------------------------------------------

Copyright (c) 2011 - 2012 Spencer Steffen & Citrus, released under the New BSD License All rights reserved.
