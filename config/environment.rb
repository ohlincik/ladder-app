# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Ladder::Application.initialize!

# Specify ActionMailer sending defaults to use Sendgrid
ActionMailer::Base.smtp_settings = {
  :user_name => "perfectus",
  :password => "m249/rruQ7^U",
  :domain => "lecomladder.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
