class TaskMember < ApplicationRecord
  belongs_to :task
  belongs_to :user

  validates :user, uniqueness: { scope: :task }

  def notifications
    UserMailer.with(user: user, task: task).email_notification.deliver_now
  end

end
