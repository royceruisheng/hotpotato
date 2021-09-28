class TaskMembersController < ApplicationController

  def new
    @members = User.limit(10)

    respond_to do |format|
      format.text { render partial: 'members/members_to_add', locals: { members: @members }, formats: [:html] }
    end
  end

  def create
    member = JSON.parse(request.body.read)
    new_task_member = TaskMember.new(task_id: member['task_id'], user_id: member['member_id'])
    user = User.find(member['member_id'])

    respond_to do |format|
      if new_task_member.save
        format.text { render partial: 'tasks/task_member', locals: { member: user }, formats: [:html] }
      else
        format.html { redirect_to 'dashboard/index' }
      end
    end
  end

  private
end
