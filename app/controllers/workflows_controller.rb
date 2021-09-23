class WorkflowsController < ApplicationController

  def create
    new_workflow = Workflow.new(users_id: current_user.id, title: 'New Workflow')
    new_workflow.save
    redirect_to dashboard_path
  end

end
