class WorkflowsController < ApplicationController
  before_action :set_workflows_and_task, only:[:create, :show, :update, :activate]
  before_action :set_workflow, only: [:show, :update, :completion, :destroy]

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
    respond_to do |format|
      format.html { render 'dashboard/index' }
    end
  end

  def search
    sql_query = " \
        workflows.title @@ :query \
        "
        # OR workflows.user.first_name @@ :query \
        # OR workflows.user.last_name @@ :query \
    @workflows = Workflow.where(sql_query, query: "%#{params[:query]}%")

    render 'dashboard/index'
  end

  def update
    @workflow = Workflow.find(params[:id])
    @workflow.update(restful_workflow_params) # updates title

    render 'dashboard/index'
  end

  def activate
    workflow_params = JSON.parse(request.body.read)
    @workflow = Workflow.find(workflow_params['workflowId'])
    if @workflow.activated?
      @workflow.deactivate
    else
      @workflow.activate
      update_first_task_as_current(@workflow)
    end

    respond_to do |format|
      # format.text { render 'dashboard/index', formats: [:html] }
      format.text { render partial: 'workflows/workflow_content', locals: { workflow: @workflow }, formats: [:html] }
    end
  end

  def completion
    respond_to do |format|
      format.text { render partial: 'workflows/workflow_status', locals: { workflow: @workflow }, formats: [:html] }
    end
    # not returning the correct status
  end

  def destroy
    @workflow.destroy unless @workflow.activated?

    redirect_to dashboard_path
  end

  private

  def restful_workflow_params
    params.require(:workflow).permit(:title)
  end

  def set_workflow
    @workflow = Workflow.find(params[:id])
  end

  def set_workflows_and_task
    @workflows = Workflow.where(creator_id: current_user.id).reverse_order
    @task = Task.new
  end

  def update_first_task_as_current(workflow)
    # first_task = workflow.tasks.first
    # if first_task.pending? # setting workflow.uncomplete in tasks#create instead
    #   first_task.set_current # waiting to set completion check when deleting task
    # end

    workflow.tasks.each do |task|
      if task.completed? && task.lower_item.nil?
        workflow.complete
      elsif task.first? && !task.completed?
        task.set_current
        workflow.uncomplete
      elsif !task.completed?
        workflow.uncomplete
        unless task.higher_item.nil?
          task.set_current if task.higher_item.completed?
        end
      end
    end
  end
end
