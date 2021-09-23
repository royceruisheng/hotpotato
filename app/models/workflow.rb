class Workflow < ApplicationRecord
  validates :title, presence: true

  belongs_to :users
  has_many :tasks, dependent: :destroy

end
