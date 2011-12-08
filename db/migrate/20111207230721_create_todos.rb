class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.belongs_to :user
      t.string     :note
      t.boolean    :done

      t.timestamps
    end

    add_index :todos, :user_id
  end
end
