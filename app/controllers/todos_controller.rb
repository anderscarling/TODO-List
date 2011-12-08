class TodosController < AuthenticatedUserController

  # List todos for current user
  def index
    render_index(Todo.new)
  end

  # Create a new todo for current user
  def create
    todo         = Todo.new(params[:todo], as: :user)
    todo.user_id = current_user.id
    todo.save ? redirect_to(todos_path) : render_index(todo)
  end

  # Update todo (AJAX only)
  def update
    respond_to { |format| format.js {
      current_user.todos.find(params[:id]).update_attributes!(params[:todo], as: :user)
      head :ok
    } }
  end

  private
  def render_index(todo)
    @todo = todo

    @user  = current_user
    @todos = current_user.todos.not_done.order('created_at DESC')

    render :index
  end

end
