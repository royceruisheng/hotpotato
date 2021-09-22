class Task < ApplicationRecord
  validates :title, presence: true

  belongs_to :workflows
  has_many :task_members, dependent: :destroy
  has_many :items, dependent: :destroy
end
