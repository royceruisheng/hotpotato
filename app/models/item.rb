class Item < ApplicationRecord
  # after_commit :async_update
  acts_as_list
  validates :title, presence: true
  belongs_to :task
  has_many :item_members, dependent: :destroy

  # def async_update
  #   # UpdateItemJob.perform_later(self)
  # end
end
