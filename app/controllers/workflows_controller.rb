class WorkflowsController < ApplicationController

  def create
    new_workflow = Workflow.new(users_id: current_user.id, title: 'New Workflow')
    new_workflow.save
    @workflows = Workflow.limit(20)

    respond_to do |format|
      format.text { render 'shared/workflows_list', workflows: @workflows, formats: [:html] }
    end
  end

end
