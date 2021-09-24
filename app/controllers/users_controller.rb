class UsersController < ApplicationController
  def show_friends
    @members = User.limit(10)

    respond_to do |format|
      format.text { render partial: 'members/members', locals: { members: @members }, formats: [:html] }
    end
  end
end
