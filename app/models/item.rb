class Item < ApplicationRecord
  validates :title, presence: true
  belongs_to :tasks
  has_many :item_members, dependent: :destroy
end
