class CreateWorkflows < ActiveRecord::Migration[6.1]
  def change
    create_table :workflows do |t|
      t.string :title
      t.text :description
      t.boolean :activated
      t.boolean :template
      t.references :creator, foreign_key: { to_table: 'users' }, index: true

      t.timestamps
    end
  end
end
