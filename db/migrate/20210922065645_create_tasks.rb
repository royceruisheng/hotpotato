class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.boolean :completed
      t.integer :order
      t.string :title
      t.text :description
      t.references :workflows, null: false, foreign_key: true

      t.timestamps
    end
  end
end
