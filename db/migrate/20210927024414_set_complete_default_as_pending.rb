class SetCompleteDefaultAsPending < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :completed, :string, null: false, default: "pending"
  end
end
