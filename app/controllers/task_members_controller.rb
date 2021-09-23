class TaskMembersController < ApplicationController
  def create
    @task = Task.find(params[:task_id])
    @user = User.find(params[:user_id])
    @task_member = TaskMember.new
    
    redirect_to 
    if @task_member.save
      redirect_to dashboard_path(@user, @task)
    else
      render 'dashboard/index'
    end
  end

  private

  def task_member_params
    params.require(:task_member).permit(:user_id, :task_id)
  end
end
