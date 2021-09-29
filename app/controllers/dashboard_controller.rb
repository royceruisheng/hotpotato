class DashboardController < ApplicationController
  def index
    @workflows = current_user.workflows.limit(20).reverse_order
    @workflow = false # For workflow-content to display empty

    render 'dashboard/index'
  end

  def my_tasks
    @my_tasks = current_user.tasks.where(completed: 'current')
    @completed_tasks = current_user.tasks.where(completed: 'completed')

    render 'my_tasks/index'
  end
end
