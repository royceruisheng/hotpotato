class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :send_welcome_email

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
    case self.email
    when "royce@taskete.co"
      "bg-indigo-500"
    when "daniel@taskete.co"
      "bg-pink-500"
    when "ethan@taskete.co"
      "bg-blue-500"
    when "prima@taskete.co"
      "bg-red-500"
    when "ashley@taskete.co"
      "bg-purple-500"
    when "jianzhen@taskete.co"
      "bg-green-500"
    when "miguel@taskete.co"
      "bg-yellow-500"
    end
  end
end
