class AddCheckToItem < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :checked, :boolean, default: false
  end
end
