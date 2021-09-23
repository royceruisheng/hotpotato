class TasksController < ApplicationController
  def index
    @tasks = Task.all
    #change it to include task_id when task is connected

    respond_to do |format|
      format.html
      format.text { render partial: @tasks, formats: [:html] }
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
    @task = Task.new(task_params)
    if @task.save
      redirect_to dashboard_path
    else
      redirect_to dashboard_path
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :workflow_id)
  end
end
