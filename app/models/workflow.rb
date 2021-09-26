class Workflow < ApplicationRecord
  validates :title, presence: true

  belongs_to :creator, class_name: "User"

  has_many :tasks, dependent: :destroy
  has_many :items, through: :tasks

  def activated?
    self.activated
  end
end
