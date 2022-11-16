class ApplicationController < ActionController::Base

  #c. r. r. l. l. l.

  skip_forgery_protection

  helper_method :current_user, :logged_in?

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def login(user)
    session[:session_token] = user.reset_session_token!
  end

  def loggout
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
  end


  def require_login
    redirect_to session_new_url unless current_user
  end

  def require_logout
    redirect_to users_url if current_user
  end






end
