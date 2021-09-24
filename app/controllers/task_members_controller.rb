class TaskMembersController < ApplicationController
  def new
    @task_member = TaskMember.new
    # member id required (get from dropdown selection)
    @task = Task.find(params[:task_id])
    respond_to do |format|
      format.html
      format.text { render partial: 'items/itemform',locals: { item: @item, task: @task }, formats: [:html] }
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to dashboard_path
    else
      redirect_to dashboard_path
    end
  end

  private

  def task_member_params
    params.require(:task_member).permit(:user_id, :task_id)
  end
end
