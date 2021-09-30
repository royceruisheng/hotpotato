class DashboardController < ApplicationController
  before_action :set_my_tasks, only: [:my_tasks]

  def index
    @workflows = current_user.workflows.limit(20).reverse_order
    @workflow = false # For workflow-content to display empty

    render 'dashboard/index'
  end

  def my_tasks
    @completed_tasks = current_user.tasks.where(completed: 'completed')

    render 'my_tasks/index'
  end

  private

  def set_my_tasks
    @my_tasks = current_user.my_tasks
  end
end
