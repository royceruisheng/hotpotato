class NotificationsController < ApplicationController

  def email_notification
    @task = Task.find(params[:task_id])
    notification = TaskNotification.with(task: @task)
    notification.deliver_later(@task.users)
    respond_to do |format|
      format.text { head :ok }
    end
  end
end
