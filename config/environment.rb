# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
RemindavaxPilot::Application.initialize!

Rails.logger = Log4r::Logger.new("Application Log")
