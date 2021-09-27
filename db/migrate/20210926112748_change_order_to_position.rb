class ChangeOrderToPosition < ActiveRecord::Migration[6.1]
  def change
    rename_column :tasks, :order, :position
    rename_column :items, :order, :position
  end
end
