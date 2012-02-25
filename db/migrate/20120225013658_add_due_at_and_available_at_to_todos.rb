class AddDueAtAndAvailableAtToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :available_at, :date
    add_column :todos, :due_at,       :datetime
  end
end
