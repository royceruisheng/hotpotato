class UserItem < ApplicationRecord
  belongs_to :item
  validates :user, uniqueness: { scope: :item }
  belongs_to :user
end
