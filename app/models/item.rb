class Item < ApplicationRecord
  acts_as_list
  validates :title, presence: true
  belongs_to :task
  has_many :item_members, dependent: :destroy
end
