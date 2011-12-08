# Authentication Module, included in ApplicationController
module UserAuth
  # Before Filter used for authentication
  def authenticate!
    redirect_to(root_path) unless logged_in?
  end

  def current_user
    @current_user ||= User.find_from_session(session)
  end

  def logged_in?
    current_user
  end

  def login(user)
    reset_auth! # make sure to reset session before login
    user.store_in_session(session)
  end

  def logout
    reset_auth!
  end

  private
  def reset_auth!
    @current_user = nil
    reset_session
  end
end
