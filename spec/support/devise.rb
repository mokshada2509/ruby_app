require 'devise'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, :type => :controller
  config.extend ControllerMacros, :type => :controller
 end