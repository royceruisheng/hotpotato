class DashboardController < ApplicationController
  before_action :set_my_tasks, only: [:my_tasks]
  before_action :user_sign_in, only: [:index, :my_tasks]

  def index
    @workflows = current_user.workflows.limit(20).reverse_order
    @workflow = false # For workflow-content to display empty

    render 'dashboard/index'
  end

  def my_tasks
    if @task = @my_tasks.first
      @next_task = @task.lower_item
    end

    @completed_tasks = current_user.tasks.where(completed: 'completed')

    render 'my_tasks/index'
  end

  private

  def set_my_tasks
    @my_tasks = current_user.my_tasks
  end

  def user_sign_in
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
