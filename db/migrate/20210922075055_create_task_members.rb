class CreateTaskMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :task_members do |t|
      t.references :tasks, null: false, foreign_key: true
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
