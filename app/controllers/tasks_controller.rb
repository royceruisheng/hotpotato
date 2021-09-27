class TasksController < ApplicationController
  before_action :set_task, only: [:show, :completed]

  def index
    @workflow = Workflow.find(params[:workflow_id])
    @tasks = @workflow.tasks
    @item = Item.new
    #change it to include task_id when task is connected

    respond_to do |format|
      format.text { render partial: 'tasks', locals: { tasks: @tasks, workflow: @workflow }, formats: [:html] }
    end
  end

  # def new
  #   @task = Task.new
  #   respond_to do |format|
  #     format.html
  #     format.text { render partial: 'tasks/taskform',locals: { task: @task }, formats: [:html] }
  #   end
  # end

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

  def show
    @workflow = Workflow.find(params['workflow_id'])

    @task_members = @task.users

    respond_to do |format|
      format.text { render partial: 'tasks/task_content', locals: { items: @task.items, task: @task, workflow: @workflow, task_members: @task_members }, formats: [:html] }
    end
  end

  def update
    response = JSON.parse(request.body.read)
    @workflow = Workflow.find(params['workflow_id'])
    @task = Task.find(params[:id])
    @task.update(title: response['task_title'])

    respond_to do |format|
      # format.html { redirect_to dashboard_path }
      format.text { render partial: 'tasks/task', locals: { task: @task, workflow: @workflow }, formats: [:html] }
    end
  end

  private

  def completed
    @task.update(completed: "completed")
    unless @task.lower_item.nil?
      @next_task = @task.lower_item
      @next_task.update(completed: "current")
    end
    
    @workflow = @task.workflow
    @tasks = @workflow.tasks
    @item = Item.new
    
    respond_to do |format|
      format.text { render partial: 'tasks', locals: { tasks: @tasks, workflow: @workflow }, formats: [:html] }
    end
  end
  
  # AJAX no need strict params
  # def task_params
  #   params.require(:task).permit(:title, :workflow_id, :content)
  # end


  def set_task
    @task = Task.find(params[:id])
  end
end
