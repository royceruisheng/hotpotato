# To deliver this notification:
#
# TaskNotification.with(task: @task).deliver_later(current_user)
# TaskNotification.with(task: @task).deliver(current_user)

class TaskNotification < Noticed::Base
  # Add your delivery methods
  #
  # deliver_by :database
  deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :task

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end


  #
  # def url
  #   task_path(params[:task])
  # end
end
