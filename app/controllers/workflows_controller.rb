class WorkflowsController < ApplicationController

  def create
    new_workflow = Workflow.new(title: 'New Workflow')
    new_workflow.creator = current_user
    new_workflow.save

    respond_to do |format|
      format.html { render 'dashboard/index' }
      format.text { render partial: 'shared/workflow', locals: { workflow: new_workflow } }
    end
  end

end
