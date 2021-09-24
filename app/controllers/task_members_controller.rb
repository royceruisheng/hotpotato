class TaskMembersController < ApplicationController
  def new
    @task_member = TaskMember.new
    # member id required (get from dropdown selection)
    binding.pry
    @task = Task.find(params[:task_id])
    respond_to do |format|
      format.html
      format.text { render partial: 'items/itemform', locals: { item: @item, task: @task }, formats: [:html] }
    end
  end

  def create
    @user = User.find(params[:user_id])
    @task_member = TaskMember.new(task_member_params)
    respond_to do |format|
      if @task_member.save
        format.html { redirect_to dashboard_path(@user) }
        format.text 
      else
        format.html { render '/dashboard' }
        format.text
      end
    end
  end

  private

  def task_member_params
    params.require(:task_member).permit(:user_id, :task_id)
  end
end
