class TaskMembersController < ApplicationController
  
  def new
    @members = User.limit(10)

    respond_to do |format|
      format.text { render partial: 'members/members_to_add', locals: { members: @members }, formats: [:html] }
    end
  end

  def create
    member = JSON.parse(request.body.read)
    new_member = TaskMember.new(task_id: member['task_id'], user_id: member['member_id'])

    respond_to do |format|
      if new_member.save
        format.text { }
      else
        format.text { redirect_to 'dashboard/index' }
      end
    end
  end

  private
end
