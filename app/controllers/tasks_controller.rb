class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :completed]

  def index
    @workflow = Workflow.find(params[:workflow_id])
    @tasks = @workflow.tasks
    @item = Item.new
    #change it to include task_id when task is connected

    respond_to do |format|
      format.text { render partial: 'tasks', locals: { tasks: @tasks, workflow: @workflow }, formats: [:html] }
    end
  end

  def create
    task_params = JSON.parse(request.body.read)
    @task = Task.new
    @task.title = task_params['taskTitle']
    @task.workflow = Workflow.find(task_params['workflowId'])
    @item = Item.new

    if @task.save
      respond_to do |format|
        format.html
        format.text { render partial: 'tasks/task', locals: { task: @task, workflow: @task.workflow }, formats: [:html] }
      end
    end
  end

  def show # my_tasks
    @workflow = Workflow.find(params['workflow_id'])

    @task_members = @task.users

    respond_to do |format|
      format.text { render partial: 'tasks/task_content', locals: { items: @task.items, task: @task, workflow: @workflow, task_members: @task_members }, formats: [:html] }
    end
  end

  def update
    @workflow = @task.workflow
    @workflows = @workflow.creator.workflows

    if @task.update(task_params)
      render 'dashboard/index'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.json { head :ok }
    end
  end

  private

  def completed
    @workflow = @task.workflow
    @tasks = @workflow.tasks
    @item = Item.new

    @task.set_completed

    if @task.lower_item.nil?
      @workflow.complete
    else
      @workflow.uncomplete
      @next_task = @task.lower_item
      @next_task.set_current
    end

    respond_to do |format|
      format.text { render partial: 'tasks', locals: { tasks: @tasks, workflow: @workflow }, formats: [:html] }
    end
  end


  def task_params
    params.require(:task).permit(:title, :description)
  end


  def set_task
    @task = Task.find(params[:id])
  end
end
