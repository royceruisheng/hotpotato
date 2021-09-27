class Workflow < ApplicationRecord
  # after_commit :async_update
  validates :title, presence: true

  belongs_to :creator, class_name: "User"

  has_many :tasks, dependent: :destroy
  has_many :items, through: :tasks

  def activated?
    self.activated
  end

  # def async_update
  #   UpdateWorkflowJob.perform_later(self)
  # end
end
