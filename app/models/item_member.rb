class ItemMember < ApplicationRecord
  belongs_to :items
  belongs_to :users
end
