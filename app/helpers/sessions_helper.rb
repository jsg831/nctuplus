module SessionsHelper
  # Log in the user
  def log_in(user)
    session[:uid] = user.id
  end

  # Log out the user
  def log_out
    session.delete(:uid)
    @current_user = nil
  end

  # logged-in user
  def current_user
    # if @current_user is nil, then find the user first
    @current_user ||= User.find_by(id: session[:uid])
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user?(user)
    user == current_user
  end
end
