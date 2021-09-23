class CreateTaskMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :task_members do |t|
      t.references :task, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
