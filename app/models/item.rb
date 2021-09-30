class Item < ApplicationRecord
  # after_commit :async_update
  acts_as_list scope: :task
  belongs_to :task

  validates :title, presence: true
  has_many :item_members, dependent: :destroy

  # def async_update
  #   # UpdateItemJob.perform_later(self)
  # end
end
