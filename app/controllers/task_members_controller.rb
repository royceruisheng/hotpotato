class TaskMembersController < ApplicationController

  def new
    task_members = Task.find(params['task_id']).users
    @members = User.all.reject { |user| task_members.include?(user) }

    respond_to do |format|
      format.text { render partial: 'members/members_to_add', locals: { members: @members }, formats: [:html] }
    end
  end

  def create
    member = JSON.parse(request.body.read)
    new_task_member = TaskMember.new(task_id: member['task_id'], user_id: member['member_id'])
    user = User.find(member['member_id'])

    if new_task_member.save
      respond_to do |format|
        format.text { render partial: 'tasks/task_member', locals: { member: user }, formats: [:html] }
      end
    end
    # will not return if save is false(thus preventing errors)
  end

  private

end
