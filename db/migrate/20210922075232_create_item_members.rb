class CreateItemMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :item_members do |t|
      t.references :items, null: false, foreign_key: true
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
