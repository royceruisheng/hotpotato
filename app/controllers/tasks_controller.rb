class TasksController < ApplicationController
<<<<<<< HEAD
  before_action :set_task, only: [:show, :update, :completed]
=======
  before_action :set_task, only: [:show, :completed, :show_mytask]
>>>>>>> 5877c07 (displays next task)

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
      @task.workflow.uncomplete

      respond_to do |format|
        format.html
        format.text { render partial: 'tasks/new_task', locals: { task: @task, workflow: @task.workflow }, formats: [:html] }
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

<<<<<<< HEAD
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

=======
  def show_mytask # my individual task
    next_task_position = @task.position + 1
    @next_task = @task.workflow.tasks.find_by(position: next_task_position)

    respond_to do |format|
      format.text { render partial: 'my_tasks/my_task_content', locals: { task: @task, next_task: @next_task }, formats: [:html] }
    end
  end

<<<<<<< HEAD
>>>>>>> 0cad269 (no click selected tabs again)
  def completed
=======
  def completed # should change to complete_task (many complete funcs arnd)
>>>>>>> 5877c07 (displays next task)
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
