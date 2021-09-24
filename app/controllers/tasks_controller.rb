class TasksController < ApplicationController
  def index
    @workflow = Workflow.find(params[:workflow_id])
    @tasks = @workflow.tasks
    #change it to include task_id when task is connected

    respond_to do |format|
      format.text { render partial: 'tasks', locals: { tasks: @tasks, workflow: @workflow }, formats: [:html] }
    end
  end

  def new
    @task = Task.new
    respond_to do |format|
      format.html
      format.text { render partial: 'tasks/taskform',locals: { task: @task }, formats: [:html] }
    end
  end

  def create
    task_params = JSON.parse(request.body.read)
    @task = Task.new
    @task.title = task_params['taskTitle']
    @task.workflow = Workflow.find(task_params['workflowId'])

    if @task.save
      respond_to do |format|
        format.html
        format.text { render partial: 'tasks/task', locals: { task: @task }, formats: [:html] }
      end
    end
  end

  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.text { render partial: 'items/task_items', locals: { items: @task.items, task: @task }, formats: [:html] }
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :workflow_id)
  end
end
