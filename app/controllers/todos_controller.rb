class TodosController < AuthenticatedUserController

  # List todos for current user
  def index
    @user  = current_user
    @todos = ["De","bu","g"]
    render
  end

end
