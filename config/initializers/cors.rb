require '/home/vesko/.asdf/installs/ruby/3.3.0/lib/ruby/gems/3.3.0/gems/rack-cors-2.0.1/lib/rack/cors.rb'

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
