class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # after_create :send_welcome_email # causing error

  # validates :email, presence: true
  # validates :first_name, presence: true
  # validates :last_name, presence: true

  has_one_attached :photo

  has_many :workflows, class_name: "Workflow", foreign_key: "creator_id"

  has_many :task_members, dependent: :destroy
  has_many :tasks, through: :task_members

  has_many :user_items, dependent: :destroy
  has_many :items, through: :user_items

  # has_many :item_members, dependent: :destroy
  # has_many :items, through: :item_members

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end

  def my_tasks
    self.tasks.where(completed: 'current')
  end

  # hard-coded. To be updated
  def color
    first_letter = self.first_name.first.downcase
    includes_letter = ->(array) { array.include?(first_letter) }

    if includes_letter.call(%w[a b c])
      'bg-indigo-500'
    # elsif ['d', 'e', 'f'].include?(first_letter)
    #   'bg-pink-500'
    # elsif ['d', 'e', 'f'].include?(first_letter)
    #   'bg-blue-500'
    # elsif ['d', 'e', 'f'].include?(first_letter)
    #   'bg-red-500'
    # elsif ['d', 'e', 'f'].include?(first_letter)
    #   'bg-purple-500'
    # elsif ['d', 'e', 'f'].include?(first_letter)
    #   'bg-green-500'
    # elsif ['d', 'e', 'f'].include?(first_letter)
    #   'bg-yellow-500'
    else
      'bg-gray-300'
    end
  end
end
