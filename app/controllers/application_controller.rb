class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Login session
  include SessionsHelper
end
