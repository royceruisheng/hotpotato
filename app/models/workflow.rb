class Workflow < ApplicationRecord
  # after_commit :async_update
  validates :title, presence: true

  belongs_to :creator, class_name: "User"

  has_many :tasks, dependent: :destroy
  has_many :items, through: :tasks

  def activated?
    self.activated
  end

  def activate
    self.update(activated: true)
  end

  def deactivate
    self.update(activated: false)
  end

  def completed?
    self.completed
  end

  def complete
    self.update(completed: true)
  end

  def uncomplete
    self.update(completed: false)
  end

  # def async_update
  #   UpdateWorkflowJob.perform_later(self)
  # end
end
