class AddCompletedToWorkflows < ActiveRecord::Migration[6.1]
  def change
    add_column :workflows, :completed, :boolean, default: false
    change_column :workflows, :activated, :boolean, default: false
  end
end
