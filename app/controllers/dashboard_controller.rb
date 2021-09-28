class DashboardController < ApplicationController
  def index
    @workflows = Workflow.limit(20).reverse_order
    @workflow = false # For workflow-content to display empty

    render 'dashboard/index'
  end

  def my_tasks
    @my_tasks = current_user.tasks.where(completed: 'current')

    render 'my_tasks/index'
  end
end
