class WorkflowsController < ApplicationController

  def create
    title_check = Workflow.where(title: 'New Workflow')
    title = title_check[0] ? "#{title_check[0].title} copy" : 'New Workflow'

    new_workflow = Workflow.new(title: title)
    new_workflow.creator = current_user
    new_workflow.save

    respond_to do |format|
      format.html { redirect_to workflow_path(new_workflow) }
      format.text { render partial: 'shared/workflow', locals: { workflow: new_workflow }, formats: [:html] }
    end
  end

  def show
    @workflows = Workflow.limit(20).reverse_order
    @workflow = Workflow.find(params[:id])

    respond_to do |format|
      format.html { render 'dashboard/index' }
    end
  end
end
