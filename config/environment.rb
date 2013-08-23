# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
WelocoDevise::Application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
# ActionMailer::Base.default_charset = "utf-8"
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default :content_type => "text/html"

#ActionMailer::Base.smtp_settings = {
 #   :address              => "smtp.gmail.com",
  #  :port                 => 587,
   # :user_name 				=> "dharin.test@gmail.com",
   # :password 				=> "rubyonrails",
   # :authentication       => "plain",
   # :enable_starttls_auto => true
  #}
  ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 25,
  :domain => "heraldsolutions.in",
  :authentication => :plain,
  :user_name => "heraldsolutions.ahd@gmail.com",
  :password => "herald123",
  :enable_starttls_auto => true
}