class Task < ApplicationRecord
  validates :title, presence: true

  belongs_to :workflow
  # has_many :task_members, dependent: :destroy
  has_many :items, dependent: :destroy
  has_rich_text :content

end
