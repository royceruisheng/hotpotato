class Item < ApplicationRecord
  # after_commit :async_update
  acts_as_list scope: :task
  belongs_to :task, optional: true

  has_many :user_items, dependent: :destroy
  has_many :users, through: :user_items

  validates :title, presence: true
  has_many :item_members, dependent: :destroy

  # def async_update
  #   # UpdateItemJob.perform_later(self)
  # end
end
