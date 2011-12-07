# Authentication Module, included in ApplicationController
module UserAuth
  # Before Filter used for authentication
  def authenticate!
    redirect_to(root_path) unless logged_in?
  end

  def current_user
    # No real need to cache with ||= since we only create the object in memory
    User.create_from_session(session)
  end

  def logged_in?
    current_user
  end

  def login(user)
    reset_session # make sure to reset session before login
    user.store_in_session(session)
  end

  def logout
    reset_session
  end
end
