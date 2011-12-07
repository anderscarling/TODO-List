class ApplicationController < ActionController::Base
  protect_from_forgery

  # Authentication Module
  include UserAuth
end
