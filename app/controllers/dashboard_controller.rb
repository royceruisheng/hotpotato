class DashboardController < ApplicationController
  def index

    @workflows = Workflow.limit(20).reverse_order
    @workflow = false

    @task_member = TaskMember.new #shift to show-workflow
    @task_members = TaskMember.limit(10)

  end
end
