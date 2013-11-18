Ladder::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Output buffer in console when running foreman
  $stdout.sync = true

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.eager_load = 

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Expands the lines which load the assets
  config.assets.debug = true

  # Avoid serving precompiled assets
  config.serve_static_assets = false
  
  config.action_mailer.default_url_options = { :host => 'localhost:5000' }

  # User Letter Opener to preview emails in the browser instead of sending them via SMTP
  config.action_mailer.delivery_method = :letter_opener
end
