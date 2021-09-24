class TaskMembersController < ApplicationController
  def create
    @task = Task.find(params[:task_id])
    @user = User.find(params[:user_id])
    @task_member = TaskMember.new

    if @task_member.save
      redirect_to dashboard_path(@user, @task)
    else
      render 'dashboard/index'
    end

    # respond_to do |format|
    #   if @task_member.save
    #     format.html { redirect_to dashboard_path(@task_member) }
    #     format.json # Follow the classic Rails flow and look for a create.json view
    #   else
    #     format.html { render 'dashboards' }
    #     format.json # Follow the classic Rails flow and look for a create.json view
    #   end
    # end
  end

  private

  def task_member_params
    params.require(:task_member).permit(:user_id, :task_id)
  end
end
