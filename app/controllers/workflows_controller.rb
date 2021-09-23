class WorkflowsController < ApplicationController
  before_action :set_workflow, only: [:show, :edit, :update, :destroy]

  def index
    @workflow = Workflow.all # singular??
  end

  def new
    @workflow = Workflow.new
    # is activated false set here?
    # is template even set?
  end

  def create
    new_workflow = Workflow.new(users_id: current_user.id, title: 'New Workflow')
    new_workflow.save
    redirect_to dashboard_path
  end

  def update
    @workflow.update(params[:workflow])
  end

  def destroy
    @wirkflow.destroy
    redirect_to dashboard_path
  end

  private

  def set_workflow
    @workflow = Workflow.find(params[:id])
  end

  # def workflow_params
  #   params.require(:workflow).permit(:title, :description, :users_id)
  # end
end
