class SessionsController < ApplicationController

  # Create a session from the data in the omniauth hash
  def create
    login User.create_from_auth_hash!(env['omniauth.auth'])
    redirect_to(todos_path)
  end

  def destroy
    logout
    redirect_to(root_path)
  end

end
