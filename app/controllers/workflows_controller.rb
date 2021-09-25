class WorkflowsController < ApplicationController

  def create
    set_workflows_and_task
    @new = true

    title_check = Workflow.where(title: 'New Workflow')
    title = title_check[0] ? "#{title_check[0].title} copy" : 'New Workflow'

    new_workflow = Workflow.new(title: title)
    new_workflow.creator = current_user
    new_workflow.save

    respond_to do |format|
      format.html redirect_to workflows_path(new_workflow)
      format.text { render partial: 'shared/workflow_tab', locals: { workflow: new_workflow }, formats: [:html] }
    end
  end

  def show
    set_workflows_and_task

    @workflow = Workflow.find(params[:id])

    respond_to do |format|
      format.html { render 'dashboard/index' }
    end
  end

  def update
    set_workflows_and_task

    @workflow = Workflow.find(params[:id])
    @workflow.update(workflow_params)

    render 'dashboard/index'
  end

  private

  def workflow_params
    params.require(:workflow).permit(:title)
  end

  def set_workflows_and_task
    @workflows = Workflow.limit(20).reverse_order
    @task = Task.new
  end
end
