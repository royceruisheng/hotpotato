class WorkflowsController < ApplicationController
  before_action :set_workflows_and_task, only:[:create, :show, :update, :activate]

  def create
    title_check = Workflow.where(title: 'New Workflow')
    title = title_check[0] ? "#{title_check[0].title} copy" : 'New Workflow'

    new_workflow = Workflow.new(title: title)
    new_workflow.creator = current_user
    new_workflow.save

    respond_to do |format|
      format.html { redirect_to workflow_path(new_workflow) }
      format.text { render partial: 'shared/workflow_tab', locals: { workflow: new_workflow }, formats: [:html] }
    end
  end

  def show
    @workflow = Workflow.find(params[:id])

    respond_to do |format|
      format.html { render 'dashboard/index' }
    end
  end

  def update
    @workflow = Workflow.find(params[:id])
    @workflow.update(workflow_params) # updates title

    render 'dashboard/index'
  end

  def activate
    workflow_params = JSON.parse(request.body.read)
    @workflow = Workflow.find(workflow_params['workflowId'])
    if @workflow.activated?
      @workflow.update(activated: false)
    else
      @workflow.update(activated: true)
      update_first_task_as_current(@workflow)
    end

    respond_to do |format|
      # format.text { render 'dashboard/index', formats: [:html] }
      format.text { render partial: 'workflows/workflow_content', locals: { workflow: @workflow }, formats: [:html] }
    end
  end

  def update_first_task_as_current(workflow)
    workflow.tasks.each do |task|
      if task.first? && task.completed == "pending"
        task.update(completed: "current")
      elsif task.completed == "completed" && task.lower_item.completed == "pending"
        task.lower_item.update(completed: "current")
      end
    end
  end

  private

  def workflow_params
    params.require(:workflow).permit(:title)
  end

  def set_workflows_and_task
    @workflows = Workflow.where(creator_id: current_user.id).reverse_order
    @task = Task.new
  end
end
