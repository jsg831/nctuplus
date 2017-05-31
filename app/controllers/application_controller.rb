class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Login session
  include SessionsHelper

  private
  # Redirect to login page if the user hasn't logged in.
  def logged_in_user
    unless logged_in?
      flash[:danger] = "請登入!"
      redirect_to login_url
    end
  end
end
